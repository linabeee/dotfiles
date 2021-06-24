export PATH="${HOME}/.local/bin:${HOME}/.cargo/bin:${HOME}/.yarn/bin:${GOPATH}/bin:${PATH}"
[[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="${HOME}/bin:${PATH}"
[[ -n "$BASH_VERSION" && -f ~/.bashrc ]] && . ~/.bashrc
