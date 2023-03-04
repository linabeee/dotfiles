{
  allowUnfree = true;
  packageOverrides = pkgs:
    {
      discord = 
      if pkgs.stdenv.isLinux
      then pkgs.discord.override {
        lib = pkgs.lib // {
          makeLibraryPath = xs: pkgs.lib.makeLibraryPath (xs ++ [ pkgs.libunity ]);
        };
      } 
      else pkgs.discord;
      linaEnv = pkgs.buildEnv {
        name = "lina-mac-env";
        paths = with pkgs; [
          yt-dlp htop ripgrep sloccount wget ffmpeg_5
        ];
      };
    };
  permittedInsecurePackages = [ "electron-9.4.4" ];
}
