{...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "petrus.george.leal@gmail.com";
    userName = "PetrusGeorge";
    delta.enable = true;
    signing.format = "ssh";
    extraConfig = {
      commit.gpgsign = true;
      user.signingkey = "~/.ssh/id_signGit.pub";
      init.defaultBranch = "main";
      core.editor = "vim";
    };
  };
}
