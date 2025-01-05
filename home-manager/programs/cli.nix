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
  programs.thefuck.enable = true;

  programs.zellij = {
    enable = true;
    settings = {
      theme = "catppuccin-mocha";
    };
  };

  # Testing helix
  programs.helix = {
    enable = true;
    settings = {
      theme = "catppuccin_mocha";
      editor = {
        #line-number = "relative";
        lsp.display-messages = true;
        cursor-shape.insert = "bar";
      };
    };
    extraPackages = with pkgs; [
      # Language Servers
      lua-language-server
      stylua
      rust-analyzer
      mesonlsp
      pyright
      nil
      clang-tools

      # Dap
      lldb
    ];
  };

  home.packages = with pkgs; [
    hyperfine
    duf
    tokei
    delta
    presenterm
  ];
}
