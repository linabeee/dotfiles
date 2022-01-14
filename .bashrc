# shellcheck shell=bash
XDG_DATA_HOME=~/.local/share
export GOPATH=~/go
export DENO_INSTALL=~/.deno
export RBENV_ROOT=~/.local/share/rbenv
export PATH="\
${HOME}/bin:\
${HOME}/.local/bin:\
${HOME}/.cargo/bin:\
${HOME}/.ghcup/bin:\
${DENO_INSTALL}/bin:\
${RBENV_ROOT}/bin:\
${GOPATH}/bin:\
/usr/local/sbin:\
/usr/local/bin:\
/usr/sbin:\
/usr/bin:\
/sbin:\
/bin:\
/usr/games:\
/usr/local/games:\
/snap/bin"
# shellcheck disable=1090
[[ -e ~/.nix-profile/etc/profile.d/nix.sh ]] && . ~/.nix-profile/etc/profile.d/nix.sh
command -v rbenv >/dev/null && eval "$(rbenv init -)"
if command -v vim > /dev/null; then
    export EDITOR=vim
elif command -v nvim > /dev/null; then
    export EDITOR=nvim
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
export RUSTUP_HOME="${XDG_DATA_HOME}/rustup"
export _JAVA_OPTIONS="-Djava.util.prefs.userRoot=${HOME}/.config/java"
export CABAL_CONFIG=~/.config/cabal/config
export CABAL_DIR=~/.cache/cabal
export CONDARC=~/.config/conda/condarc
export ELECTRUMDIR=~/.local/share/electrum
export GTK2_RC_FILES="${HOME}/.config/gtkrc-2.0"
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
alias ls='ls -FHh --color=auto'
alias userctl='systemctl --user'
alias juserctl='journalctl --user'
alias gdb='gdb -q'
# shellcheck disable=2139
alias wget="wget --hsts-file=${HOME}/.cache/wget-hsts"
# shellcheck disable=2140 disable=2139
alias ".git"="git --git-dir=${HOME}/.dotfiles --work-tree=${HOME}"

red="$(tput setaf 1)"
grn="$(tput setaf 2)"
bold="$(tput bold)"
reset="$(tput sgr0)"
PS1='\[$reset\]$([[ -n "$(jobs -p)" ]] && echo "&\j ")\[$red\]$status\[$reset\]\w \[$grn\]\$\[$reset\] '
if [[ $TERM =~ xterm ]]; then
    precmd() {
	local exit=$?
	status=
	[[ $exit -ne 0 ]] && status="${exit} "
	printf "\e]0;%s\a" "${PWD}"
    }
    PROMPT_COMMAND=precmd
fi
if [ -n "${SSH_CLIENT}" ]; then
  PS1="\[$bold\]\u@\h\[$reset\] ${PS1}"
fi
if [ -n "${IN_NIX_SHELL}" ]; then
  PS1="nix-shell:${PS1}"
fi

if [[ -s /usr/share/bash-completion/bash_completion ]]; then
    . /usr/share/bash-completion/bash_completion
    _completion_loader git
    true
    __git_complete ".git" __git_main
fi

nixos-update() {
  sudo nix-channel --update
  sudo nixos-rebuild --upgrade $1
  nix-channel --update
  nix-env -u
}
