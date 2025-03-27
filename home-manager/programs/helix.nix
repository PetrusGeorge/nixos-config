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
    languages = {
      language-server = {
        rust-analyzer.config = {
          check.command = "clippy";
          cargo.features = "all";
        };
      };
    };
    extraPackages = with pkgs; [
      # Language Servers
      lua-language-server
      stylua
      rust-analyzer
      mesonlsp
      nil
      clang-tools
      ansible-language-server
      bash-language-server
      python312Packages.python-lsp-server
      ruff
      docker-compose-language-service
      dockerfile-language-server-nodejs

      # Dap
      lldb
    ];
  };
}
