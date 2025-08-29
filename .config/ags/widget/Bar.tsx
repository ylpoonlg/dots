import app from "ags/gtk4/app"
import { Astal, Gtk, Gdk } from "ags/gtk4"
import { exec, execAsync, subprocess } from "ags/process"
import { createPoll } from "ags/time"
import { createState, For, With } from "ags"

const Workspaces = ({monitor="", nameLabel=false}) => {
  const niriWs = createPoll<Array<object>>([], 500, "niri msg --json workspaces", (out, last) => {
    let ws: Array<Object> = JSON.parse(out)
    const result = ws.filter((w) => (w.output == monitor || monitor == ""))
                     .sort((a: object, b: object) => a.idx > b.idx ? 1 : -1);
    if (JSON.stringify(result) == JSON.stringify(last)) return last;
    return result;
  });

  if (nameLabel) {
    return (
      <box class="ws-name">
        <label label={niriWs(res => res.find(ws => ws.is_active)?.name??"")} />
      </box>
    );
  }

  return (
    <box orientation={Gtk.Orientation.HORIZONTAL} class="ws-box">
      <For each={niriWs}>
      {
        (item: object, index) => {
          return (
            <button class="ws-btn"
              cursor={Gdk.Cursor.new_from_name("pointer", null)}
              tooltipText={item.name??item.idx.toString()}
              onClicked={() => {
                execAsync(["niri", "msg", "action", "focus-workspace", item.idx.toString()])
                  .catch(e => console.log(e));
              }}>
              <label class={item.is_active ? "ws-active" :
                           (item.active_window_id != null ? "ws-win" : "")
                           } label="" />
            </button>
          );
        }
      }
      </For>
    </box>
  );
};

const SystemTray = () => {
  const [refresh, setRefresh] = createState(false);

  let trayItems: Map<string, object> = new Map();

  const astaltrayProcess = subprocess("astal-tray -d", (out) => {
    const event = JSON.parse(out);
    if (event.event == "item_added") {
      trayItems.set(event.id, event.item);
    } else if (event.event == "item_changed") {
      trayItems.set(event.id, event.item);
    } else if (event.event == "item_removed") {
      trayItems.delete(event.id);
    }
    setRefresh(!refresh.get());
  });

  return (
    <box class="systray-box" orientation={Gtk.Orientation.HORIZONTAL}>
      <With value={refresh}>
      {
        (_) => (
          <box orientation={Gtk.Orientation.HORIZONTAL}>
          {
            Array.from(trayItems).map((item) => {
              const [key, val] = item;
              return (
                <button class="systray-item-btn"
                    cursor={Gdk.Cursor.new_from_name("pointer", null)}
                    tooltipText={`${val.title}`}
                    onClicked={() => {
                      // const sv = new Service;
                    }}
                    >
                  <image iconName={val.icon_name} />
                </button>
              );
            })
          }
          </box>
        )
      }
      </With>
    </box>
  );
}

