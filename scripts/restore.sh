#!/usr/bin/env bash
set -euo pipefail

sudo nix-env --list-generations --profile /nix/var/nix/profiles/system
echo
read -r -p "Roll back to the previous system generation? Type ROLLBACK: " answer
[[ "$answer" == "ROLLBACK" ]] || { echo "No changes made."; exit 0; }
sudo nixos-rebuild switch --rollback
