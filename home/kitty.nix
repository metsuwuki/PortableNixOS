{ ... }:
{
  programs.kitty = {
    enable = true;
    font = { name = "JetBrainsMono Nerd Font"; size = 11.5; };
    settings = {
      background = "#0d0d1b";
      foreground = "#eef2ff";
      selection_background = "#4c1d95";
      cursor = "#a78bfa";
      color4 = "#60a5fa";
      color5 = "#a78bfa";
      color12 = "#93c5fd";
      color13 = "#c4b5fd";
      background_opacity = "0.92";
      dynamic_background_opacity = true;
      window_padding_width = 12;
      confirm_os_window_close = 0;
      enable_audio_bell = false;
    };
  };
}
