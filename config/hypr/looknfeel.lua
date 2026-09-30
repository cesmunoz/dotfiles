-- Personal Omarchy look and feel overrides extracted from the old Arch config.

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 20,
    border_size = 2,
  },
  decoration = {
    rounding = 10,
    blur = {
      enabled = true,
      size = 3,
      passes = 1,
      vibrancy = 0.1696,
    },
  },
})

-- Keep the old hyprland-run placement tweak.
o.window("hyprland-run", { move = { "20", "monitor_h-120" }, float = true })
