{ config, lib, pkgs, ... }:
{
  imports = [
    ./hyprland.nix
    ./waybar.nix
    ./kitty.nix
    ./fuzzel.nix
    ./theme.nix
  ];

  home = {
    username = "portable";
    homeDirectory = "/home/portable";
    stateVersion = "26.05";
    packages = with pkgs; [
      firefox
      libreoffice-fresh
      mpv
      imv
      file
      ripgrep
      fd
      unzip
    ];
  };

  programs.home-manager.enable = true;
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = {
      ll = "ls -alh --color=auto";
      rebuild = "sudo nixos-rebuild switch --flake /etc/portable-nixos/source#portable";
    };
  };
  programs.starship = {
    enable = true;
    enableZshIntegration = true;
    settings = {
      add_newline = false;
      character = { success_symbol = "[❯](bold #8b5cf6)"; error_symbol = "[❯](bold #ef4444)"; };
    };
  };
}
