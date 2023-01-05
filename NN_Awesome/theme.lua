---------------------------
-- NN AwesomeWM Theme --
---------------------------
-- Forked from default theme --
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi

local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()

local theme = {}

theme.font          = "ubuntu 12"

theme.bg_normal     = "#282a36"
theme.bg_focus      = "#6272a4"
theme.bg_urgent     = "#ff0000"
theme.bg_minimize   = "#44475a"
theme.bg_systray    = theme.bg_normal

theme.fg_normal     = "#aaaaaa"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#ffffff"
theme.fg_minimize   = "#ffffff"

theme.useless_gap   = dpi(0)
theme.border_width  = dpi(0)
theme.border_width_floating = dpi(4)
theme.border_normal = "#000000"
theme.border_focus  = "#535d6c"
theme.border_marked = "#91231c"
theme.border_color = "#6272a4"
theme.border_color_floating = "#6272a4"
theme.menu_submenu_icon = themes_path.."NN_Awesome/submenu.png"
theme.menu_height = dpi(30)
theme.menu_width  = dpi(150)
awesome.set_preferred_icon_size(64)


-- Generate Awesome icon:
theme.awesome_icon = theme_assets.awesome_icon(
    theme.menu_height, theme.bg_focus, theme.fg_focus
)

return theme
