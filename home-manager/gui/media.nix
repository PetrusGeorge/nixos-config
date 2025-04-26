{
  pkgs,
  pkgs-stable,
  ...
}:
# media - control and enjoy audio/video
{
  home.packages = with pkgs; [
    # audio control
    # Stable version to avoid crashes
    pkgs-stable.pavucontrol
    vlc
    playerctl
    pulsemixer
    imv # simple image viewer

    nvtopPackages.full

    # video/audio tools
    # cava # for visualizing audio
    libva-utils
    vdpauinfo
    vulkan-tools
    glxinfo
  ];

  programs = {
    mpv = {
      enable = true;
      defaultProfiles = ["gpu-hq"];
      scripts = [pkgs.mpvScripts.mpris];
    };
  };

  services = {
    playerctld.enable = true;
  };
}
