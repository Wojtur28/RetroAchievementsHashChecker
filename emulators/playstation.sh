#!/bin/bash
set -e
source "$(dirname "${BASH_SOURCE[0]}")/../utils/hash_utils.sh"

psx_hash() {
  local iso="$1"
  local tmp=$(mktemp -d)

  extract_from_iso "$iso" SYSTEM.CNF "$tmp"
  local cnf="$tmp/SYSTEM.CNF"
  if [[ ! -f "$cnf" ]]; then
    echo "SYSTEM.CNF missing" >&2; rm -rf "$tmp"; exit 2
  fi

  local boot=$(parse_cnf_boot_path "$cnf" "BOOT")
  extract_from_iso "$iso" "$boot" "$tmp"
  local exe="$tmp/$boot"
  if [[ ! -f "$exe" ]]; then
    echo "Executable $boot not found" >&2; rm -rf "$tmp"; exit 2
  fi

  local buf="$tmp/buffer"
  echo -n "$boot" > "$buf"
  cat "$exe"  >> "$buf"
  calc_md5 "$buf"
  rm -rf "$tmp"
}
