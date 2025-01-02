{...}: {
  programs.git = {
    enable = true;
    lfs.enable = true;
    userEmail = "petrus.george.leal@gmail.com";
    userName = "PetrusGeorge";
    delta.enable = true;
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      user.signingkey = "~/.ssh/id_signGit.pub";
      init.defaultBranch = "main";
      core.editor = "vim";
    };
  };
}
