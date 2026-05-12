-- Monitors
hl.monitor({
	output = "DP-1",
	mode = "2560x1440@144",
	position = "auto-left",
	scale = "1",
})

hl.monitor({
	output = "DP-2",
	mode = "3440x1440@165",
	position = "0x0",
	scale = "1",
})

-- Programs
local terminal = "kitty"
local fileManager = "dolphin"

-- Environment variables
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_WAYLAND_DISABLE_WINDOWDECORATION", "1")
hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("VDPAU_DRIVER", "radeonsi")
hl.env("LIBVA_DRIVER_NAME", "radeonsi")
hl.env("SAL_USE_VCLPLUGIN", "qt6")
hl.env("XDG_MENU_PREFIX", "arch-")

-- General config
hl.config({
	general = {
		gaps_in = 5,
		gaps_out = 0,
		border_size = 0,
		col = {
			active_border = { colors = { "rgba(66ee1111)", "rgba(66ee1111)" }, angle = 45 },
			inactive_border = "rgba(66333333)",
		},
	},

	decoration = {
		rounding = 2,
		rounding_power = 1,
		active_opacity = 1.0,
		inactive_opacity = 0.9,

		shadow = {
			enabled = false,
		},

		blur = {
			enabled = true,
			size = 3,
			passes = 2,
		},
	},
	animations = {
		enabled = true,
	},
})

-- Animations
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "windows", enabled = true, speed = 7, bezier = "default" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "fade", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "layers", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 3, bezier = "default" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 10, bezier = "default" })

-- Dwindle and master layouts
hl.config({
	dwindle = {
		preserve_split = true,
	},
})

hl.config({
	master = {
		new_status = "master",
	},
})

hl.config({
	scrolling = {
		fullscreen_on_one_column = true,
	},
})

hl.config({
	misc = {
		force_default_wallpaper = -1,
		disable_hyprland_logo = true,
	},
})

-- Input config
hl.config({
	input = {
		follow_mouse = 1,
		sensitivity = 0,
	},
})

-- Keyboard shortcuts
local mainMod = "SUPER"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + RETURN", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + H", hl.dsp.layout("togglesplit"))
hl.bind("CTRL + SPACE", hl.dsp.exec_cmd('rofi -combi-modi window,drun -font "hack 10" -show combi -show-icons'))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("flameshot gui --raw | wl-copy"))
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("slurp | grim -g - - | wl-copy"))
hl.bind(mainMod .. " + SHIFT + N", hl.dsp.exec_cmd("bash makoctl restore && makoctl invoke && makoctl dismiss"))
hl.bind(mainMod .. "+ ALT + K", hl.dsp.exec_cmd("sleep 1 && hyprctl dispatch dpms off"))
hl.bind(mainMod .. "+ ALT + J", hl.dsp.exec_cmd("sleep 1 && systemctl suspend"))

-- Focus with arrow keys
hl.bind(mainMod .. " + left", hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up", hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down", hl.dsp.focus({ direction = "down" }))

-- Move to workspace (ALT + [0-9])
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = i }))
end

-- Switch to workspace (SUPER + [0-9])
for i = 1, 10 do
	local key = i % 10
	hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = i }))
end

-- Scroll through workspaces with mouse scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up", hl.dsp.focus({ workspace = "e-1" }))

-- Move workspace with comma
hl.bind(mainMod .. " + COMMA", hl.dsp.focus({ workspace = "m+1" }))

-- Move workspace with SUPER + ALT + left/right
hl.bind(mainMod .. " + ALT + left", hl.dsp.focus({ workspace = "m+1" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.focus({ workspace = "m-1" }))

-- Move windows with CTRL + SUPER + arrows
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.move({ direction = "left" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "right" }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.move({ direction = "up" }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.move({ direction = "down" }))

-- Drag windows
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- Media keys
hl.bind("0x1008FF14", hl.dsp.exec_cmd("playerctl play-pause"))
hl.bind(
	"XF86AudioLowerVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ -5%"),
	{ locked = true, repeating = true }
)
hl.bind(
	"XF86AudioRaiseVolume",
	hl.dsp.exec_cmd("pactl set-sink-volume @DEFAULT_SINK@ +5%"),
	{ locked = true, repeating = true }
)
hl.bind("XF86AudioMute", hl.dsp.exec_cmd("pactl set-mute @DEFAULT_SINK@ toggle"), { locked = true, passing = true })

-- Exit
hl.bind(mainMod .. " + ALT + BACKSPACE", hl.dsp.exit())

-- Startup apps (exec-once)
hl.on("hyprland.start", function()
	hl.exec_cmd("obsidian")
	hl.exec_cmd("/usr/lib/polkit-kde-authentication-agent-1")
	hl.exec_cmd("systemctl --user import-environment WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")
	hl.exec_cmd("hypridle")
	hl.exec_cmd("awww-daemon")
	hl.exec_cmd("cliphist")
	hl.exec_cmd("wl-paste --type text --watch cliphist store")
	hl.exec_cmd("wl-paste --type image --watch cliphist store")
	hl.exec_cmd("mako")
end)

-- Window rules
hl.window_rule({
	name = "flameshot",
	match = { class = "flameshot" },
	monitor = "0",
	float = true,
	no_anim = true,
	pin = true,
	border_size = 0,
	move = { 0, 0 },
})

hl.window_rule({
	name = "rofi",
	match = { class = "rofi" },
	stay_focused = true,
})

hl.window_rule({
	name = "telegram",
	match = { class = "telegram" },
	monitor = "0",
})

hl.window_rule({
	name = "obsidian",
	match = { class = "obsidian" },
	workspace = "5",
})

-- Fix XWayland dragging issues
hl.window_rule({
	name = "fix-xwayland-drags",
	match = {
		class = "^$",
		title = "^$",
		xwayland = true,
		float = true,
		fullscreen = false,
		pin = false,
	},
	no_focus = true,
})

-- Layer rules
hl.layer_rule({
	match = { namespace = "notifications" },
	blur = true,
})

hl.layer_rule({
	match = { namespace = "zen" },
	blur = true,
})

hl.layer_rule({
	match = { namespace = "rofi" },
	blur = true,
})
