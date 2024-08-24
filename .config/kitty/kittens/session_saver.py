import json
import os
import re
import subprocess

from typing import Any, Dict, List
from kitty.key_encoding import EventType, KeyEvent
from kitty.remote_control import create_basic_command, encode_send
from kitty.typing import ScreenSize
from kittens.tui.handler import Handler
from kittens.tui.line_edit import LineEdit
from kittens.tui.loop import Loop
from kittens.tui.operations import RESTORE_CURSOR, SAVE_CURSOR

# Configuration

SESSIONS_DIRECTORY = f"{os.path.expanduser('~')}/.config/kitty/sessions/"

###############################################################################

class SessionConverter():
    """Convert JSON dump to session file

    Based on https://github.com/dflock/kitty-save-session
    """

    def env_to_str(self, env):
        """Convert an env list to a series of '--env key=value' parameters and return as a string."""
        s = ""
        for key in env:
            if "kitty" in key.lower():
                continue
            s += f"--env {key}={env[key]} "

        return s.strip()

    def cmdline_to_str(self, cmdline):
        """Convert a cmdline list to a space separated string."""
        s = ""
        for e in cmdline:
            s += f"{e} "

        return s.strip()

    def fg_proc_to_str(self, fg):
        """Convert a foreground_processes list to a space separated string."""
        s = ""
        fg = fg[0]
        s += f"{self.cmdline_to_str(fg['cmdline'])}"

        if "from kittens.runner import main" in s.lower():
            return None
        return s

    def convert(self, session):
        """Convert a kitty session dict, into a kitty session file and output it."""
        content = ""
        first = True
        for os_window in session:
            if not os_window["is_focused"]:
                continue

            if first:
                first = False
            else:
                content += "\nnew_os_window\n\n"

            for tab in os_window["tabs"]:
                content += "\n\n"
                content += f"new_tab {tab['title']}\n"
                content += f"layout {tab['layout']}\n" 

                # if tab["windows"]:
                #     content += f"cd {tab['windows'][0]['cwd']}\n"

                for w in tab["windows"]:
                    content += f"cd {w['cwd']}\n"

                    env_vars = self.env_to_str(w['env'])
                    fg_proc = self.fg_proc_to_str(w['foreground_processes'])
                    if fg_proc == None:
                        continue

                    content += f"title {w['title']}\n"
                    content += f"launch {env_vars} {fg_proc}\n"

                    if w["is_focused"]:
                        content += "focus\n"

        return content

class SessionSaver(Handler):
    def __init__(self):
        super().__init__()
        self.ls_result = None
        self.session_content = None
        self.line_edit = LineEdit()

    def initialize(self) -> None:
        self.cmd.set_cursor_visible(False)
        ls = create_basic_command('ls', no_response=False)
        self.write(encode_send(ls))
        self.draw_screen()
        self.write(SAVE_CURSOR)

    def on_kitty_cmd_response(self, response: Dict[str, Any]) -> None:
        if not response.get("ok"):
            return

        data = response.get("data", "[]")
        self.ls_result = json.loads(data)
        self.session_content = SessionConverter().convert(self.ls_result)
        self.draw_screen()

    def on_key(self, key_event: KeyEvent) -> None:
        if key_event.type is EventType.RELEASE:
            return

        if key_event.matches('esc'):
            self.quit_loop(0)
            return
        if key_event.matches('enter'):
            session_name: str = self.line_edit.current_input
            session_name = session_name.strip()

            FILENAME_PATTERN = r'^[_a-zA-Z0-9]+$'
            if re.match(FILENAME_PATTERN, session_name):
                if self.session_content != None:
                    self.save_session(f"{session_name}.kitty", self.session_content)
                    self.quit_loop(0)
                    return

            self.write(RESTORE_CURSOR)
            self.print()
            self.print("***Invalid session name: Must consist of letters, numbers and underscores ONLY.***\n\n")

        if self.line_edit.on_key(key_event):
            self.commit_line()

    def commit_line(self) -> None:
        self.write(RESTORE_CURSOR + SAVE_CURSOR)
        self.cmd.clear_to_eol()
        self.line_edit.write(self.write, screen_cols=self.screen_size.cols)

    def on_resize(self, screen_size: ScreenSize) -> None:
        super().on_resize(screen_size)
        self.commit_line()

    def on_text(self, text: str, in_bracketed_paste: bool = False) -> None:
        self.line_edit.on_text(text, in_bracketed_paste)
        self.commit_line()

    def on_interrupt(self) -> None:
        self.line_edit.clear()
        self.commit_line()

    def print_keymap(self):
        self.print("[HELP]:")
        self.print("    ENTER  : Save session.")
        self.print("    ESC    : Exit.")

    def draw_screen(self) -> None:
        self.cmd.clear_screen()
        print = self.print

        print("Save New Session\n")
        print("Session File Preview:")

        if self.session_content == None:
            print("Loading...")
        else:
            print("-"*80)
            for line in self.session_content.split("\n"):
                print(line)
            print("-"*80)

        print("Enter Session Name: ", end="")
        self.write(SAVE_CURSOR)

        print()
        print("\n\n")
        self.print_keymap()

    def save_session(self, file_name: str, content: str):
        if not os.path.isdir(SESSIONS_DIRECTORY):
            os.mkdir(SESSIONS_DIRECTORY)

        file_path = SESSIONS_DIRECTORY + file_name
        with open(file_path, "w+") as f:
            f.write(content)

