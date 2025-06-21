#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

# GameCube: pull in the Apploader + full DOL file and hash them together
gamecube_hash() {
  local iso="$1"
  local tmp=$(mktemp -d)

  # find & extract the Apploader
  local apl=$(7z l "$iso" | awk '{print $6}' | grep -i 'apploader' | head -1)
  if [[ -z "$apl" ]]; then
    echo "ERROR: Apploader not found in ISO" >&2
    rm -rf "$tmp"; exit 2
  fi
  extract_from_iso "$iso" "$apl" "$tmp"

  # find & extract the DOL executable
  local dol=$(7z l "$iso" | awk '{print $6}' | grep -i '\.dol$' | head -1)
  if [[ -z "$dol" ]]; then
    echo "ERROR: .dol file not found in ISO" >&2
    rm -rf "$tmp"; exit 2
  fi
  extract_from_iso "$iso" "$dol" "$tmp"

  # concatenate and hash
  local buf="$tmp/buffer"
  cat "$tmp/$(basename "$apl")" > "$buf"
  cat "$tmp/$(basename "$dol")" >> "$buf"
  calc_md5 "$buf"

  rm -rf "$tmp"
}
