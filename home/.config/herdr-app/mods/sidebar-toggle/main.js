// One-shot: compact sidebar rail (same as workspace-chrome sidebar button), not layout.hide.
import { View, div } from "gpui-kit";
import { run, shared, setShared, layout, window, props, closeOverlay } from "herdr";

function find(node, id) {
  if (node?.id === id) return node;
  for (const child of node?.children ?? []) {
    const found = find(child, id);
    if (found) return found;
  }
  return null;
}

const narrow = () => (find(layout(), "sidebar")?.size?.px ?? Infinity) < 160;

function railPx() {
  return window()?.platform === "macos" ? 76 : 44;
}

function toggleSidebar() {
  const sidebar = find(layout(), "sidebar");
  if (sidebar?.hidden) {
    run("layout.show", { id: "sidebar" });
    setShared("sidebar.collapsed", true);
    run("layout.resize", { id: "sidebar", px: railPx() });
    return;
  }

  const width = sidebar?.size?.px;
  if (!narrow()) setShared("sidebar.width", width);
  setShared("sidebar.collapsed", !narrow());
  run("layout.resize", {
    id: "sidebar",
    px: narrow() ? (shared("sidebar.width") ?? 268) : railPx(),
  });
}

export default class SidebarToggle extends View {
  init(_props, _cx) {
    toggleSidebar();
    const overlay = props()?.overlay;
    if (overlay) closeOverlay(overlay);
  }

  render() {
    return div();
  }
}
