{ config, pkgs, lib, ... }:

{
  home = {
    username = builtins.getEnv "USER";
    homeDirectory = builtins.getEnv "HOME";

    stateVersion = "22.05";
  };

  programs.home-manager.enable = true;

  imports = [ ./vim.nix ];

  programs.git = {
    enable = true;
    package = pkgs.gitFull;
    extraConfig = {
      user = { useConfigOnly = true; };
      credential = { helper = "cache"; };
      init = { defaultBranch = "main"; };
    };
    aliases = {
      ci = "commit";
      st = "status";
      hub = "!git config user.name lina && git config user.email 36717206+linabeee@users.noreply.github.com && git config --local --get-regexp user";
      diff = "diff ':!package-lock.json' ':!yarn.lock' ':!pnpm-lock.yaml'";
    };
  };
}
