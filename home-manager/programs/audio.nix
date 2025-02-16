{pkgs, ...}: {
  home.packages = with pkgs; [
    ardour
    audacity
    guitarix
    qpwgraph
    tuxguitar
  ];
}
