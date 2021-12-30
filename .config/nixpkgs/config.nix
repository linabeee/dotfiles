{
  allowUnfree = true;
  packageOverrides = pkgs:
    {
      discord = pkgs.discord.override {
        lib = pkgs.lib // {
          makeLibraryPath = xs: pkgs.lib.makeLibraryPath (xs ++ [ pkgs.libunity ]);
        };
      };
    };
  permittedInsecurePackages = [ "electron-9.4.4" ];
}
