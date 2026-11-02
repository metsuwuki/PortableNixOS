{ ... }:
{
  programs.fuzzel = {
    enable = true;
    settings = {
      main = { font = "Inter:size=12"; dpi-aware = "auto"; width = 42; lines = 10; horizontal-pad = 24; vertical-pad = 16; inner-pad = 10; border-width = 2; corner-radius = 14; icon-theme = "Papirus-Dark"; };
      colors = { background = "0d0d1bee"; text = "eef2ffff"; match = "60a5faff"; selection = "312e81ff"; selection-text = "ffffffff"; selection-match = "c4b5fdff"; border = "8b5cf6ff"; };
    };
  };
}
