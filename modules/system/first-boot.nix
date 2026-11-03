{ pkgs, ... }:
{
  # This runs only on a new, unconfigured image. It uses tty2 rather than
  # a default password or an auto-logged-in administrative session.
  systemd.services."getty@tty2".enable = false;
  systemd.services.portable-first-boot = {
    description = "Set the portable user's password on first boot (tty2)";
    wantedBy = [ "multi-user.target" ];
    after = [ "systemd-user-sessions.service" ];
    unitConfig.ConditionPathExists = "!/var/lib/portable-nixos/password-initialized";
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      TimeoutStartSec = 0;
      StandardInput = "tty-force";
      StandardOutput = "tty";
      StandardError = "tty";
      TTYPath = "/dev/tty2";
      TTYReset = true;
      TTYVHangup = true;
    };
    script = ''
      export PATH=${pkgs.shadow}/bin:${pkgs.coreutils}/bin:$PATH
      printf '\nPortableNixOS first boot\n'
      printf 'Set a password for user portable. This USB has no default password.\n'
      printf 'After success press Ctrl+Alt+F1 to return to the login screen.\n\n'
      until passwd portable; do
        printf '\nPassword setup failed; please try again.\n'
        sleep 2
      done
      install -d -m 0700 /var/lib/portable-nixos
      touch /var/lib/portable-nixos/password-initialized
      chmod 0600 /var/lib/portable-nixos/password-initialized
      printf '\nPassword configured. Return to tty1 to log in.\n'
    '';
  };
}
