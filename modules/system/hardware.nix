{ config, lib, pkgs, ... }:
{
  boot.initrd.availableKernelModules = [
    "xhci_pci" "ehci_pci" "ahci" "nvme" "usb_storage" "uas"
    "sd_mod" "sdhci_pci" "rtsx_pci_sdmmc" "thunderbolt"
  ];
  boot.initrd.kernelModules = [ "amdgpu" "i915" ];
  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelParams = [
    "console=tty0"
    "usbcore.autosuspend=-1"
  ];

  hardware.enableRedistributableFirmware = true;
  hardware.enableAllFirmware = true;
  hardware.cpu.amd.updateMicrocode = true;
  hardware.cpu.intel.updateMicrocode = true;
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  services.blueman.enable = true;
  services.libinput.enable = true;
  services.power-profiles-daemon.enable = true;
}
