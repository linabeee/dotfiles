{
  allowUnfree = true;
  packageOverrides = pkgs: {
    neovim = pkgs.neovim.overrideAttrs (_: { wrapRc = false; });
  };
}
