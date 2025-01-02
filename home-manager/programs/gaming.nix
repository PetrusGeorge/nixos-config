{pkgs, ...}: {
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
  };

  home.packages = with pkgs; [
    #TODO: Gaming dir
    gamescope
    goverlay
    protonup-qt
  ];
}
