XDG_CONFIG_HOME="${XDG_CONFIG_DIR:=$HOME/.config}"
XDG_CACHE_HOME="${XDG_CACHE_HOME:=$HOME/.cache}"
ZDOTDIR="${XDG_CONFIG_HOME}/zsh/"
typeset -U path PATH
gem_path() {
  for ruby in ~/.gem/ruby/*(N); do
    path=("${ruby}/bin" $path)
  done
}
path=(
  ~/bin
  ~/.local/bin
  ~/.cargo/bin
  ~/.yarn/bin
  ~/go/bin
  ~/.config/emacs/bin
  $path
)
export GOPATH="${XDG_CACHE_HOME}/go"
if (( $+commands[nvim] )); then
  export EDITOR=nvim
elif (( $+commands[vim] )); then
  export EDITOR=vim
else
  export EDITOR=vi
fi
export NO_AT_BRIDGE=1
export MOZ_ENABLE_WAYLAND=1
#export QT_QPA_PLATFORMTHEME=qt5ct
export NPM_CONFIG_USERCONFIG="${XDG_CONFIG_HOME}/npmrc"
if [ -e /home/lina/.nix-profile/etc/profile.d/nix.sh ]; then . /home/lina/.nix-profile/etc/profile.d/nix.sh; fi # added by Nix installer
. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" 2>/dev/null
