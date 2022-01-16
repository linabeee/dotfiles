#!/bin/bash
# shellcheck disable=2155 disable=1090 disable=2139 disable=2140
if [[ -z ${GEM_HOME+x} ]] && command -v gem >/dev/null; then
    export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
fi
export GOPATH=~/go
export CARGO_HOME=~/.local/share/cargo
export PNPM_HOME="/home/lina/.local/share/pnpm"
PATH="\
${HOME}/bin:\
${HOME}/.local/bin:\
${CARGO_HOME}/bin:\
${PNPM_HOME}:\
"
[[ -n ${GEM_HOME} ]] && PATH="${PATH}:${GEM_HOME}/bin"
PATH="\
${PATH}:\
${GOPATH}/bin:\
/usr/local/go/bin:\
/usr/local/sbin:\
/usr/local/bin:\
/usr/sbin:\
/usr/bin:\
/sbin:\
/bin:\
/usr/games:\
/usr/local/games:\
/snap/bin"
export PATH
. ~/.nix-profile/etc/profile.d/nix.sh 2> /dev/null
if command -v vim > /dev/null; then
    export EDITOR=vim
else
    export EDITOR=vi
fi
export NIX_SHELL_PRESERVE_PROMPT=1
export NO_AT_BRIDGE=1
export MOZ_ENABLE_WAYLAND=1
export NPM_CONFIG_USERCONFIG=~/.config/npmrc
export TZ=":Europe/London"
export HOMEBREW_NO_ANALYTICS=1
export TEXMFVAR=~/.cache/texlive/texmf-var
export RUSTUP_HOME=~/.local/share/rustup
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${HOME}/.config/java"
export CABAL_CONFIG=~/.config/cabal/config
export CABAL_DIR=~/.cache/cabal
export CONDARC=~/.config/conda/condarc
export ELECTRUMDIR=~/.local/share/electrum
export GTK2_RC_FILES=~/.config/gtkrc-2.0
export INPUTRC=~/.config/inputrc

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
export NODE_REPL_HISTORY=~/.cache/node_repl_history
export NIX_INSTALLER_NO_MODIFY_PROFILE=1
alias ls='ls -FHh --color=auto'
alias userctl='systemctl --user'
alias juserctl='journalctl --user'
alias gdb='gdb -q'
alias wget="wget --hsts-file=${HOME}/.cache/wget-hsts"
alias ".git"="git --git-dir=${HOME}/.dotfiles --work-tree=${HOME}"

red="$(tput setaf 1)"
grn="$(tput setaf 2)"
blu="$(tput setaf 4)"
bold="$(tput bold)"
reset="$(tput sgr0)"
PS1='\[$reset\]$([[ -n "$(jobs -p)" ]] && echo "&\j ")\[$red\]$status\[$reset$bold$grn\]\u@\h\[$reset\]:\[$blu\]\w\[$reset\]\$ '
if [[ $TERM =~ xterm ]]; then
    precmd() {
	local exit=$?
	status=
	[[ $exit -ne 0 ]] && status="${exit} "
	printf "\e]0;%s\a" "${PWD}"
    }
    PROMPT_COMMAND=precmd
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
