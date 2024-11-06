export HOMEBREW_PREFIX="/opt/homebrew"
tex_prefix="/usr/local/texlive/2024"
typeset -U path
fix_path() {
  path=(
    ~/bin
    # ~/emacs/src
    # ~/emacs/lib-src
    # ~/.cargo/bin
    ~/.local/bin
    # ~/.cabal/bin
    # ~/.ghcup/bin
    # ~/.bun/bin
    # ~/go/bin
    # ~/.pyenv/bin
    # ~/.pyenv/shims
    # "${tex_prefix}/bin/universal-darwin"
    # "${HOMEBREW_PREFIX}/opt/openjdk/bin"
    # "${HOMEBREW_PREFIX}/bin"
    # "${HOMEBREW_PREFIX}/sbin"
    # /usr/local/go/bin
    $path
  )
}
# export MANPATH="${tex_prefix}/texmf-dist/doc/man:${HOMEBREW_PREFIX}/share/man:$MANPATH"
# export INFOPATH="${tex_prefix}/texmf-dist/doc/info:${HOMEBREW_PREFIX}/share/info:$INFOPATH"

setup_sdkman() {
    export SDKMAN_DIR="${HOME}/.sdkman"
    [[ -s "${SDKMAN_DIR}/bin/sdkman-init.sh" ]] && . "${SDKMAN_DIR}/bin/sdkman-init.sh"
}

setup_nvm() {
    export NVM_DIR="$HOME/.nvm"
    [[ -s "$NVM_DIR/nvm.sh" ]] && . "$NVM_DIR/nvm.sh" --no-use
    [[ -s "$NVM_DIR/bash_completion" ]] && . "$NVM_DIR/bash_completion"
}

setup_pyenv() {
    export PYENV_ROOT="$HOME/.pyenv"
    (( $+commands[pyenv] )) || path=("$PYENV_ROOT/bin" $path)
    (( $+commands[pyenv] )) && eval "$(pyenv init -)"
}

# setup_sdkman
setup_nvm
setup_pyenv
fix_path

if (( $+commands[nvim] )); then
  EDITOR=nvim
elif (( $+commands[vim] )); then
  EDITOR=vim
else
  EDITOR=vi
fi
if (( $+commands[emacsclient] )); then
  export ALTERNATE_EDITOR="$EDITOR"
  EDITOR=emacsclient
fi
export EDITOR
export DOTNET_CLI_TELEMETRY_OPTOUT=1
export HOMEBREW_NO_ANALYTICS=1
export HOMEBREW_NO_EMOJI=1
export HOMEBREW_NO_ENV_HINTS=1
export MOZ_ENABLE_WAYLAND=1
export NIX_INSTALLER_NO_MODIFY_PROFILE=1
export NIX_SHELL_PRESERVE_PROMPT=1
export NO_AT_BRIDGE=1
export SHELL_SESSIONS_DISABLE=1
export TZ="Europe/London"
export PYTHON_BUILD_HTTP_CLIENT=curl
export FREETYPE_PROPERTIES="cff:no-stem-darkening=0 autofitter:no-stem-darkening=0"
export LIBVIRT_DEFAULT_URI='qemu:///session'
export DIRENV_WARN_TIMEOUT='1h'

(( $+commands[direnv] )) && eval "$(direnv hook zsh)"
