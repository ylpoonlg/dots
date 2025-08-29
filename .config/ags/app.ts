import app from "ags/gtk4/app"
import style from "./style.scss"
import Bar from "./widget/Bar"
import Controls from "./widget/Controls"
import Volume from "./widget/Volume"

app.start({
  css: style,
  main() {
    const monitors = app.get_monitors();
    monitors.map(Bar)
    Controls();
    Volume();
  },
})
