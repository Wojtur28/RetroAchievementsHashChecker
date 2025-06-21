#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

segacd_hash() {
  local iso="$1"
  local tmp=$(mktemp -d)
  dd if="$iso" of="$tmp/header.bin" bs=1 count=512 2>/dev/null
  head -c 16 "$tmp/header.bin" \
    | grep -Eq "^(SEGADISCSYSTEM |SEGA SEGASATURN )" \
    || { echo "Invalid Sega CD disc"; rm -rf "$tmp"; exit 2; }
  calc_md5 "$tmp/header.bin"
  rm -rf "$tmp"
}
