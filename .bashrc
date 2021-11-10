[[ "$PROFILE_DONE" == "1" ]] || . ~/.profile
XDG_CONFIG_HOME="${XDG_CONFIG_DIR:=$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:=$HOME/.cache}"
GOPATH="${HOME}/go"
if command -v nvim > /dev/null; then
    export EDITOR=nvim
elif command -v vim > /dev/null; then
    export EDITOR=vim
elif command -v nvi > /dev/null; then
    export EDITOR=nvi
elif command -v vi > /dev/null; then
    export EDITOR=vi
fi
export NO_AT_BRIDGE=1
export MOZ_ENABLE_WAYLAND=1
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npmrc"
export NPM_CONFIG_PREFIX="${HOME}/.local"
export TZ=":Europe/London"
export HOMEBREW_NO_ANALYTICS=1
export DENO_INSTALL="${HOME}/.deno"

[[ $- != *i* ]] && return

[[ -e '/usr/share/bash-completion/bash_completion' ]] && . /usr/share/bash-completion/bash_completion
HISTSIZE=-1
HISTFILE="${XDG_CACHE_HOME}/bash_history"
HISTFILESIZE=-1
HISTCONTROL="ignoreboth"
unset MAILCHECK
shopt -s checkwinsize
shopt -s direxpand
shopt -s histappend
shopt -s no_empty_cmd_completion
set -o noclobber
export QUOTING_STYLE=literal
export LESSHISTFILE='-'
export NODE_REPL_HISTORY="${XDG_CACHE_HOME}/node_repl_history"
alias ls='ls -FHh --color=auto'
alias userctl='systemctl --user'
alias juserctl='journalctl --user'
alias gdb='gdb -q'
alias wget="wget --hsts-file=${XDG_CACHE_HOME}/wget-hsts"
command -v nvim > /dev/null && alias vim=nvim

#red=$(echo -en '\e[31m')
red="$(tput setaf 1)"
#grn=$(echo -en '\e[32m')
grn="$(tput setaf 2)"
#bold=$(echo -en '\e[1m')
bold="$(tput bold)"
#reset=$(echo -en '\e(B\e[m')
reset="$(tput sgr0)"
PS1='\[$reset\]$([[ -n "$(jobs -p)" ]] && echo "&\j ")\[$red\]$status\[$reset\]\w \[$grn\]\$\[$reset\] '
if [[ $TERM =~ xterm ]]; then
    precmd() {
	local exit=$?
	status=
	[[ $exit -ne 0 ]] && status="${exit} "
	printf "\e]0;${PWD}\a"
    }
    PROMPT_COMMAND=precmd
fi
if [ -n "${SSH_CLIENT}" ]; then
  PS1="\[$bold\]\u@\h\[$reset\] ${PS1}"
fi

nixos-update() {
  sudo nix-channel --update
  sudo nixos-rebuild switch
  nix-channel --update
  nix-env -u
}
