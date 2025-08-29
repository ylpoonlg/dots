import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { exec, execAsync } from "ags/process"
import { createPoll } from "ags/time"
import { createState, For, With } from "ags"
import AstalWp from "gi://AstalWp?version=0.1"
import AstalNetwork from "gi://AstalNetwork?version=0.1"
import { set } from "../../../../../usr/share/ags/js/gnim/src/util"


// Volume Controls
const VolumeControls = () => {
  const setVolume = (vol: number) => {
    const wp = AstalWp.get_default();
    wp?.defaultSpeaker.set_volume(vol / 100);
  };

  const setMuted = (muted: boolean) => {
    const wp = AstalWp.get_default();
    wp?.defaultSpeaker.set_mute(muted);
    console.log(`Setting volume to ${muted ? "muted" : "unmuted"}`);
  };

  const setNextDevice = () => {
    const wp = AstalWp.get_default();
    if (wp == null) return;
    const speakers = wp.audio.get_speakers()?.sort((a, b) => {
      return a.id - b.id;
    });
    if (speakers == null) return;
    const defId = speakers?.findIndex((sink) => {
      return sink.is_default;
    });
    const newDefault = (defId + 1) % speakers.length;
    speakers.at(newDefault)?.set_is_default(true);
  };

  const curVolume = createPoll<number>(0, 500,
    (_) => {
      const wp = AstalWp.get_default();
      const vol =  (wp?.get_default_speaker()?.get_volume()??0) * 100;
      return Math.round(vol);
    });

  const isMuted = createPoll<boolean>(false, 500,
    (_) => {
      const wp = AstalWp.get_default();
      return wp?.defaultSpeaker.get_mute() ?? false;
    });

  const sinkName = createPoll<string>("...", 500,
    (_) => {
      const wp = AstalWp.get_default();
      return wp?.get_default_speaker()?.get_name() ?? "...";
    });

  return (
    <box class="volume-box" orientation={Gtk.Orientation.VERTICAL}>
      <centerbox>
        <button $type="start" class="primary" label="󰓃" />
        <label $type="center" class="title-1" label={sinkName} />
        <button $type="end" class="fg" label=" " onClicked={setNextDevice} />
        </centerbox>
        <With value={curVolume}>
        { (vol) => (
          <box class="slider-box" orientation={Gtk.Orientation.HORIZONTAL} halign={Gtk.Align.FILL}>
            <button class="volume-label" label={isMuted(muted => muted ? "󰝟 " : vol.toString())} marginEnd={4}
              onClicked={() => {
                setMuted(isMuted(muted => !muted).get())
              }}
            />
            <box hexpand />
            <slider
              widthRequest={320}
              value={curVolume}
              min={0}
              max={100}
              onChangeValue={(volume) => {
                setVolume(volume.value);
              }}
            />
            <box hexpand />
          </box>
        ) }
        </With>
    </box>
  );
};


