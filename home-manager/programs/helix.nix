{pkgs, ...}: {
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
      ansible-language-server
      bash-language-server

      # Dap
      lldb
    ];
  };
}
