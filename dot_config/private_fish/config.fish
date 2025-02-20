set -g fish_color_command normal
set -g fish_color_param normal
if status is-interactive
    # Commands to run in interactive sessions can go here
    abbr juserctl='journalctl --user'
end
