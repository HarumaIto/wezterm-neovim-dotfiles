local wezterm = require("wezterm")

local config = {}
local opacity = 0.8
local transparent = true

if wezterm.config_builder then
	config = wezterm.config_builder()
end

-- カラースキームの設定
config.color_scheme = "GitHub Dark"
config.font_size = 12
config.window_background_opacity = opacity
config.use_ime = true
config.window_decorations = "RESIZE"

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local background = "#5c6d74"
	local foreground = "#FFFFFF"

	if tab.is_active then
		background = "#ae8b2d"
		foreground = "#FFFFFF"
	end

	local title = "   " .. wezterm.truncate_right(tab.active_pane.title, max_width - 1) .. " "

	return {
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = title },
	}
end)
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
		key = "w",
		mods = "CMD",
		action = wezterm.action.CloseCurrentPane({ confirm = true }),
	},
	{
		key = "w",
		mods = "CMD|SHIFT",
		action = wezterm.action.CloseCurrentTab({ confirm = true }),
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
