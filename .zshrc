# -*- truncate-lines: nil; -*-
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
bindkey -e
bind_shit() {
  bindkey $terminfo[kdch1] delete-char
  if autoload -Uz history-search-end; then
    zle -N history-beginning-search-backward-end history-search-end
    zle -N history-beginning-search-forward-end history-search-end
    bindkey $terminfo[kcuu1] history-beginning-search-backward-end
    bindkey $terminfo[kcud1] history-beginning-search-forward-end
  fi
}
bind_shit &>/dev/null
