{
  allowUnfree = true;
  packageOverrides = pkgs:
    with pkgs; {
      neovim = neovim.overrideAttrs (_: { wrapRc = false; });
      discord = discord.override {
        lib = lib // {
          makeLibraryPath = xs: lib.makeLibraryPath (xs ++ [ libunity ]);
        };
      };
    };
  permittedInsecurePackages = [ "electron-9.4.4" ];
}
