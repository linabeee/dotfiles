if status is-interactive
    set -g fish_color_command normal
    set -g fish_color_param normal

    abbr --add juserctl journalctl --user

    if command -q tailscale
      tailscale completion fish | source
    end
end
