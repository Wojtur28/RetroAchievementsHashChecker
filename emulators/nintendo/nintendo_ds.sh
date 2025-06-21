#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

nds_hash() {
  local rom="$1"
  local tmp=$(mktemp -d)

  # read NDS header (0x160 = 352 bytes)
  dd if="$rom" of="$tmp/header.bin" bs=1 count=352 2>/dev/null

  # offsets in header (little-endian 32-bit):
  local icon_off=$(od -An -j104 -N4 -t u4 "$rom" | tr -d ' ')
  local arm9_off=$(od -An -j32  -N4 -t u4 "$rom" | tr -d ' ')
  local arm9_sz=$(od -An -j44  -N4 -t u4 "$rom" | tr -d ' ')
  local arm7_off=$(od -An -j48  -N4 -t u4 "$rom" | tr -d ' ')
  local arm7_sz=$(od -An -j60  -N4 -t u4 "$rom" | tr -d ' ')

  # extract icon/title (0xA00 = 2560 bytes) and both code regions
  dd if="$rom" of="$tmp/icon.bin" bs=1 skip="$icon_off" count=2560   2>/dev/null
  dd if="$rom" of="$tmp/arm9.bin" bs=1 skip="$arm9_off" count="$arm9_sz" 2>/dev/null
  dd if="$rom" of="$tmp/arm7.bin" bs=1 skip="$arm7_off" count="$arm7_sz" 2>/dev/null

  # build buffer and hash
  local buf="$tmp/buffer"
  cat "$tmp/header.bin" "$tmp/icon.bin" "$tmp/arm9.bin" "$tmp/arm7.bin" > "$buf"
  calc_md5 "$buf"

  rm -rf "$tmp"
}
