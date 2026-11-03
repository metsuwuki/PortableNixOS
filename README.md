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

The `portable` account starts **locked**, with no universal initial password and no automatic desktop login. At first boot, press **Ctrl+Alt+F2** to open the dedicated first-boot console. Choose a new password using the local `passwd` prompt, then return to the login screen with **Ctrl+Alt+F1** (on some keyboards the Fn key is needed). Log in as `portable` with that password. `sudo` requires your password. The first-boot initialization console stops appearing once password setup succeeds.\n\nThis image is **not encrypted**. Someone with physical possession of the USB can still read the ext4 and exFAT partitions. Avoid storing secrets unless encryption is configured.

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

`.github/workflows/flake-check.yml` evaluates the NixOS and Home Manager configuration on every push and pull request without building the full system closure. The USB repository contains the separate, manually triggered image workflow because a standard GitHub-hosted runner does not provide enough documented disk space for the image build.

## License

MIT. The NixOS, Home Manager and packaged applications retain their own licenses.
