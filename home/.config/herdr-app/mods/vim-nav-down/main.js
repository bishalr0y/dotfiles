import { View, div } from "gpui-kit";
import { exec, props, closeOverlay, appHome } from "herdr";

export default class VimNavDown extends View {
  init(_props, cx) {
    cx.spawn(async () => {
      try {
        await exec("bash", [`${appHome()}/vim-nav.sh`, "down"], { timeout: 5000 });
      } catch (e) {
        console.log(`vim-nav-down: ${e}`);
      }
      closeOverlay(props()?.overlay);
    });
  }

  render() {
    return div();
  }
}