const SystemMonitor = () => {
  const ramUsage = createPoll<object>({avail: 1, used:0}, 1000, ["bash", "-c", "free -b | grep ^Mem:"],
    (out) => {
      const vals = out.split(/\s+/);
      return {
        avail: parseInt(vals[1]),
        used: parseInt(vals[2]),
      };
    })

  const cpuUsage = createPoll<object>({load: 0}, 1000, ["bash", "-c", "cat /proc/stat | head -n1"],
    (out) => {
      const vals = out.split(/\s+/).slice(1).map(val => parseInt(val));
      let total = 0;
      vals.forEach(val => { total += val; })
      return {
        user: vals[0] + vals[1],
        system: vals[2],
        idle: vals[3],
        total: total,
        load: ((total - vals[3]) / total),
      };
    })

  const temps = createPoll<object>({cpu: 0, gpu: 0}, 1000, ["bash", "-c", "sensors -j"],
    (out) => {
      const sensors = JSON.parse(out);
      const cpuT = Math.round(sensors["k10temp-pci-00c3"]["Tctl"]["temp1_input"]);
      const gpuTe = Math.round(sensors["amdgpu-pci-0300"]["edge"]["temp1_input"]);
      const gpuTj = Math.round(sensors["amdgpu-pci-0300"]["junction"]["temp2_input"]);
      const gpuTm = Math.round(sensors["amdgpu-pci-0300"]["mem"]["temp3_input"]);
      return {
        cpu: cpuT,
        gpu: (gpuTe + gpuTj + gpuTm) / 3,
      };
    });

  return (
    <box class="sysmon-box"
        orientation={Gtk.Orientation.VERTICAL} valign={Gtk.Align.CENTER}
        tooltipText={ramUsage((val) => {
          const ram = Math.round(val.used/1048576);
          const cpu = cpuUsage(x => (x.load * 100).toFixed(2));
          // const cpuT = temps(x => x.cpu);
          // const gpuT = temps(x => x.gpu);
          return `RAM: ${ram}MB\nCPU: ${cpu.get()}%`;
        })}
    >
      <levelbar name="ram-bar" mode={Gtk.LevelBarMode.CONTINUOUS}
        orientation={Gtk.Orientation.HORIZONTAL}
        widthRequest={64}
        value={ramUsage((val) => (val.used / val.avail))}
      />
      <levelbar name="cpu-bar" mode={Gtk.LevelBarMode.CONTINUOUS}
        orientation={Gtk.Orientation.HORIZONTAL}
        widthRequest={64}
        value={cpuUsage((val) => val.load)}
        />
    </box>
  );
};

export default function Bar(gdkmonitor: Gdk.Monitor) {
  const date = createPoll("", 1000, "date +'%Y-%m-%d'")
  const time = createPoll("", 1000, "date +'%H:%M:%S'")
  const timeHKT = createPoll("", 1000, ["bash", "-c", "TZ='Asia/Hong_Kong' date '+%H:%M'"])

  const { TOP, LEFT, RIGHT } = Astal.WindowAnchor

  return (
    <window
      visible
      name="bar"
      class="Bar"
      gdkmonitor={gdkmonitor}
      exclusivity={Astal.Exclusivity.EXCLUSIVE}
      anchor={TOP | LEFT | RIGHT}
      application={app}
    >
      <centerbox cssName="centerbox">
        {/* LEFT */}
        <box $type="start" halign={Gtk.Align.START}>
          <button class="primary powermenu-btn" label={"󰣇 "}
            cursor={Gdk.Cursor.new_from_name("pointer", null)}
            onClicked={() => {
              exec("/home/long/.config/rofi/scripts/power-menu");
            }}
          />

          <button class="controls-btn"
            cursor={Gdk.Cursor.new_from_name("pointer", null)}
            onClicked={() => {
              let controls = app.get_window("Controls");
              if (controls == null) return;
              if (controls.visible) {
                controls.hide()
              } else {
                controls.show()
              }
            }}
          >
            <box orientation={Gtk.Orientation.HORIZONTAL} class="secondary">
              <label class="controls-label" label="󰖩 " />
              <label class="controls-label" label="󰂯" />
              <label class="controls-label" label=" " />
            </box>
          </button>

          <SystemTray />
        </box>

        {/* CENTER */}
        <Workspaces $type="center" monitor={gdkmonitor.get_connector()??""} />

        {/* RIGHT */}
        <box $type="end" orientation={Gtk.Orientation.HORIZONTAL} halign={Gtk.Align.END}>

          <Workspaces monitor={gdkmonitor.get_connector()??""} nameLabel={true} />

          <SystemMonitor />

          <menubutton class="datetime-btn">
            <box orientation={Gtk.Orientation.HORIZONTAL} valign={Gtk.Align.CENTER}>
              <label class="date-label" label={date} marginEnd={16} />
              <label class="time-label" label={time} tooltipText={timeHKT(hkt => `${hkt} HKT`)} />
            </box>
            <popover>
              <Gtk.Calendar />
            </popover>
          </menubutton>

        </box>
      </centerbox>
    </window>
  )
}
