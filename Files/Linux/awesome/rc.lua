-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")
-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
if awesome.startup_errors then
    naughty.notify({
        preset = naughty.config.presets.critical,
        title = "Oops, there were errors during startup!",
        text = awesome.startup_errors
    })
end

-- Handle runtime errors after startup
do
    local in_error = false
    awesome.connect_signal("debug::error", function(err)
        -- Make sure we don't go into an endless error loop
        if in_error then
            return
        end
        in_error = true

        naughty.notify({
            preset = naughty.config.presets.critical,
            title = "Oops, an error happened!",
            text = tostring(err)
        })
        in_error = false
    end)
end
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "NN_Awesome/theme.lua")

-- This is used later as the default terminal and editor to run.
terminal = "kitty"
editor = os.getenv("vim") or "vi"
editor_cmd = terminal .. " -e " .. editor

-- Default modkey.
-- Usually, Mod4 is the key with a logo between Control and Alt.
-- If you do not like this or do not have such a key,
-- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- However, you can use another modifier like Mod1, but it may interact with others.
modkey = "Mod4"

-- Table of layouts to cover with awful.layout.inc, order matters.
awful.layout.layouts = {awful.layout.suit.tile, awful.layout.suit.floating}
-- }}}

-- {{{ Menu
-- Create a launcher widget and a main menu
myawesomemenu = {{"Controls", function()
    hotkeys_popup.show_help(nil, awful.screen.focused())
end}, {"Manual", terminal .. " -e man awesome"}, {"Configuration", editor_cmd .. " " .. awesome.conffile},
                 {"Restart", awesome.restart}, {"Exit", function()
    awesome.quit()
end}}
appmenu = {{"Browser", "firefox"}, {"Editor", "kitty vim"}, {"Files", "kitty ranger"}, {"Music", "kitty ncmpcpp"},
           {"Steam", "steam"}, {"Terminal", terminal}}
screenshotmenu = {{"Fullscreen", "scrot -d 1 "}, {"Select Area", "scrot -s "}}
systemmenu = {{"Power Off", "systemctl shutdown"}, {"Reboot", "systemctl reboot "}, {"Suspend", "systemctl suspend"}}
mymainmenu = awful.menu({
    items = {{"Awesome", myawesomemenu}, {"Programs", appmenu}, {"Screenshot", screenshotmenu}, {"System", systemmenu}}
})

mylauncher = awful.widget.launcher({
    image = beautiful.awesome_icon,
    menu = mymainmenu
})

-- Menubar configuration
menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- }}}

