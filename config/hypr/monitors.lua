-- See current outputs with: hyprctl monitors all

local omarchy_monitor_scale = "auto"
hl.monitor({ output = "", mode = "preferred", position = "auto", scale = omarchy_monitor_scale })

-- GDK scale controls GTK/XWayland UI sizing. Keep Omarchy's common default.
local omarchy_gdk_scale = 2
hl.env("GDK_SCALE", tostring(omarchy_gdk_scale))
