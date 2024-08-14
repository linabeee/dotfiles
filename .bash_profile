#!/bin/bash
# shellcheck disable=1091
[[ -z ${BASH_VERSION+x} ]] && return
. "${HOME}/.bashrc"
return

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
