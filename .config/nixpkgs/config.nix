{
  allowUnfree = true;
  # autoOptimiseStore = true;
  packageOverrides = pkgs: {
    tor-browser = pkgs.buildEnv {
      name = "tor-browser";
      paths = [ pkgs.tor-browser-bundle-bin ];
    };
    vscode-go-tools = pkgs.buildEnv {
      name = "vscode-go-tools";
      paths = with pkgs; [ delve go-outline gopkgs gopls go-tools ];
    };
    cargo-with-commands = pkgs.buildEnv {
      name = "cargo-with-commands";
      paths = [ pkgs.cargo pkgs.cargo-edit ];
    };
    # neovim = pkgs.neovim.overrideAttrs (_: { wrapRc = false; });
    irssi = pkgs.irssi.overrideAttrs (_: { dontStrip = true; });
  };
}
