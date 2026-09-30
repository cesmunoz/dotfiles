-- Personal Omarchy input overrides.

hl.config({
  input = {
    kb_layout = "us",
    follow_mouse = 1,
    sensitivity = 0,
    touchpad = {
      natural_scroll = false,
    },
  },
})

-- Three-finger horizontal swipe changes workspaces, matching the old config.
hl.gesture({ fingers = 3, direction = "horizontal", action = "workspace" })
