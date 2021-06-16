XDG_CACHE_HOME="${XDG_CACHE_HOME:=$HOME/.cache}"

# shell options
setopt HIST_IGNORE_DUPS
setopt HIST_IGNORE_SPACE
setopt APPEND_HISTORY
setopt NO_BG_NICE
setopt PROMPT_SUBST
setopt INTERACTIVE_COMMENTS
setopt NO_CLOBBER
setopt LIST_PACKED
setopt NO_AUTO_MENU
setopt AUTO_CONTINUE
setopt NO_HUP
HISTSIZE=2000
SAVEHIST=$HISTSIZE
HISTFILE="${XDG_CACHE_HOME}/zsh/history"
REPORTTIME=4
WORDCHARS="${WORDCHARS//.}"
WORDCHARS="${WORDCHARS//\/}"
typeset -U fpath

# env
export QUOTING_STYLE=literal
export LESSHISTFILE='-'
export NODE_REPL_HISTORY="${XDG_CACHE_HOME}/node_repl_history"

# aliases
# if (( $+commands[exa] )); then
#   alias ls='exa -Fg --git'
# else
  alias ls='ls -FHh --color=auto'
# fi
# (( $+commands[nvim] )) && alias vim=nvim
(( $+commands[chg] )) && alias hg=chg
unlock() { export BW_SESSION="$(bw unlock --raw)" }
alias userctl='systemctl --user'
alias juserctl='journalctl --user'
alias gdb='gdb -q'
alias wget="wget --hsts-file=${XDG_CACHE_HOME}/wget-hsts"
# alias yarn="yarn --use-yarnrc ${XDG_CONFIG_HOME}/yarnrc"

# functions
setgtktheme() {
  local GNOME_SCHEMA="org.gnome.desktop.interface"
  gsettings set $GNOME_SCHEMA font-name "Noto Sans 10"
  gsettings set $GNOME_SCHEMA icon-theme "Breeze"
  gsettings set $GNOME_SCHEMA gtk-theme "Breeze"
}

startkde() {
  export XDG_SESSION_TYPE=wayland
  dbus-run-session startplasma-wayland
}

rdp() {
  local _USER=$1
  local _HOST=$2
  wlfreerdp +bitmap-cache /u:$_USER /v:$_HOST /size:1366x768 /f -wallpaper +async-input /gfx-h264:AVC444 /bpp:16 -encryption /compression-level:2 +glyph-cache -grab-keyboard
}

nixos-update() {
  (
  set -ex
  sudo nix-channel --update
  sudo nixos-rebuild switch
  nix-channel --update
  nix-env -u '*'
  )
}

# prompt
precmd() {
  print -Pn "\e]0;${PWD}\a"
}

PROMPT='%(1j.%j& .)%~ %(!.%F{red}#.%F{green}%#)%f '
[[ -n "${SSH_CLIENT}" ]] && PROMPT="%B%n@%m%b ${PROMPT}"
RPROMPT='%F{red}%(?..%? )%f'

# keybindings
bindkey -e
bindkey '\C-u' backward-kill-line
autoload -Uz history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end
bindkey $terminfo[kcuu1] history-beginning-search-backward-end
bindkey $terminfo[kcud1] history-beginning-search-forward-end
bindkey $terminfo[khome] beginning-of-line
bindkey $terminfo[kend] end-of-line
bindkey $terminfo[kdch1] delete-char
if (( $+terminfo[kRIT5] && $+terminfo[kLFT5] )); then
  bindkey $terminfo[kRIT5] forward-word
  bindkey $terminfo[kLFT5] backward-word
else
  bindkey '^[[1;5C' forward-word
  bindkey '^[[1;5D' backward-word
fi
if (( $+terminfo[smkx] && $+terminfo[rmkx] )); then
  zle-line-init() {
    echoti smkx
  }
  zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

_tmux_copy_mode() {
  tmux copy-mode -eu
}
zle -N _tmux_copy_mode
[[ $TMUX_PANE && -n $terminfo[kpp] ]] && bindkey $terminfo[kpp] _tmux_copy_mode

[[ -d "${XDG_CACHE_HOME}/zsh" ]] || mkdir -p "${XDG_CACHE_HOME}/zsh"
autoload -Uz compinit && compinit -d "${XDG_CACHE_HOME}/zsh/zcompdump-${ZSH_VERSION}"

