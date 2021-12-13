{ pkgs, lib, ... }:
let
  vim-buftabline = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "vim-buftabline";
    src = pkgs.fetchFromGitHub {
      owner = "ap";
      repo = "vim-buftabline";
      rev = "master";
      sha256 = "sha256-vmznVGpM1QhkXpRHg0mEweolvCA9nAOuALGN5U6dRO8=";
    };
  };
  vim-dim = pkgs.vimUtils.buildVimPluginFrom2Nix {
    name = "vim-dim";
    src = pkgs.fetchFromGitHub {
      owner = "jeffkreeftmeijer";
      repo = "vim-dim";
      rev = "main";
      sha256 = "sha256-sDt3gvf+/8OQ0e0W6+IinONQZ9HiUKTbr+RZ2CfJ3FY=";
    };
  };
in
{
  programs.vim = {
    enable = true;
    plugins = with pkgs.vimPlugins; [ ale vim-polyglot vim-commentary vim-buftabline vim-dim ];
    extraConfig = builtins.readFile ./init.vim;
  };
}
