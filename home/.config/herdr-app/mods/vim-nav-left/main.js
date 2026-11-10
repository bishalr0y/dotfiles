// Invisible one-shot: smart Ctrl+h (nvim passthrough or pane.go).
import { View, div } from "gpui-kit";
import { exec, props, closeOverlay, appHome } from "herdr";

export default class VimNavLeft extends View {
  init(_props, cx) {
    cx.spawn(async () => {
      try {
        await exec("bash", [`${appHome()}/vim-nav.sh`, "left"], { timeout: 5000 });
      } catch (e) {
        console.log(`vim-nav-left: ${e}`);
      }
      closeOverlay(props()?.overlay);
    });
  }

  render() {
    return div();
  }
}
