{ config, pkgs, ... }:
{
  wayland.windowManager.hyprland = {
    enable = true;
    systemd.enable = true;
    settings = {
      "$mod" = "SUPER";
      monitor = [ ",preferred,auto,1" ];
      exec-once = [
        "mako"
        "nm-applet --indicator"
        "blueman-applet"
      ];
      env = [
        "XCURSOR_SIZE,24"
        "HYPRCURSOR_SIZE,24"
        "GDK_BACKEND,wayland,x11,*"
        "QT_QPA_PLATFORM,wayland;xcb"
      ];
      input = {
        kb_layout = "us,de";
        kb_options = "grp:win_space_toggle";
        follow_mouse = 1;
        sensitivity = 0;
        touchpad = { natural_scroll = true; tap-to-click = true; };
      };
      general = {
        gaps_in = 5;
        gaps_out = 12;
        border_size = 2;
        "col.active_border" = "rgba(8b5cf6ee) rgba(3b82f6ee) 45deg";
        "col.inactive_border" = "rgba(303047aa)";
        layout = "dwindle";
        resize_on_border = true;
      };
      decoration = {
        rounding = 12;
        active_opacity = 1.0;
        inactive_opacity = 0.94;
        shadow = { enabled = true; range = 22; render_power = 3; color = "rgba(080814aa)"; };
        blur = { enabled = true; size = 8; passes = 3; vibrancy = 0.18; };
      };
      animations = {
        enabled = true;
        bezier = [
          "premium,0.16,1,0.3,1"
          "smooth,0.4,0,0.2,1"
        ];
        animation = [
          "windows,1,5,premium,popin 88%"
          "windowsOut,1,4,smooth,popin 92%"
          "border,1,8,premium"
          "fade,1,4,smooth"
          "workspaces,1,5,premium,slide"
        ];
      };
      dwindle = { pseudotile = true; preserve_split = true; };
      misc = { disable_hyprland_logo = true; force_default_wallpaper = 0; vrr = 1; };
      bind = [
        "$mod, Return, exec, kitty"
        "$mod, D, exec, fuzzel"
        "$mod, E, exec, thunar"
        "$mod, Q, killactive"
        "$mod SHIFT, E, exit"
        "$mod, F, fullscreen"
        "$mod, V, togglefloating"
        "$mod, L, exec, hyprlock"
        ", Print, exec, grim -g \"$(slurp)\" - | swappy -f -"
        "$mod, left, movefocus, l"
        "$mod, right, movefocus, r"
        "$mod, up, movefocus, u"
        "$mod, down, movefocus, d"
        "$mod, 1, workspace, 1"
        "$mod, 2, workspace, 2"
        "$mod, 3, workspace, 3"
        "$mod, 4, workspace, 4"
        "$mod SHIFT, 1, movetoworkspace, 1"
        "$mod SHIFT, 2, movetoworkspace, 2"
        "$mod SHIFT, 3, movetoworkspace, 3"
        "$mod SHIFT, 4, movetoworkspace, 4"
      ];
      bindel = [
        ",XF86AudioRaiseVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"
        ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
        ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
        ",XF86MonBrightnessUp, exec, brightnessctl set +5%"
        ",XF86MonBrightnessDown, exec, brightnessctl set 5%-"
      ];
      windowrule = [
        "float,class:^(pavucontrol)$"
        "float,class:^(nm-connection-editor)$"
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      preload = [ "${../assets/wallpaper.svg}" ];
      wallpaper = [ ",${../assets/wallpaper.svg}" ];
      splash = false;
    };
  };
  services.hypridle = {
    enable = true;
    settings = {
      general = { lock_cmd = "pidof hyprlock || hyprlock"; before_sleep_cmd = "loginctl lock-session"; };
      listener = [
        { timeout = 600; on-timeout = "loginctl lock-session"; }
        { timeout = 900; on-timeout = "hyprctl dispatch dpms off"; on-resume = "hyprctl dispatch dpms on"; }
      ];
    };
  };
  programs.hyprlock = {
    enable = true;
    settings = {
      general = { disable_loading_bar = true; hide_cursor = true; };
      background = [ { path = "${../assets/wallpaper.svg}"; blur_passes = 4; blur_size = 8; } ];
      input-field = [ {
        size = "320, 58";
        position = "0, -70";
        monitor = "";
        dots_center = true;
        fade_on_empty = false;
        outline_thickness = 2;
        outer_color = "rgb(139, 92, 246)";
        inner_color = "rgba(15, 15, 30, 0.88)";
        font_color = "rgb(238, 242, 255)";
        placeholder_text = "Password";
      } ];
      label = [ {
        text = "$TIME";
        color = "rgb(238, 242, 255)";
        font_size = 72;
        font_family = "Inter Bold";
        position = "0, 90";
        halign = "center";
        valign = "center";
      } ];
    };
  };
}
