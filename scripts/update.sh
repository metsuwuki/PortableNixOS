#!/usr/bin/env bash
set -euo pipefail

repo_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$repo_dir"

if ! command -v nix >/dev/null 2>&1; then
  echo "ERROR: Nix is not installed." >&2
  exit 1
fi
if [[ ! -w "$repo_dir" ]]; then
  echo "ERROR: use a writable Git clone, not the immutable /etc copy." >&2
  exit 1
fi

nix flake update
nix flake check
nixos-rebuild build --flake .#portable

read -r -p "Activate the successfully built generation? Type YES: " answer
[[ "$answer" == "YES" ]] || { echo "Built but not activated."; exit 0; }
sudo nixos-rebuild switch --flake .#portable
