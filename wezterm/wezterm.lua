local wezterm = require("wezterm")

local BG_COLOR = "#232A2E"
local FG_COLOR = "#F8F9E8"
local act = wezterm.action

local config = {
	disable_default_key_bindings = false,
	enable_tab_bar = true,
	use_fancy_tab_bar = false,
	show_new_tab_button_in_tab_bar = false,
	tab_bar_at_bottom = true,
	window_padding = {
		bottom = 0,
	},
	-- font = wezterm.font(
	--        {
	-- 	family = "Cascadia Code",
	-- 	weight = "Medium",
	-- 	-- weight = "DemiBold",
	-- }
	font = wezterm.font_with_fallback({
		{ family = "Cascadia Code", weight = "Medium" },
		{ family = "JetBrains Mono", weight = "Medium" },
		{ family = "Noto Color Emoji" }, -- optional emoji support
	}),
	font_size = 13,
	colors = {
		background = BG_COLOR,
		foreground = FG_COLOR,
		tab_bar = {
			background = BG_COLOR,
			active_tab = {
				fg_color = BG_COLOR,
				bg_color = FG_COLOR,
				intensity = "Bold",
				italic = false,
			},
			inactive_tab = {
				bg_color = BG_COLOR,
				fg_color = FG_COLOR,
				intensity = "Bold",
			},
		},
	},
	keys = {
		{
			mods = "CTRL",
			key = "phys:f",
			action = wezterm.action_callback(function(win, _)
				local _, pane, _ = win:mux_window():spawn_tab({})
				pane:send_text("lw\n")
			end),
		},
		{
			mods = "CTRL",
			key = "phys:t",
			action = wezterm.action_callback(function(win, _)
				win:mux_window():spawn_tab({ cwd = os.getenv("HOME") })
			end),
		},
		{
			mods = "CTRL",
			key = ";",
			action = wezterm.action({ ActivateTabRelative = 1 }),
		},
		{
			mods = "CTRL",
			key = "phys:s",
			action = wezterm.action({ ActivateTabRelative = -1 }),
		},
		{ key = "1", mods = "ALT", action = act.ActivateTab(0) },

		{ key = "2", mods = "ALT", action = act.ActivateTab(1) },
		{ key = "3", mods = "ALT", action = act.ActivateTab(2) },
		{ key = "4", mods = "ALT", action = act.ActivateTab(3) },
		{ key = "5", mods = "ALT", action = act.ActivateTab(4) },
		{ key = "6", mods = "ALT", action = act.ActivateTab(5) },
		{ key = "7", mods = "ALT", action = act.ActivateTab(6) },
		{ key = "8", mods = "ALT", action = act.ActivateTab(7) },
		{ key = "9", mods = "ALT", action = act.ActivateTab(8) },
		-- Close current tab
		{ key = "w", mods = "ALT", action = act.CloseCurrentTab({ confirm = true }) },

		-- slipt terminal
		{ key = "j", mods = "CTRL|ALT", action = act.SplitPane({ direction = "Down" }) },
		{ key = "l", mods = "CTRL|ALT", action = act.SplitPane({ direction = "Right" }) },
		{ key = "k", mods = "CTRL|ALT", action = act.SplitPane({ direction = "Up" }) },
		{ key = "h", mods = "CTRL|ALT", action = act.SplitPane({ direction = "Left" }) },

		{ key = "q", mods = "ALT", action = act.CloseCurrentPane({ confirm = true }) },
	},
}

return config