-- {{{ Wibar
local buttons_example = wibox {
    visible = true,
    bg = '#2E3440',
    ontop = true,
    height = 1E00,
    width = 200,
    shape = function(cr, width, height)
        gears.shape.rounded_rect(cr, width, height, 3)
    end
}
sep_bar = wibox.widget.textbox('<span font="Ubuntu 22"> |  </span>')
local mytextclock = wibox.widget.textclock('<span color="#ffffff" font="Ubuntu 18"> %l:%M %p</span>', 5)
local month_calendar = awful.widget.calendar_popup.month()
month_calendar:attach(mytextclock, "tc")
-- Create a wibox for each screen and add it
local taglist_buttons = gears.table.join(awful.button({}, 1, function(t)
    t:view_only()
end), awful.button({modkey}, 1, function(t)
    if client.focus then
        client.focus:move_to_tag(t)
    end
end), awful.button({}, 3, awful.tag.viewtoggle), awful.button({modkey}, 3, function(t)
    if client.focus then
        client.focus:toggle_tag(t)
    end
end), awful.button({}, 4, function(t)
    awful.tag.viewnext(t.screen)
end), awful.button({}, 5, function(t)
    awful.tag.viewprev(t.screen)
end))

local tasklist_buttons = gears.table.join(awful.button({}, 1, function(c)
    if c == client.focus then
        c.minimized = true
    else
        c:emit_signal("request::activate", "tasklist", {
            raise = true
        })
    end
end), awful.button({}, 3, function()
    awful.menu.client_list({
        theme = {
            width = 250
        }
    })
end), awful.button({}, 4, function()
    awful.client.focus.byidx(1)
end), awful.button({}, 5, function()
    awful.client.focus.byidx(-1)
end))

local function set_wallpaper(s)
    -- Wallpaper
    if beautiful.wallpaper then
        local wallpaper = beautiful.wallpaper
        -- If wallpaper is a function, call it with the screen
        if type(wallpaper) == "function" then
            wallpaper = wallpaper(s)
        end
        gears.wallpaper.maximized(wallpaper, s, true)
    end
end
local function update_floating_client_border(c)
    if c.floating then
        c.border_color = beautiful.border_color_floating
        c.border_width = beautiful.border_width_floating
    end
end
client.connect_signal("manage", update_floating_client_border)
client.connect_signal("property::floating", update_floating_client_border)

-- Re-set wallpaper when a screen's geometry changes (e.g. different resolution)
screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
    -- Wallpaper
    set_wallpaper(s)
    -- Systray
    s.systray = wibox.widget.systray()
    s.systray.visible = false
    -- Each screen has its own tag table.
    awful.tag({"WEB", "DEV", "VM", "GAME", "MED"}, s, awful.layout.layouts[1])

    -- Create a taglist widget
    s.mytaglist = awful.widget.taglist {
        screen = s,
        filter = awful.widget.taglist.filter.all,
        buttons = taglist_buttons
    }

    -- Create a tasklist widget
    s.mytasklist = awful.widget.tasklist {
        screen = s,
        filter = awful.widget.tasklist.filter.currenttags,
        buttons = tasklist_buttons,
        style = {
            shape = gears.shape.rect
        },
        layout = {

            spacing = 2,

            spacing_widget = {

                {

                    forced_width = 0,

                    shape = gears.shape.circle,

                    widget = wibox.widget.separator

                },

                valign = "center",

                halign = "center",

                widget = wibox.container.place

            },

            layout = wibox.layout.flex.horizontal

        },
        ------------------------------
        widget_template = {
            {
                {
                    {
                        {
                            id = 'icon_role',
                            widget = wibox.widget.imagebox
                        },
                        margins = 2,
                        widget = wibox.container.margin
                    },
                    layout = wibox.layout.fixed.horizontal
                },
                left = 2,
                right = 2,
                widget = wibox.container.margin
            },
            id = 'background_role',
            widget = wibox.container.background
        }
    }
    -- Create the wibox
    s.mywibox = awful.wibar({
        position = "top",
        screen = s,
        height = 46,
        bg = "#282a3650"
    })

    -- Add widgets to the wibox
    s.mywibox:setup{
        layout = wibox.layout.align.horizontal,
        expand = "none",
        { -- Left widgets
            layout = wibox.layout.align.horizontal,
            s.mytaglist,
            sep_bar,
            s.mytasklist
        },
        mytextclock,
        { -- Right widgets
            layout = wibox.layout.fixed.horizontal,
            -- System Monitors
            awful.widget.watch('bash -c "sensors | grep -A 0 "Tctl:" | cut -c16-25 | sed "s/^/CPU:/g""', 15),
            sep_bar,
            awful.widget.watch('bash -c "sensors | grep -A 0 "edge:" | cut -c16-23 | sed "s/^/GPU:/g""', 15),
            sep_bar,
            awful.widget.watch('bash -c "free -m | grep -A 0 "Mem:" | cut -c28-35 | sed "s/^/RAM:/g""', 15,
                function(widget, stdout)
                    widget:set_text(stdout .. "MB")
                end),
            s.systray
        }
    }
end)

-- }}}

-- {{{ Mouse bindings
root.buttons(gears.table.join(awful.button({}, 3, function()
    mymainmenu:toggle()
end), awful.button({}, 4, awful.tag.viewnext), awful.button({}, 5, awful.tag.viewprev)))
-- }}}

