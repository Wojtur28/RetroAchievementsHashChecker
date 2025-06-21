#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

dreamcast_hash() {
  local iso="$1"
  local tmp=$(mktemp -d)
  # 1) first 512 bytes of sector 0
  dd if="$iso" of="$tmp/header.bin" bs=1 count=512 2>/dev/null
  # 2) check magic
  head -c 16 "$tmp/header.bin" \
    | grep -q "^SEGA SEGAKATANA " \
    || { echo "Invalid Dreamcast ISO"; rm -rf "$tmp"; exit 2; }
  # 3) extract primary executable (1ST_READ.BIN)
  extract_from_iso "$iso" "1ST_READ.BIN" "$tmp"
  [[ -f "$tmp/1ST_READ.BIN" ]] \
    || { echo "1ST_READ.BIN not found"; rm -rf "$tmp"; exit 2; }
  # 4) build buffer and hash
  cat "$tmp/header.bin" "$tmp/1ST_READ.BIN" > "$tmp/buffer"
  calc_md5 "$tmp/buffer"
  rm -rf "$tmp"
}
