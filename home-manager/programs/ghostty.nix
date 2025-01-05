{pkgs, ...}: {
  programs.ghostty = {
    enable = true;
    package = pkgs.ghostty;
    settings = {
      theme = "catppuccin-mocha";
      window-decoration = false;
      confirm-close-surface = false;
    };
  };
}
