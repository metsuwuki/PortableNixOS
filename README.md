# PortableNixOS 26.05

A persistent, preinstalled NixOS 26.05 workstation for a single USB drive. It boots on x86-64 UEFI computers without installing Linux on internal disks, changing Windows Boot Manager, or writing UEFI NVRAM.

## Included

- Flake-pinned NixOS 26.05 and Home Manager 26.05
- Hyprland, Waybar, Kitty, Fuzzel, PipeWire and NetworkManager
- dark violet/blue visual system, responsive display selection and HiDPI-aware apps
- Intel/AMD firmware, graphics and CPU microcode support
- no internal-disk automounter and no disk-backed swap
- zram swap, persistent `/home` and persistent Nix store on the USB root partition
- GRUB removable-media UEFI path (`EFI/BOOT/BOOTX64.EFI`) with NVRAM writes disabled

The disk image is built by the sibling `PortableNixOS-USB` project. Copying this repository or its files to a USB drive does **not** make the drive bootable.

## Repository layout

```text
flake.nix                 flake entry and exported NixOS module
modules/system/           base, hardware, desktop and portability policy
home/                     Home Manager desktop configuration
assets/                   resolution-independent wallpaper
scripts/                  update and recovery helpers
docs/                     hardware, NVIDIA, update and recovery notes
```

## First boot

The desktop auto-starts as user `portable`. The initial password is `portable`; change it immediately with `passwd`. Passwordless `sudo` is enabled so the owner can recover and update a portable installation. This is convenient, but it is not protection against a person who physically possesses the USB drive. Full-disk encryption is intentionally not enabled in this general-purpose image.

The shared Windows/Linux partition is mounted at `/data` and is labelled `PORTABLE DATA`. System state, installed packages and settings live on the USB ext4 root partition and survive reboot.

## Updating

Work from a writable clone, not `/etc/portable-nixos/source` (that path is an immutable copy of the build source):

```bash
git clone <your-repository-url> ~/PortableNixOS
cd ~/PortableNixOS
./scripts/update.sh
```

See [docs/UPDATE-RECOVERY.md](docs/UPDATE-RECOVERY.md). Hardware and NVIDIA constraints are documented in [docs/HARDWARE.md](docs/HARDWARE.md) and [docs/NVIDIA.md](docs/NVIDIA.md).

## Build status

This source tree is designed to evaluate and build on NixOS or Linux with Nix and KVM. It cannot be built natively on Windows without a suitable Linux/Nix builder. Run `nix flake check` in such an environment before publishing a release.

## License

MIT. The NixOS, Home Manager and packaged applications retain their own licenses.
