{device ? throw "Set this to your disk device, e.g. /dev/sda", ...}: {
  disko.devices = {
    disk.main = {
      type = "disk";
      inherit device;
      content = {
        type = "gpt";
        partitions = {
          boot = {
            name = "boot";
            size = "1M";
            type = "EF02";
          };
          esp = {
            name = "ESP";
            size = "512M";
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          };
          root =
            let
              mountOptions = [
                "compress=zstd"
                "noatime"
                "ssd"
                "discard=async"
                "space_cache=v2"
              ];
            in {
            size = "100%";
            content = {
              type = "btrfs";
              extraArgs = [ "-f" ]; # Override existing partition
              subvolumes = {
                "@" = {
                  mountpoint = "/";
                  inherit mountOptions;
                };
                "@nix" = {
                  mountpoint = "/nix";
                  inherit mountOptions;
                };
                "@log" = {
                  mountpoint = "/var/log";
                  inherit mountOptions;
                };
                "@cache" = {
                  mountpoint = "/var/cache";
                  inherit mountOptions;
                };
                "@tmp" = {
                  mountpoint = "/tmp";
                  inherit mountOptions;
                };
                "@home" = {
                  mountpoint = "/home";
                  inherit mountOptions;
                };
              };
              mountpoint = "/";
            };
          };
        };
      };
    };
  };
}
