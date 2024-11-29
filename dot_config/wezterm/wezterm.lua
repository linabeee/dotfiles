local wezterm = require 'wezterm'

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
-- function basename(s)
--     return string.gsub(s, '(.*[/\\])(.*)', '%2')
-- end

-- wezterm.on(
--     'format-tab-title',
--     function(tab, tabs, panes, config, hover, max_width)
--         local pane = tab.active_pane
--         local computed_title = string.format("%d: %s", pane.pane_id + 1, basename(pane.foreground_process_name))
--         return {
--             { Text = ' ' .. computed_title .. ' ' },
--         }
--     end
-- )

-- wezterm.on(
--     'format-window-title',
--     function(tab, pane, tabs, panes, config)
--         local pane = tab.active_pane
--         return string.format(
--             "@%s [%d/%d] %s",
--             wezterm.hostname(),
--             tab.tab_index + 1,
--             #tabs,
--             basename(pane.foreground_process_name)
--         )
--     end
-- )

config = wezterm.config_builder()
config.font = wezterm.font_with_fallback {
  "Iosevka Nerd Font",
  "Monospace",
}
config.font_size = 11.0
config.window_padding = {
  top = 1,
  left = 1,
  right = 0,
  bottom = 0,
}
config.use_resize_increments = true
config.colors = { foreground = "#ffffff", }
config.force_reverse_video_cursor = true
config.initial_cols = 98
config.background = {
  {
    source = {Color="black"},
    opacity = 0.91,
    height='100%',
    width='100%'
  },
}
config.window_close_confirmation = "NeverPrompt"
config.swallow_mouse_click_on_pane_focus = true
config.window_frame = {
  font = wezterm.font_with_fallback { "Inter Medium", "Sans" },
  font_size = 10,
}
config.tab_bar_at_bottom = true
-- config.default_ssh_auth_sock = wezterm.home_dir .. "/.1password/agent.sock"
config.ssh_domains = {
  {
    name = "libreelec",
    remote_address = "rpi4",
    username = "root",
  }
}

-- {
--     source = {File=wezterm.config_dir .. "/background.jpg"},
--     opacity = 0.7,
--     hsb = {
--         saturation = 0.4,
--         brightness = 0.3,
--     },
-- },
return config
