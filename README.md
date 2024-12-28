## downloading disk-config.nix
```bash
curl https://raw.githubusercontent.com/PetrusGeorge/nixos-config/main/hosts/desktop/disk-config.nix -O /tmp/disk-config.nix
```

## disko formatting command
replace `'"/dev/vda"'` with your drive
```bash
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko/latest -- --mode destroy,format,mount /tmp/disk-config.nix --arg device '"/dev/vda"'
```

## initialize flake
```bash
nix flake init --template github:PetrusGeorge/nixos-config
```

## installing nixos
```bash
TMPDIR=/mnt/Flake/tmp nixos-install --root /mnt --flake /mnt/etc/nixos#default
```
