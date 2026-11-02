{ config, lib, pkgs, ... }:
{
  networking.hostName = "portable-nixos";
  networking.networkmanager.enable = true;
  networking.wireless.enable = false;

  time.timeZone = "Europe/Berlin";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_TIME = "de_DE.UTF-8";
    LC_MEASUREMENT = "de_DE.UTF-8";
  };
  console.keyMap = "us";

  nix = {
    settings = {
      experimental-features = [ "nix-command" "flakes" ];
      auto-optimise-store = true;
      warn-dirty = false;
    };
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
  };
  nixpkgs.config.allowUnfree = true;

  users.mutableUsers = true;
  users.users.portable = {
    isNormalUser = true;
    description = "Portable NixOS";
    extraGroups = [ "wheel" "networkmanager" "video" "audio" "input" ];
    initialPassword = "portable";
    shell = pkgs.zsh;
  };
  security.sudo.wheelNeedsPassword = false;

  programs.zsh.enable = true;
  programs.git.enable = true;
  programs.nix-ld.enable = true;

  environment.systemPackages = with pkgs; [
    git
    curl
    wget
    vim
    nano
    htop
    btop
    pciutils
    usbutils
    exfatprogs
    dosfstools
  ];

  services.fstrim.enable = true;
  services.fwupd.enable = true;

  system.stateVersion = "26.05";
}