class SessionList(Handler):
    def __init__(self):
        super().__init__()
        self.session_list = []
        self.selected_session = 0

    def initialize(self) -> None:
        self.cmd.set_cursor_visible(False)
        self.list_sessions()
        self.draw_screen()

    def on_kitty_cmd_response(self, response: Dict[str, Any]) -> None:
        pass

    def on_key_event(self, key_event: KeyEvent) -> None:
        if key_event.type is EventType.RELEASE:
            return

        if key_event.matches('esc'):
            self.quit_loop(0)
            return
        if key_event.matches('enter'):
            if self.load_session():
                self.quit_loop(0)
                return

        if key_event.key == 'j':
            self.selected_session = (self.selected_session + 1) % len(self.session_list)
            self.draw_screen()
        elif key_event.key == 'k':
            self.selected_session = (self.selected_session - 1) % len(self.session_list)
            self.draw_screen()
        elif key_event.key == 'd':
            if self.delete_session():
                self.list_sessions()
                self.selected_session = 0
                self.draw_screen()

    def print_keymap(self):
        self.print("[HELP]:")
        self.print("    j/k    : Move selection UP/DOWN.")
        self.print("    d      : Delete selected session.")
        self.print("    ENTER  : Load selected session.")
        self.print("    ESC    : Exit.")

    def draw_screen(self) -> None:
        self.cmd.clear_screen()
        print = self.print

        print("Load Session\n")
        print(f"Saved Sessions:    ( {SESSIONS_DIRECTORY} )")
        if len(self.session_list) == 0:
            print("\n        No saved sessions found.\n")
        else:
            for i in range(len(self.session_list)):
                session = self.session_list[i]
                
                select_indicator = "*" if self.selected_session == i else " "
                print(f"  {select_indicator} [{i}] {session}")

        self.write(SAVE_CURSOR)

        print("\n\n")
        self.print_keymap()

    def list_sessions(self):
        session_list = []
        for session in os.listdir(SESSIONS_DIRECTORY):
            session_list.append(session)
        self.session_list = session_list

    def get_selected_session_path(self) -> str | None:
        if self.selected_session >= len(self.session_list):
            return None
        return SESSIONS_DIRECTORY + self.session_list[self.selected_session]

    def delete_session(self) -> bool:
        session_path = self.get_selected_session_path()
        if session_path == None:
            return False
        os.remove(session_path)
        return True

    def load_session(self) -> bool:
        session_path = self.get_selected_session_path()
        if session_path == None:
            return False
        subprocess.run(["kitty", "--session", session_path, "--single-instance", "--detach"])
        return True

def main(args: List[str]):
    if len(args) < 2:
        return None
    
    cmd = args[1]
    if cmd == "save":
        loop = Loop()
        handler = SessionSaver()
        loop.loop(handler)
    elif cmd == "list":
        loop = Loop()
        handler = SessionList()
        loop.loop(handler)
