#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

3do_interactive_multiplayer_hash() {
  local iso="$1"
  local tmp="$(mktemp -d)"

  # 1) grab the first 132 bytes of sector 0 (i.e. the very start of the file)
  dd if="$iso" of="$tmp/header.bin" bs=1 count=132 2>/dev/null

  # 2) extract the LaunchMe file from the ISO
  extract_from_iso "$iso" "LaunchMe" "$tmp"
  local lm="$tmp/LaunchMe"
  if [[ ! -f "$lm" ]]; then
    echo "ERROR: LaunchMe not found in ISO" >&2
    rm -rf "$tmp"
    exit 2
  fi

  # 3) concatenate header + LaunchMe into a single buffer, then MD5 it
  local buf="$tmp/buffer"
  cat "$tmp/header.bin" > "$buf"
  cat "$lm"             >> "$buf"

  calc_md5 "$buf"

  rm -rf "$tmp"
}