base16_monokai() {
# base16-shell (https://github.com/chriskempson/base16-shell)
# Base16 Shell template by Chris Kempson (http://chriskempson.com)
# Monokai scheme by Wimer Hazenberg (http://www.monokai.nl)

color00="27/28/22" # Base 00 - Black
color01="f9/26/72" # Base 08 - Red
color02="a6/e2/2e" # Base 0B - Green
color03="f4/bf/75" # Base 0A - Yellow
color04="66/d9/ef" # Base 0D - Blue
color05="ae/81/ff" # Base 0E - Magenta
color06="a1/ef/e4" # Base 0C - Cyan
color07="f8/f8/f2" # Base 05 - White
color08="75/71/5e" # Base 03 - Bright Black
color09=$color01 # Base 08 - Bright Red
color10=$color02 # Base 0B - Bright Green
color11=$color03 # Base 0A - Bright Yellow
color12=$color04 # Base 0D - Bright Blue
color13=$color05 # Base 0E - Bright Magenta
color14=$color06 # Base 0C - Bright Cyan
color15="f9/f8/f5" # Base 07 - Bright White
color16="fd/97/1f" # Base 09
color17="cc/66/33" # Base 0F
color18="38/38/30" # Base 01
color19="49/48/3e" # Base 02
color20="a5/9f/85" # Base 04
color21="f5/f4/f1" # Base 06
color_foreground="f8/f8/f2" # Base 05
color_background="27/28/22" # Base 00

if [ -n "$TMUX" ]; then
  # Tell tmux to pass the escape sequences through
  # (Source: http://permalink.gmane.org/gmane.comp.terminal-emulators.tmux.user/1324)
  put_template() { printf '\033Ptmux;\033\033]4;%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_var() { printf '\033Ptmux;\033\033]%d;rgb:%s\033\033\\\033\\' $@; }
  put_template_custom() { printf '\033Ptmux;\033\033]%s%s\033\033\\\033\\' $@; }
elif [ "${TERM%%[-.]*}" = "screen" ]; then
  # GNU screen (screen, screen-256color, screen-256color-bce)
  put_template() { printf '\033P\033]4;%d;rgb:%s\007\033\\' $@; }
  put_template_var() { printf '\033P\033]%d;rgb:%s\007\033\\' $@; }
  put_template_custom() { printf '\033P\033]%s%s\007\033\\' $@; }
elif [ "${TERM%%-*}" = "linux" ]; then
  put_template() { [ $1 -lt 16 ] && printf "\e]P%x%s" $1 $(echo $2 | sed 's/\///g'); }
  put_template_var() { true; }
  put_template_custom() { true; }
else
  put_template() { printf '\033]4;%d;rgb:%s\033\\' $@; }
  put_template_var() { printf '\033]%d;rgb:%s\033\\' $@; }
  put_template_custom() { printf '\033]%s%s\033\\' $@; }
fi

# 16 color space
put_template 0  $color00
put_template 1  $color01
put_template 2  $color02
put_template 3  $color03
put_template 4  $color04
put_template 5  $color05
put_template 6  $color06
put_template 7  $color07
put_template 8  $color08
put_template 9  $color09
put_template 10 $color10
put_template 11 $color11
put_template 12 $color12
put_template 13 $color13
put_template 14 $color14
put_template 15 $color15

# 256 color space
put_template 16 $color16
put_template 17 $color17
put_template 18 $color18
put_template 19 $color19
put_template 20 $color20
put_template 21 $color21

# foreground / background / cursor color
if [ -n "$ITERM_SESSION_ID" ]; then
  # iTerm2 proprietary escape codes
  put_template_custom Pg f8f8f2 # foreground
  put_template_custom Ph 272822 # background
  put_template_custom Pi f8f8f2 # bold color
  put_template_custom Pj 49483e # selection color
  put_template_custom Pk f8f8f2 # selected text color
  put_template_custom Pl f8f8f2 # cursor
  put_template_custom Pm 272822 # cursor text
else
  put_template_var 10 $color_foreground
  if [ "$BASE16_SHELL_SET_BACKGROUND" != false ]; then
    put_template_var 11 $color_background
    if [ "${TERM%%-*}" = "rxvt" ]; then
      put_template_var 708 $color_background # internal border (rxvt)
    fi
  fi
  put_template_custom 12 ";7" # cursor (reverse video)
fi

# clean up
unset -f put_template
unset -f put_template_var
unset -f put_template_custom
unset color00
unset color01
unset color02
unset color03
unset color04
unset color05
unset color06
unset color07
unset color08
unset color09
unset color10
unset color11
unset color12
unset color13
unset color14
unset color15
unset color16
unset color17
unset color18
unset color19
unset color20
unset color21
unset color_foreground
unset color_background
}
# base16_monokai
