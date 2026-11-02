# Hardware portability

## Expected to work

- x86-64 computers with 64-bit UEFI firmware
- Intel and AMD integrated graphics
- common NVMe/SATA/USB storage controllers
- common USB, Ethernet, Wi-Fi and Bluetooth adapters supported by the Linux kernel and redistributable firmware
- laptops and desktops with one or more displays; Hyprland selects each display's preferred mode and automatic placement

The image includes both Intel and AMD microcode. It uses the current kernel available in NixOS 26.05 and includes a broad initrd module set so the USB root can be found after moving the drive to another computer.

## Deliberate limits

- UEFI only; legacy BIOS and 32-bit UEFI are not targets.
- Secure Boot is not configured. Disable it temporarily only if the machine refuses the unsigned removable loader; do not change firmware settings unless the machine owner authorizes it.
- Apple T2, unusual RAID/VMD modes, vendor-only Wi-Fi and other hardware requiring out-of-tree drivers may not work.
- Firmware can still write its own boot telemetry or reorder devices. The OS configuration itself sets `canTouchEfiVariables = false` and installs the removable path.
- Internal disks are visible to the kernel but are neither declared nor automatically mounted. A user with root privileges can still mount them manually.
- Performance and flash lifetime depend strongly on the USB device. A quality USB 3.x SSD is preferable to a low-end thumb drive.

## Display scaling

The default monitor rule uses each display's preferred mode and scale. If automatic scaling is not comfortable, add a host-specific rule to `home/hyprland.nix`, for example:

```nix
monitor = [ "eDP-1,preferred,auto,1.5" ",preferred,auto,1" ];
```

Use `hyprctl monitors` to discover connector names.
