{pkgs, ...}: {
  programs.direnv.enable = true;
  programs.ripgrep.enable = true;
  programs.bat.enable = true;
  programs.fd.enable = true;
  programs.fzf.enable = true;
  programs.tealdeer.enable = true;
  programs.starship.enable = true;
  programs.yazi.enable = true;
  programs.lazygit.enable = true;
  programs.btop.enable = true;
  programs.eza.enable = true;
  programs.zoxide.enable = true;
  programs.fastfetch.enable = true;

  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
    settings = {
      theme = "catppuccin-mocha";
    };
  };

  home.packages = with pkgs; [
    distrobox
    perf
    hyperfine
    duf
    tokei
    delta
    presenterm
  ];
}
