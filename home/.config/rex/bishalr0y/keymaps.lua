local P = "ctrl+;>"

rex.bind(P .. "ctrl+;", "pane.send_key", { key = "ctrl+;" })

rex.bind(P .. "shift+/", "client.palette.toggle")
rex.bind(P .. "shift+s", "client.settings")
rex.bind(P .. "r", "client.config.reload")
rex.bind(P .. "shift+n", "session.new")
rex.bind(P .. "shift+w", "session.rename")
rex.bind(P .. "shift+d", "session.close")
rex.bind(P .. "s", "session.switch")
rex.bind(P .. "w", "session.switch")
rex.bind(P .. "g", "session.switch")
rex.bind(P .. "shift+9", "session.previous")
rex.bind(P .. "shift+0", "session.next")
rex.bind(P .. "b", "client.sidebar.toggle")
rex.bind(P .. "d", "client.window.close")
rex.bind(P .. "q", "client.window.close")

rex.bind(P .. "c", "client.tab.new")
rex.bind(P .. ",", "client.tab.rename")
rex.bind(P .. "p", "client.tab.previous")
rex.bind(P .. "n", "client.tab.next")
for i = 1, 9 do
  rex.bind(P .. i, "client.tab.goto", { index = i })
end
rex.bind(P .. "shift+x", "client.tab.close")

rex.bind(P .. "\\", "pane.split", { direction = "right" })
rex.bind(P .. "[Minus]", "pane.split", { direction = "down" })
rex.bind(P .. "x", "close_pane_or_tab")
rex.bind(P .. "m", "pane.zoom")

for key, direction in pairs({ h = "left", j = "down", k = "up", l = "right" }) do
  rex.bind(P .. key, "pane.focus", { direction = direction })
  rex.bind(P .. "shift+" .. key, "pane.move", { direction = direction })
end

rex.bind(P .. "tab", "pane.focus_next")
rex.bind(P .. ";", "pane.focus_next")
rex.bind(P .. "shift+tab", "pane.focus_previous")
rex.bind(P .. "v", "pane.copy_mode.enter")
rex.bind(P .. "f", "client.find.open")
rex.bind(P .. "shift+r", "client.mode.enter", { name = "resize" })