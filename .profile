export PATH="\
${HOME}/.local/bin:\
${HOME}/.cargo/bin:\
${HOME}/.ghcup/bin:\
${HOME}/.yarn/bin:\
${HOME}/.deno/bin:\
${GOPATH}/bin:\
${PATH}"
[ -x "/home/linuxbrew/.linuxbrew/bin/brew" ] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
[ -e "${HOME}/.nix-profile/etc/profile.d/nix.sh" ] && . "${HOME}/.nix-profile/etc/profile.d/nix.sh"
export PATH="${HOME}/bin:${PATH}"
export PROFILE_DONE=1
[ -n "$BASH_VERSION" ] && [ -f ~/.bashrc ] && . ~/.bashrc
true
