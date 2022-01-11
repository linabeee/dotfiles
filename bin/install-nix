#!/bin/bash
args=("${@}")
# if [ "${args[*]}" != "*--no-daemon*" ]; then
#     args+=("--daemon")
# fi
if ! command -v nix >/dev/null; then
    export NIX_INSTALLER_NO_MODIFY_PROFILE=1
    sh <(curl -L 'https://nixos.org/nix/install') "${args[@]}" || exit $?
fi
#shellcheck disable=1090
. "${HOME}/.nix-profile/etc/profile.d/nix.sh"
channels="$(nix-channel --list)"
# if ! echo "$channels" | grep 'home-manager'; then
#     release=$(echo "$channels" | sed -E 's/.*nixos.org.*\/nix(pkgs|os)-//')
#     if [ "$release" = unstable ]; then
#         nix-channel --add 'https://github.com/nix-community/home-manager/archive/master.tar.gz' home-manager
#     else
#         nix-channel --add "https://github.com/nix-community/home-manager/archive/release-${release}.tar.gz" home-manager
#     fi
# fi

# if ! echo "$channels" | grep nixgl; then
#     nix-channel --add https://github.com/guibou/nixGL/archive/main.tar.gz nixgl
# fi
nix-channel --update
