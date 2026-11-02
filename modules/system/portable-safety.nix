{ lib, pkgs, ... }:
{
  # Only partitions explicitly declared by the USB image are mounted.
  # No internal-disk UUID, label, automounter, or swap device is configured.
  services.udisks2.enable = false;
  services.devmon.enable = false;
  services.gvfs.enable = false;
  swapDevices = lib.mkForce [ ];
  zramSwap = {
    enable = true;
    algorithm = "zstd";
    memoryPercent = 50;
    priority = 100;
  };

  boot.loader.efi.canTouchEfiVariables = false;
  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    efiInstallAsRemovable = true;
    configurationLimit = 5;
  };
  boot.loader.timeout = 5;

  # Avoid hibernation: there is deliberately no disk-backed swap.
  systemd.sleep.extraConfig = ''
    AllowHibernation=no
    AllowHybridSleep=no
    AllowSuspendThenHibernate=no
  '';

  # Filesystems discovered on internal disks remain untouched and unmounted.
  environment.etc."udev/rules.d/99-portable-internal-disks.rules".text = ''
    # Inform desktop helpers that fixed disks are not candidates for automount.
    SUBSYSTEM=="block", ENV{ID_DRIVE_FLASH_SD}!="1", ENV{UDISKS_IGNORE}="1"
  '';
}
