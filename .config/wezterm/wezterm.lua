local wezterm = require 'wezterm'

-- Equivalent to POSIX basename(3)
-- Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
function basename(s)
    return string.gsub(s, '(.*[/\\])(.*)', '%2')
end

wezterm.on(
    'format-tab-title',
    function(tab, tabs, panes, config, hover, max_width)
        local pane = tab.active_pane
        local computed_title = string.format("%d: %s", pane.pane_id + 1, basename(pane.foreground_process_name))
        return {
            { Text = ' ' .. computed_title .. ' ' },
        }
    end
)

wezterm.on(
    'format-window-title',
    function(tab, pane, tabs, panes, config)
        local pane = tab.active_pane
        return string.format(
            "@%s [%d/%d] %s",
            wezterm.hostname(),
            tab.tab_index + 1,
            #tabs,
            basename(pane.foreground_process_name)
        )
    end
)

return {
    font = wezterm.font("DejaVu Sans Mono"),
    font_size = 10.0,
    use_fancy_tab_bar = false,
    window_padding = {
        top = 0,
        left = 0,
        right = 0,
        bottom = 0,
    },
    use_resize_increments = true,
    colors = {
        foreground = "#ffffff",
    },
    force_reverse_video_cursor = true,
    initial_cols = 124,
    initial_rows = 34,
    background = {
        {
            source = {File=wezterm.config_dir .. "/background.jpg"},
            opacity = 0.7,
            hsb = {
                saturation = 0.4,
                brightness = 0.3,
            },
        },
        {
            source = {Color="black"},
            opacity = 0.7,
            height='100%',
            width='100%'
        },
    },
}
