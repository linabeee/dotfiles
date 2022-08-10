#!/bin/bash
# shellcheck disable=2155 disable=1090 disable=2139 disable=2140
prepend() {
    case ":${PATH}:" in
        *:$1:*) return;;
        *) PATH="${1}${PATH:+:${PATH}}"
    esac
}
export FLYCTL_INSTALL=~/.fly
export GOPATH=~/go
export PNPM_HOME=~/.local/share/pnpm
export DENO_INSTALL=~/.deno
#prepend "${HOME}/anaconda3/bin"
prepend "${FLYCTL_INSTALL}/bin"
prepend "${DENO_INSTALL}/bin"
prepend "${GOPATH}/bin"
if [[ -z ${GEM_HOME+x} ]] && command -v gem >/dev/null; then
    export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
    prepend "${GEM_HOME}/bin"
fi
prepend "/usr/local/go/bin"
prepend "${HOME}/.npm/bin"
prepend "${PNPM_HOME}"
prepend "${HOME}/.local/bin"
prepend "${HOME}/.cargo/bin"
prepend "${HOME}/bin"
. ~/.nix-profile/etc/profile.d/nix.sh 2> /dev/null
PATH="$(printf %s "$PATH" | awk -v RS=: -v ORS= '!a[$0]++ { if (NR>1) print ":"; print $0 }')"
if command -v vim > /dev/null; then
    export EDITOR=vim
else
    export EDITOR=vi
fi
export NIX_SHELL_PRESERVE_PROMPT=1
export NO_AT_BRIDGE=1
export MOZ_ENABLE_WAYLAND=1
export TZ=":Europe/London"
export HOMEBREW_NO_ANALYTICS=1
export GTK2_RC_FILES=~/.config/gtkrc-2.0
export TEXMFVAR=~/.cache/texlive/texmf-var
export NODE_REPL_HISTORY=~/.cache/node_repl_history

[[ $- != *i* ]] && return

HISTSIZE=-1
HISTFILE=~/.cache/bash_history
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
export NIX_INSTALLER_NO_MODIFY_PROFILE=1
alias ls='ls -FHh --color=auto'
alias userctl='systemctl --user'
alias juserctl='journalctl --user'
alias gdb='gdb -q'
alias ".git"="git --git-dir=${HOME}/.dotfiles --work-tree=${HOME}"

red="$(tput setaf 1)"
grn="$(tput setaf 2)"
blu="$(tput setaf 4)"
bold="$(tput bold)"
reset="$(tput sgr0)"
PS1='\[$reset\]$([[ -n "$(jobs -p)" ]] && echo "&\j ")\[$red\]$status\[$reset\]\w \[$grn\]\$\[$reset\] '
precmd() {
    local exit=$?
    status=
    [[ $exit -ne 0 ]] && status="${exit} "
    if [[ $TERM =~ xterm || $TERM =~ alacritty ]]; then
        printf "\e]0;%s\a" "${PWD}"
    fi
}
PROMPT_COMMAND=precmd
if [ -n "${SSH_CLIENT}" ]; then
  PS1="\[$bold\]\u@\h\[$reset\] ${PS1}"
fi
if [ -n "${IN_NIX_SHELL}" ]; then
  PS1="nix-shell:${PS1}"
fi

if [[ -s /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
    _completion_loader git
    __git_complete ".git" __git_main
fi

return # ignore bullshit appended by scripts
