## Downloading disk-config.nix
```bash
curl https://raw.githubusercontent.com/PetrusGeorge/nixos-config/refs/heads/main/hosts/desktop/disk-config.nix -O /tmp/disk-config.nix
```

## Disko formatting command
replace `'"/dev/vda"'` with your drive
```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/disk-config.nix --arg device '"/dev/vda"'
```

## Clone the repo
```bash
git clone https://github.com/PetrusGeorge/nixos-config.git
cd nixos-config
```

## Installing nixos
```bash
TMPDIR=/mnt/Flake/tmp sudo nixos-install --root /mnt --flake .#desktop
```
