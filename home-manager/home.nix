{...}: {
  imports = [
    ./programs
    ./gui
  ];

  home = {
    username = "petrus";
    homeDirectory = "/home/petrus";
  };

  # nix helper
  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/home/petrus/.config/nixos";
  };

  programs.home-manager.enable = true;
  home.sessionVariables = {
    EDITOR = "vim";
  };

  ## Nicely reload system units when changing configs
  systemd.user.startServices = "sd-switch";

  ## https://nixos.wiki/wiki/FAQ/When_do_I_update_stateVersion
  home.stateVersion = "24.11";
}
