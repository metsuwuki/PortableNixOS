{ config, pkgs, ... }:
{
  programs.waybar = {
    enable = true;
    systemd.enable = true;
    settings.mainBar = {
      layer = "top";
      position = "top";
      height = 34;
      margin-top = 8;
      margin-left = 12;
      margin-right = 12;
      spacing = 7;
      modules-left = [ "hyprland/workspaces" "hyprland/window" ];
      modules-center = [ "clock" ];
      modules-right = [ "tray" "network" "bluetooth" "pulseaudio" "battery" ];
      "hyprland/workspaces" = { format = "{icon}"; on-click = "activate"; format-icons = { active = "●"; default = "○"; }; };
      "hyprland/window" = { format = "{title:.45}"; separate-outputs = true; };
      clock = { format = "{:%a, %d %b  %H:%M}"; tooltip-format = "<big>{:%B %Y}</big>\n<tt><small>{calendar}</small></tt>"; };
      network = { format-wifi = "󰤨  {essid}"; format-ethernet = "󰈀  Wired"; format-disconnected = "󰤭"; tooltip-format = "{ifname}: {ipaddr}/{cidr}"; };
      bluetooth = { format = "󰂯"; format-connected = "󰂱 {num_connections}"; };
      pulseaudio = { format = "{icon} {volume}%"; format-muted = "󰝟"; format-icons = [ "󰕿" "󰖀" "󰕾" ]; on-click = "pavucontrol"; };
      battery = { states = { warning = 25; critical = 12; }; format = "{icon} {capacity}%"; format-charging = "󰂄 {capacity}%"; format-icons = [ "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ]; };
      tray = { spacing = 10; };
    };
    style = ''
      * { font-family: "JetBrainsMono Nerd Font", "Inter"; font-size: 12px; min-height: 0; }
      window#waybar { background: rgba(13, 13, 27, 0.86); color: #eef2ff; border: 1px solid rgba(139,92,246,.42); border-radius: 13px; }
      #workspaces { margin: 5px; }
      #workspaces button { padding: 0 8px; color: #7777a6; border-radius: 8px; }
      #workspaces button.active { color: #c4b5fd; background: rgba(99,102,241,.22); }
      #window, #clock, #network, #bluetooth, #pulseaudio, #battery, #tray { padding: 0 10px; margin: 5px 1px; border-radius: 8px; background: rgba(38,38,68,.56); }
      #clock { color: #c4b5fd; font-weight: 700; }
      #battery.warning { color: #fbbf24; } #battery.critical { color: #fb7185; }
    '';
  };
}
