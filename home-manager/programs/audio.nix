{
  pkgs,
  ...
}: {

  home.packages = with pkgs; [
    audacity
    tuxguitar
    lmms
    # ardour
    guitarix
    lingot
  ];
}
