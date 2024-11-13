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
setopt promptsubst
HISTSIZE=4000
SAVEHIST=$HISTSIZE
REPORTTIME=4
HISTFILE="${HOME}/.zsh_history"
WORDCHARS="${WORDCHARS//.}"
WORDCHARS="${WORDCHARS//\/}"
export QUOTING_STYLE=literal
alias ls='ls -FHh --color'
alias ".git"="git --git-dir=${HOME}/.dotfiles --work-tree=${HOME}"
alias emacsclient='emacsclient -nq'
alias userctl='systemctl --user'
alias juserctl='journalctl --user -b'
alias journalctl='journalctl -b'
alias k='kubectl'
alias ka='kubectl apply'
alias kd='kubectl delete -f'
alias kdel='kubectl delete'
alias kdiff='kubectl diff'
alias kex='kubectl explain'
alias ko='kubectl get -o=yaml'
alias kg='kubectl get'
alias kdesc='kubectl describe'
alias kro='kubectl rollout'
alias klog='kubectl logs'
alias kus='kubectl kustomize'
alias kres='kubectl rollout restart'
make_ansible_alias() {
  local suffix="$1"
  alias "ansible${suffix}"="env LC_ALL=C.UTF-8 ansible${suffix}"
}
for suffix in "" "-playbook" "-config"; do
  make_ansible_alias "$suffix"
done

(( $+commands[nvim] )) && alias vim=nvim
(( $+commands[grm] )) && alias rm=grm
in_nix_shell() {
  (( ${+IN_NIX_SHELL} )) || ( (( SHLVL > 1 )) && [[ "$PATH" =~ "/nix/store" ]])
  return $?
}
vterm_printf() {
  if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ]); then
    # Tell tmux to pass the escape sequences through
    printf "\ePtmux;\e\e]%s\007\e\\" "$1"
  elif [ "${TERM%%-*}" = "screen" ]; then
    # GNU screen (screen, screen-256color, screen-256color-bce)
    printf "\eP\e]%s\007\e\\" "$1"
  else
    printf "\e]%s\e\\" "$1"
  fi
}
PROMPT="$( (( ${+SSH_CLIENT} )) && echo '%n@%m:')%~ $(in_nix_shell && echo '')%F{green}%#%f %{$(vterm_printf "51;A${USER}@${HOST}:${PWD}")%}"
RPROMPT='%F{red}%(?..%? )%f%(1j.%j%% .)'
autoload -Uz compinit && compinit
autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkeys() {
 bindkey -e
 bindkey $terminfo[kdch1] delete-char
 bindkey "^[[A" up-line-or-beginning-search
 bindkey "^[[B" down-line-or-beginning-search
 bindkey $terminfo[kLFT3] backward-word
 bindkey $terminfo[kRIT3] forward-word
}
bindkeys &> /dev/null

window_title() {
  builtin echo -ne "\033]0;$PWD\007"
}
autoload -Uz add-zsh-hook
[[ "$TERM" =~ "xterm" || "$TERM" =~ "alacritty" ]] && add-zsh-hook precmd window_title
