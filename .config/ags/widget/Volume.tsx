import app from "ags/gtk4/app"
import { Astal, Gdk, Gtk } from "ags/gtk4";
import AstalWp from "gi://AstalWp?version=0.1";
import { createPoll } from "ags/time";
import { createState } from "ags";

export default function Volume() {
  const [isVisible, setIsVisible] = createState(false);

  const curVolume = createPoll<number>(0, 500,
    (_) => {
      const wp = AstalWp.get_default();
      const vol =  (wp?.get_default_speaker()?.get_volume()??0) * 100;
      return Math.round(vol);
    });

  curVolume.subscribe(() => {
    let controls = app.get_window("Controls");
    if (!controls?.is_visible()) {
      setIsVisible(true);
      setTimeout(() => {
        setIsVisible(false);
      }, 2500);
    }
  });

  const { TOP } = Astal.WindowAnchor;
  return (

    <window
      visible={isVisible}
      class="Popup VolumePopup"
      name="Volume"
      application={app}
      layer={Astal.Layer.OVERLAY}
      anchor={TOP}
      keymode={Astal.Keymode.NONE}
    >
      <box orientation={Gtk.Orientation.VERTICAL}>
        <label class="secondary" label="Volume" />
        <levelbar name="volume-bar" mode={Gtk.LevelBarMode.CONTINUOUS}
          orientation={Gtk.Orientation.HORIZONTAL}
          widthRequest={192}
          value={curVolume(x => x/100)}
          />
      </box>
    </window>
  );
}
