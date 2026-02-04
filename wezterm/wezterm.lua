local wezterm = require("wezterm")

local config = {}
local opacity = 0.7
local transparent = true

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- カラースキームの設定
config.color_scheme = "GitHub Dark"

config.window_background_opacity = opacity

-- 最初からフルスクリーンで起動
local mux = wezterm.mux
wezterm.on("gui-startup", function(cmd)
	local tab, pane, window = mux.spawn_window(cmd or {})
	window:gui_window():toggle_fullscreen()
end)

wezterm.on("toggle-opacity", function(window, _)
	transparent = not transparent
	window:set_config_overrides({
		window_background_opacity = transparent and opacity or 1.0,
	})
end)

-- ショートカットキー設定
local act = wezterm.action
config.keys = {
	{
		key = "p",
		mods = "CMD",
		action = wezterm.action.SplitHorizontal({ domain = "CurrentPaneDomain" }),
	},
	{
		key = "h",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Left"),
	},
	{
		key = "j",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Down"),
	},
	{
		key = "k",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Up"),
	},
	{
		key = "l",
		mods = "CMD",
		action = wezterm.action.ActivatePaneDirection("Right"),
	},
	{
		key = "u",
		mods = "CMD",
		action = wezterm.action.EmitEvent("toggle-opacity"),
	},
}

return config
