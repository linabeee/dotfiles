# -*- truncate-lines: nil; -*-
fix_path
setopt hist_ignore_dups
setopt hist_ignore_space
setopt append_history
setopt no_bg_nice
setopt no_clobber
setopt interactive_comments
setopt no_auto_menu
setopt auto_continue
setopt no_hup
setopt auto_pushd
HISTSIZE=4000
SAVEHIST=$HISTSIZE
REPORTTIME=4
WORDCHARS="${WORDCHARS//.}"
WORDCHARS="${WORDCHARS//\/}"
export QUOTING_STYLE=literal
alias ls='ls -FHh --color'
alias ".git"="git --git-dir=${HOME}/.dotfiles --work-tree=${HOME}"
[[ "$EDITOR" == "nvim" ]] && alias vim=nvim
(( $+commands[grm] )) && alias rm=grm
PROMPT="$( (( ${+SSH_CLIENT} )) && echo '%n@%m:')%~ $( (( ${+IN_NIX_SHELL} )) && echo 'nix-shell:')%F{green}%#%f "
RPROMPT='%F{red}%(?..%? )%f%(1j.%j%% .)'
autoload -Uz compinit && compinit
bind_shit() {
  bindkey -e
  bindkey $terminfo[kdch1] delete-char
  # bindkey '^A' beginning-of-line
  # bindkey '^E' end-of-line
  if autoload -Uz history-search-end; then
    zle -N history-beginning-search-backward-end history-search-end
    zle -N history-beginning-search-forward-end history-search-end
    bindkey '^[[A' history-beginning-search-backward-end
    bindkey '^[[B' history-beginning-search-forward-end
  fi
}
bind_shit &>/dev/null

window_title() {
  builtin echo -ne "\033]0;$PWD\007"
}
[[ "$TERM" =~ "xterm" || "$TERM" =~ "alacritty" ]] && add-zsh-hook precmd window_title
