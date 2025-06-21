#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

nes_hash() {
  local rom="$1"
  # check for "NES\x1A"
  if head -c 4 "$rom" | grep -q $'NES\032'; then
    calc_md5_skip_bytes "$rom" 16
  else
    calc_md5 "$rom"
  fi
}
