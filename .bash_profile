export PATH="${HOME}/.local/bin:${HOME}/.cargo/bin:${HOME}/.yarn/bin:${GOPATH}/bin:${PATH}"
[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
export PATH="${HOME}/bin:${PATH}"
[ -n "$BASH_VERSION" ] && [ -f ~/.bashrc ] && . ~/.bashrc
[ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ] && . "${HOME}/.nix-profile/etc/profile.d/nix.sh"
true
