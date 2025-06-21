#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

snes_hash() {
  local rom="$1"
  # determine file size portably
  if size=$(stat -c%s "$rom" 2>/dev/null); then :; else size=$(stat -f%z "$rom"); fi

  # if (size - 512) is divisible by 8 192, skip header
  if [ $(( (size - 512) % 8192 )) -eq 0 ]; then
    calc_md5_skip_bytes "$rom" 512
  else
    calc_md5 "$rom"
  fi
}
