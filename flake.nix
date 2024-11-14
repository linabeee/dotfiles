{
  inputs = {
    nixpkgs.url = "nixpkgs";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    {
      self,
      flake-utils,
      nixpkgs,
      ...
    }:
    flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
      in
      {
        packages.default = pkgs.buildEnv {
          name = "dotfiles";
          paths = with pkgs; [
            _1password-cli
            aria2
            bun
            chezmoi
            direnv
            fd
            gitMinimal
            htop
            httpie
            jq
            ldns
            libarchive
            ncdu
            nix-direnv
            ripgrep
            sqlite-interactive
            topgrade
            vim
            wget
            wl-clipboard
            yq
          ];
        };
      }
    );
}
