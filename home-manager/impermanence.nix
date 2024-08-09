{
  pkgs,
  inputs,
  ...
}: {
  imports = [
    #inputs.impermanence.nixosModules.impermanence
    inputs.impermanence.nixosModules.home-manager.impermanence
  ];

  home.persistence."/persist/home/zaaz" = {
    directories = [
      "Downloads"
      "Music"
      "Pictures"
      "Documents"
      "Videos"
      ".librewolf"
      ".ssh"
      ".local/share/zed"
      ".config/nixos"
      ".config/cosmic"
      ".config/vesktop"
      ".config/nvim"
      ".config/spotify"
      #{
      #  directory = ".local/share/Steam";
      #  method = "symlink";
      #}
    ];
    files = [
    ];
    allowOther = true;
  };
}
