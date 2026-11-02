# Update and recovery

## Normal update

From a writable Git clone on the USB root filesystem:

```bash
cd ~/PortableNixOS
./scripts/update.sh
```

The script updates locked inputs, evaluates the flake, builds the new generation and asks before activating it. It does not touch partition tables or UEFI variables. Reboot only after the command succeeds.

## Roll back

At the GRUB menu choose an older NixOS generation. From a working shell you can also run:

```bash
sudo nixos-rebuild switch --rollback
```

`scripts/restore.sh` lists generations and offers the same rollback operation after explicit confirmation.

## Rebuild from a known commit

```bash
git log --oneline
git switch --detach <known-good-commit>
sudo nixos-rebuild test --flake .#portable
sudo nixos-rebuild switch --flake .#portable
```

`test` activates a generation without making it the boot default; `switch` makes it persistent. Commit `flake.lock` after a successful update so the exact dependency revisions can be recovered.

## Data recovery

The shared exFAT partition is independent of the Linux root partition. Windows can read `PORTABLE DATA` after the portable OS is cleanly shut down. If the Linux system does not boot, use a trusted Linux recovery environment to mount the ext4 root read-only and copy `/home/portable`; this is a recovery operation, not part of normal boot.