-- {{{ Key bindings
globalkeys = gears.table.join(awful.key({modkey}, "s", hotkeys_popup.show_help, {
    description = "show help",
    group = "awesome"
}), awful.key({modkey}, "Left", awful.tag.viewprev, {
    description = "view previous",
    group = "tag"
}), awful.key({modkey}, "Right", awful.tag.viewnext, {
    description = "view next",
    group = "tag"
}), awful.key({modkey}, "Escape", awful.tag.history.restore, {
    description = "go back",
    group = "tag"
}), awful.key({modkey}, "j", function()
    awful.client.focus.byidx(1)
end, {
    description = "focus next by index",
    group = "client"
}), awful.key({modkey}, "k", function()
    awful.client.focus.byidx(-1)
end, {
    description = "focus previous by index",
    group = "client"
}), awful.key({modkey}, "w", function()
    mymainmenu:show()
end, {
    description = "show main menu",
    group = "awesome"
}), -- Layout manipulation
awful.key({modkey, "Shift"}, "j", function()
    awful.client.swap.byidx(1)
end, {
    description = "swap with next client by index",
    group = "client"
}), awful.key({modkey, "Shift"}, "k", function()
    awful.client.swap.byidx(-1)
end, {
    description = "swap with previous client by index",
    group = "client"
}), awful.key({modkey, "Control"}, "j", function()
    awful.screen.focus_relative(1)
end, {
    description = "focus the next screen",
    group = "screen"
}), awful.key({modkey, "Control"}, "k", function()
    awful.screen.focus_relative(-1)
end, {
    description = "focus the previous screen",
    group = "screen"
}), awful.key({modkey}, "u", awful.client.urgent.jumpto, {
    description = "jump to urgent client",
    group = "client"
}), awful.key({modkey}, "Tab", function()
    awful.client.focus.history.previous()
    if client.focus then
        client.focus:raise()
    end
end, {
    description = "go back",
    group = "client"
}), -- Standard program
awful.key({modkey, "Control"}, "r", awesome.restart, {
    description = "reload awesome",
    group = "awesome"
}), awful.key({modkey, "Shift"}, "q", awesome.quit, {
    description = "quit awesome",
    group = "awesome"
}), awful.key({modkey}, "b", function()
    for s in screen do
        s.mywibox.visible = not s.mywibox.visible
        if s.mybottomwibox then
            s.mybottomwibox.visible = not s.mybottomwibox.visible
        end
    end
end, {
    description = "toggle wibox",
    group = "awesome"
}), awful.key({modkey}, "l", function()
    awful.tag.incmwfact(0.05)
end, {
    description = "increase master width factor",
    group = "layout"
}), awful.key({modkey}, "h", function()
    awful.tag.incmwfact(-0.05)
end, {
    description = "decrease master width factor",
    group = "layout"
}), awful.key({modkey, "Shift"}, "h", function()
    awful.tag.incnmaster(1, nil, true)
end, {
    description = "increase the number of master clients",
    group = "layout"
}), awful.key({modkey, "Shift"}, "l", function()
    awful.tag.incnmaster(-1, nil, true)
end, {
    description = "decrease the number of master clients",
    group = "layout"
}), awful.key({modkey, "Control"}, "h", function()
    awful.tag.incncol(1, nil, true)
end, {
    description = "increase the number of columns",
    group = "layout"
}), awful.key({modkey, "Control"}, "l", function()
    awful.tag.incncol(-1, nil, true)
end, {
    description = "decrease the number of columns",
    group = "layout"
}), awful.key({modkey}, "space", function()
    awful.layout.inc(1)
end, {
    description = "select next",
    group = "layout"
}), awful.key({modkey, "Shift"}, "space", function()
    awful.layout.inc(-1)
end, {
    description = "select previous",
    group = "layout"
}), awful.key({modkey, "Control"}, "n", function()
    local c = awful.client.restore()
    -- Focus restored client
    if c then
        c:emit_signal("request::activate", "key.unminimize", {
            raise = true
        })
    end
end, {
    description = "restore minimized",
    group = "client"
}), -- Prompt
awful.key({}, "XF86AudioRaiseVolume", function()
    awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ 0")
    awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ +5%")
    awesome.emit_signal("widget::volume")
end, {
    description = "raise volume",
    group = "volume"
}), awful.key({}, "XF86AudioLowerVolume", function()
    awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ 0")
    awful.spawn.with_shell("pactl set-sink-volume @DEFAULT_SINK@ -5%")
    awesome.emit_signal("widget::volume")
end, {
    description = "lower volume",
    group = "volume"
}), awful.key({}, "XF86AudioMute", function()
    awful.spawn.with_shell("pactl set-sink-mute @DEFAULT_SINK@ toggle")
    awesome.emit_signal("widget::volume")
end, {
    description = "mute volume",
    group = "volume"
}), awful.key({modkey}, "d", function()
    awful.util.spawn("Discord")
end, {
    description = "Discord",
    group = "launcher"
}), awful.key({modkey}, "e", function()
    awful.util.spawn("kitty ranger")
end, {
    description = "Ranger",
    group = "launcher"
}), awful.key({modkey}, "r", function()
    awful.util.spawn("rofi -show drun")
end, {
    description = "Rofi",
    group = "launcher"
}), awful.key({modkey}, "Return", function()
    awful.spawn(terminal)
end, {
    description = "Terminal",
    group = "launcher"
}), awful.key({modkey}, "v", function()
    awful.util.spawn("kitty vim")
end, {
    description = "VIM",
    group = "launcher"
}), awful.key({modkey}, "=", function()
    awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
end, {
    description = "Toggle System Tray",
    group = "layout"
}))
clientkeys = gears.table.join(awful.key({modkey}, "f", function(c)
    c.fullscreen = not c.fullscreen
    c:raise()
end, {
    description = "toggle fullscreen",
    group = "client"
}), awful.key({modkey, "Shift"}, "c", function(c)
    c:kill()
end, {
    description = "close",
    group = "client"
}), awful.key({modkey, "Control"}, "space", awful.client.floating.toggle, {
    description = "toggle floating",
    group = "client"
}), awful.key({modkey, "Control"}, "Return", function(c)
    c:swap(awful.client.getmaster())
end, {
    description = "move to master",
    group = "client"
}), awful.key({modkey}, "o", function(c)
    c:move_to_screen()
end, {
    description = "move to screen",
    group = "client"
}), awful.key({modkey}, "t", function(c)
    c.ontop = not c.ontop
end, {
    description = "toggle keep on top",
    group = "client"
}), awful.key({modkey}, "n", function(c)
    -- The client currently has the input focus, so it cannot be
    -- minimized, since minimized clients can't have the focus.
    c.minimized = true
end, {
    description = "minimize",
    group = "client"
}), awful.key({modkey}, "m", function(c)
    c.maximized = not c.maximized
    c:raise()
end, {
    description = "(un)maximize",
    group = "client"
}), awful.key({modkey, "Control"}, "m", function(c)
    c.maximized_vertical = not c.maximized_vertical
    c:raise()
end, {
    description = "(un)maximize vertically",
    group = "client"
}), awful.key({modkey, "Shift"}, "m", function(c)
    c.maximized_horizontal = not c.maximized_horizontal
    c:raise()
end, {
    description = "(un)maximize horizontally",
    group = "client"
}))

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it work on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
    globalkeys = gears.table.join(globalkeys, -- View tag only.
    awful.key({modkey}, "#" .. i + 9, function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
            tag:view_only()
        end
    end, {
        description = "view tag #" .. i,
        group = "tag"
    }), -- Toggle tag display.
    awful.key({modkey, "Control"}, "#" .. i + 9, function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
            awful.tag.viewtoggle(tag)
        end
    end, {
        description = "toggle tag #" .. i,
        group = "tag"
    }), -- Move client to tag.
    awful.key({modkey, "Shift"}, "#" .. i + 9, function()
        if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
                client.focus:move_to_tag(tag)
            end
        end
    end, {
        description = "move focused client to tag #" .. i,
        group = "tag"
    }), -- Toggle tag on focused client.
    awful.key({modkey, "Control", "Shift"}, "#" .. i + 9, function()
        if client.focus then
            local tag = client.focus.screen.tags[i]
            if tag then
                client.focus:toggle_tag(tag)
            end
        end
    end, {
        description = "toggle focused client on tag #" .. i,
        group = "tag"
    }))
end

clientbuttons = gears.table.join(awful.button({}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", {
        raise = true
    })
end), awful.button({modkey}, 1, function(c)
    c:emit_signal("request::activate", "mouse_click", {
        raise = true
    })
    awful.mouse.client.move(c)
end), awful.button({modkey}, 3, function(c)
    c:emit_signal("request::activate", "mouse_click", {
        raise = true
    })
    awful.mouse.client.resize(c)
end))

-- Set keys
root.keys(globalkeys)
-- }}}