// Control Network and Bluetooth Connections
const NetworkControls = () => {
  // Activate (or deactivate) network connection
  const activateConnection = (uuid: string, isConnect: boolean = true) => {
    const op = isConnect ? "up" : "down";
    execAsync(["nmcli", "connection", op, uuid]).then(_ => {
      console.log(`${isConnect ? "Connect" : "Disconnect"} to ${uuid}`);
    }).catch(e => { console.log(e); })
  };

  const netItems = createPoll<Array<object>>([], 500,
    ["nmcli", "--fields", "NAME,TYPE,STATE,UUID", "connection", "show"], (out, last) => {
      const net = out.split("\n").slice(1,);
      const conns = net.map((line) => {
        const col = line.split(/\s\s+/, 4).map(s => s.trim());
        return {
          name: col[0],
          type: col[1],
          state: col[2],
          uuid: col[3],
        };
      });
      const newItems = conns.filter((conn) => (conn.type.trim() != "loopback")).sort((a, b) => {
        // Sort by state (active first), then type (ethernet first), then name
        if (a.state == b.state) {
          if (a.type == b.type) return (a.name < b.name) ? -1 : 1;
          return a.type == "ethernet" ? -1 : 1;
        }
        return (a.state == "activated") ? -1 : 1;
      });

      if (JSON.stringify(last) == JSON.stringify(newItems)) {
        return last;
      }
      return newItems;
  });

  // Connect (or Disconnect) bluetooth device
  const connectBluetooth = (dev: string, isConnect: boolean = true) => {
    const op = isConnect ? "connect" : "disconnect";
    console.log(`${op}ing to bluetooth device ${dev}`);
    execAsync(["bluetoothctl", op, dev]).then(_ => {
      console.log(`Bluetooth ${op}ed to ${dev}`);
    }).catch(e => { console.error(e); });
  };

  const btItems = createPoll<Array<object>>([], 500,
    ["bash", "-c", "bluetoothctl devices Paired | grep '^Device '"], (out, last) => {
      const net = out.split("\n");
      const conns = net.map((line) => {
        const col = line.split(/\s/).map(s => s.trim());
        const addr = col[1];
        let connected = false;
        try {
          const info = exec(["bash", "-c", "bluetoothctl info " + addr + " | grep Connected:"]);
          connected = info.split(": ")[1].trim() == "yes" ? true : false;
        } catch(e) { console.error(e) }
        return {
          addr: addr,
          name: col.slice(2).join(" "),
          conn: connected,
        };
      });
      const newItems = conns.sort((a, b) => {
        if (a.conn == b.conn) return a.name < b.name ? -1 : 1;
        return a.conn ? -1 : 1;
      });

      if (JSON.stringify(last) == JSON.stringify(newItems)) {
        return last;
      }
      return newItems;
  });

  const [connTab, setConnTab] = createState("net");

  const getConnItems = (tab: string) => {
    if (tab === "bt") {
      // Bluetooth Items
      return (
        <box class="network-box" orientation={Gtk.Orientation.VERTICAL}>
          <For each={btItems}>
          {
            (item: object, index) => {
              return (
                <button class={"network-item " + (item.conn ? "secondary" : "fg")}
                  cursor={Gdk.Cursor.new_from_name("pointer", null)}
                  onClicked={() => {
                    connectBluetooth(item.addr, !item.conn);
                  }}
                  >
                  <box hexpand orientation={Gtk.Orientation.HORIZONTAL}>
                    <label halign={Gtk.Align.START} marginEnd={4}
                           label={item.conn ? "󰂱 " : "󰂯 "}/>
                    <label halign={Gtk.Align.START}
                           label={item.name}/>
                  </box>
                </button>
              );
            }
          }
          </For>
        </box>
      );
    }

    // Network Items
    return (
      <box class="network-box" orientation={Gtk.Orientation.VERTICAL}>
        <For each={netItems}>
        {
          (item: object, index) => {
            return (
              <button class={"network-item " + (item.state == "activated" ? "secondary" : "fg")}
                cursor={Gdk.Cursor.new_from_name("pointer", null)}
                onClicked={() => {
                  activateConnection(item.uuid, item.state != "activated");
                }}
                >
                <box hexpand orientation={Gtk.Orientation.HORIZONTAL}>
                  <label halign={Gtk.Align.START} marginEnd={4}
                         label={item.type == "wifi" ? "󰖩 " : "󰈀 "}/>
                  <label halign={Gtk.Align.START}
                         label={item.name}/>
                </box>
              </button>
            );
          }
        }
        </For>
      </box>
    );
  };

  return (
    <With value={connTab}>
    { (tab) => (
      <box class="conn-box" orientation={Gtk.Orientation.VERTICAL}>
        <box class="" hexpand halign={Gtk.Align.FILL}>
          <button class={"conn-tab-btn " + (tab == "net" ? "active" : "")}
                  css="border-top-right-radius: 0; border-bottom-right-radius: 0;"
                  cursor={Gdk.Cursor.new_from_name("pointer", null)}
                  hexpand label="󰖩"
                  onClicked={() => {setConnTab("net")}} />
          <button class={"conn-tab-btn " + (tab == "bt" ? "active" : "")}
                  css="border-top-left-radius: 0; border-bottom-left-radius: 0;"
                  cursor={Gdk.Cursor.new_from_name("pointer", null)}
                  hexpand label="󰂯"
                  onClicked={() => {setConnTab("bt")}} />
        </box>

        {getConnItems(tab)}
      </box>
    ) }
    </With>
  );
};

export default function Controls() {

  const { TOP, BOTTOM, LEFT, RIGHT } = Astal.WindowAnchor;

  return (
    <window
      visible={false}
      class="Popup Controls"
      name="Controls"
      application={app}
      layer={Astal.Layer.OVERLAY}
      keymode={Astal.Keymode.NONE}
      anchor={TOP | LEFT}
      marginTop={app.get_window("bar")?.get_height()}
    >
      <box orientation={Gtk.Orientation.VERTICAL} $={(self) => {
      }}>
        <VolumeControls />
        <NetworkControls />
      </box>
    </window>
  );
}
