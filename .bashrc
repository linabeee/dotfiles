export GOPATH="${HOME}/go"
export PATH="\
${HOME}/bin:\
${HOME}/.local/bin:\
${HOME}/.cargo/bin:\
${HOME}/.ghcup/bin:\
${GOPATH}/bin:\
/usr/local/go/bin:\
/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin"
XDG_CONFIG_HOME="${XDG_CONFIG_DIR:=${HOME}/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:=${HOME}/.cache}"
if command -v nvim > /dev/null; then
    export EDITOR=nvim
elif command -v vim > /dev/null; then
    export EDITOR=vim
else
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
export NIX_SHELL_PRESERVE_PROMPT=1
alias ls='ls -FHh --color=auto'
alias userctl='systemctl --user'
alias juserctl='journalctl --user'
alias gdb='gdb -q'
alias wget="wget --hsts-file=${XDG_CACHE_HOME}/wget-hsts"
[[ $EDITOR == nvim ]] && alias vim=nvim

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

[[ -e ~/.nix-profile/etc/profile.d/nix.sh ]] && . ~/.nix-profile/etc/profile.d/nix.sh

nixos-update() {
  sudo nix-channel --update
  sudo nixos-rebuild --upgrade $1
  nix-channel --update
  nix-env -u
}