-- {{{ Rules
-- Rules to apply to new clients (through the "manage" signal).

awful.rules.rules = { -- All clients will match this rule.
{
    rule = {},
    properties = {
        border_width = beautiful.border_width,
        border_color = beautiful.border_normal,
        focus = awful.client.focus.filter,
        raise = true,
        keys = clientkeys,
        buttons = clientbuttons,
        screen = awful.screen.preferred,
        placement = awful.placement.no_overlap + awful.placement.no_offscreen,
        switch_to_tags = true
    }
}, -- Clients will spawn in appropriate tag
{
    rule_any = {
        class = {"firefox", "zoom", "discord"}
    },
    properties = {
        tag = "WEB"
    }
}, {
    rule_any = {
        class = {"Code", "Gimp.*"}
    },
    properties = {
        tag = "DEV"
    }
}, {
    rule = {
        name = "Virtual Machine Manager"
    },
    properties = {
        tag = "VM"
    }
}, {
    rule = {
        name = "Subscriptions - FreeTube"
    },
    properties = {
        tag = "MED"
    }
}, {
    rule_any = {
        class = {"Lutris", "openrgb", "Steam", "steam_app_.*"}
    },
    properties = {
        tag = "GAME"
    }
}, {
    rule_any = {
        class = {"freetube", "Ghb", "Pavucontrol", "mpv"}
    },
    properties = {
        tag = "MED",
        fullscreen = true
    }
}, -- Floating clients.
{
    rule_any = {
        class = {"Blueman-manager", "mpv"}
    },
    properties = {
        floating = true
    }
}}
-- }}}

-- {{{ Signals
-- Signal function to execute when a new client appears.
client.connect_signal("manage", function(c)
    -- Set the windows at the slave,
    -- i.e. put it at the end of others instead of setting it master.
    -- if not awesome.startup then awful.client.setslave(c) end

    if awesome.startup and not c.size_hints.user_position and not c.size_hints.program_position then
        -- Prevent clients from being unreachable after screen count changes.
        awful.placement.no_offscreen(c)
    end
end)

-- Autostart Applications
awful.spawn.with_shell("mpd")
awful.spawn.with_shell("nitrogen --restore")
awful.spawn.with_shell("nm-applet")
awful.spawn.with_shell("picom --experimental-backends")
