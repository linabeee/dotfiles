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
            bun
            chezmoi
            direnv
            fd
            gitMinimal
            htop
            httpie
            fnm
            jq
            ldns
            libarchive
            ncdu
            nix-direnv
            ripgrep
            shellcheck
            sqlite-interactive
            strace
            topgrade
            vim
            wget
            uv
            yq
          ];
        };
      }
    );
}
