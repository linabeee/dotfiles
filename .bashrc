#!/bin/bash
# shellcheck disable=1091 disable=1090 disable=1072
# if [[ -z ${GEM_HOME+x} ]] && command -v gem >/dev/null; then
#     export GEM_HOME="$(ruby -e 'puts Gem.user_dir')"
#     GEM_PATH="${GEM_HOME}/bin:"
# fi
export PLAN9="${HOME}/plan9"
export GOPATH="${HOME}/go"
export BUN_INSTALL="$HOME/.bun"
export DENO_INSTALL="${HOME}/.deno"
export HOMEBREW_PREFIX="/opt/homebrew";
export HOMEBREW_REPOSITORY="$HOMEBREW_PREFIX"
export HOMEBREW_CELLAR="${HOMEBREW_PREFIX}/Cellar"
tex_prefix="/usr/local/texlive/2024"
PATH="\
${HOME}/bin:\
${HOME}/emacs/src:\
${HOME}/emacs/lib-src:\
${HOME}/.cargo/bin:\
${HOME}/.local/bin:\
${HOME}/.cabal/bin:\
${HOME}/.ghcup/bin:\
${BUN_INSTALL}/bin:\
${DENO_INSTALL}/bin:\
${GOPATH}/bin:\
/usr/local/go/bin:\
${tex_prefix}/bin/universal-darwin:\
${HOMEBREW_PREFIX}/bin:\
${HOMEBREW_PREFIX}/sbin:\
/opt/local/bin:\
/opt/local/sbin:\
${PATH}:\
${PLAN9}/bin"
# ${GEM_PATH}\
export MANPATH="${tex_prefix}/texmf-dist/doc/man:${HOMEBREW_PREFIX}/share/man:/opt/local/share/man:$MANPATH"
export INFOPATH="${tex_prefix}/texmf-dist/doc/info:${HOMEBREW_PREFIX}/share/info:$INFOPATH"

setup_sdkman() {
    export SDKMAN_DIR="${HOME}/.sdkman"
    if [[ -s "${HOME}/.sdkman/bin/sdkman-init.sh" ]]; then
        . "${HOME}/.sdkman/bin/sdkman-init.sh"
    fi
}

setup_nvm() {
    export NVM_DIR="$HOME/.nvm"
    [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh"
    [[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
}

setup_pyenv() {
    export PYENV_ROOT="$HOME/.pyenv"
    command -v pyenv >/dev/null || export PATH="$PYENV_ROOT/bin:$PATH"
    command -v pyenv >/dev/null && eval "$(pyenv init -)"
}

setup_sdkman
setup_nvm
setup_pyenv

PATH="$(printf %s "$PATH" | awk -v RS=: -v ORS= '!a[$0]++ { if (NR>1) print ":"; print $0 }')"

if command -v nvim > /dev/null; then
    export EDITOR=nvim
elif command -v vim > /dev/null; then
    export EDITOR=vim
else
    export EDITOR=vi
fi
export NIX_SHELL_PRESERVE_PROMPT=1
export NO_AT_BRIDGE=1
export MOZ_ENABLE_WAYLAND=1
export TZ="Europe/London"
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_ENV_HINTS=1
export NIX_INSTALLER_NO_MODIFY_PROFILE=1
export DOTNET_CLI_TELEMETRY_OPTOUT=1

[[ $- != *i* ]] && return

HISTSIZE=4000
HISTFILESIZE="$HISTSIZE"
HISTCONTROL="ignoreboth"
unset MAILCHECK
shopt -s checkwinsize
shopt -s direxpand 2>/dev/null || :
shopt -s histappend
shopt -s no_empty_cmd_completion
set -o noclobber
export QUOTING_STYLE=literal
alias ls='ls -FHh --color'
alias userctl='systemctl --user'
alias juserctl='journalctl --user'
alias gdb='gdb -q'
# shellcheck disable=2139
alias ".git"="git --git-dir=${HOME}/.dotfiles --work-tree=${HOME}"
[[ "$EDITOR" == "nvim" ]] && alias vim=nvim
command -v grm >/dev/null && alias rm=grm

cd() {
  if [ $# = 0 ]; then pushd "$HOME"
  else pushd "$1"
  fi >/dev/null
}

red="$(printf '\e[31m')"
grn="$(printf '\e[32m')"
#blu="$(tput setaf 4)"
bold="$(printf '\e[1m')"
reset="$(printf '\e(B\e[m')"
PS1='\[$reset\]$([[ -z ${SSH_CLIENT+x} ]] || echo "\u@\h:")$([[ -n "$(jobs -p)" ]] && echo "%\j ")\[$red\]$status\[$grn\]$([[ -n "$IN_NIX_SHELL" ]] && echo "nix-shell:")\$\[$reset\] '
precmd() {
    local exit=$?
    status=
    [[ $exit -ne 0 ]] && status="${exit} "
    # if [[ $TERM =~ xterm || $TERM =~ alacritty ]]; then
    #     printf "\e]0;%s\a" "${PWD}"
    # fi
}
PROMPT_COMMAND="precmd; ${PROMPT_COMMAND}"

for bash_completion in /usr/share/bash-completion/bash_completion \
    /opt/homebrew/etc/profile.d/bash_completion.sh; do
    if [[ -r $bash_completion ]]; then
        . "$bash_completion"
        break
        # _completion_loader git
        # __git_complete ".git" __git_main
        # break
    fi
done

return # ignore bullshit appended by scripts

# Local Variables:
# truncate-lines: nil
# End:
