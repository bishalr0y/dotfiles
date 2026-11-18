rex.mode("resize", { exclusive = true })

for key, direction in pairs({
  h = "left",
  j = "down",
  k = "up",
  l = "right",
  left = "left",
  down = "down",
  up = "up",
  right = "right",
}) do
  rex.bind("resize/" .. key, "pane.resize", { direction = direction })
  rex.bind("resize/shift+" .. key, "pane.resize", { direction = direction, amount = 15 })
end
rex.bind("resize/=", "pane.balance")
rex.bind("resize/enter", "client.mode.exit")