-- Omarchy-compatible Hyprland entrypoint.
-- Keep Omarchy defaults and load only personal overrides from this repo.

dofile((os.getenv("OMARCHY_PATH") or "/usr/share/omarchy") .. "/default/hypr/bootstrap.lua")

require("default.hypr.omarchy")
require("hypr.monitors")
require("hypr.input")
require("hypr.bindings")
require("hypr.looknfeel")
require("hypr.autostart")
require("default.hypr.toggles")
