#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

pcfx_hash() {
  local iso="$1"
  local tmp=$(mktemp -d)

  # sector 0 header (32 bytes)
  dd if="$iso" of="$tmp/header0.bin" bs=1 count=32 2>/dev/null
  if ! grep -aq "PC-FX:Hu_CD-ROM" "$tmp/header0.bin"; then
    echo "Invalid PC-FX image" >&2
    rm -rf "$tmp"
    exit 2
  fi

  # sector 1 volume header (128 bytes)
  dd if="$iso" of="$tmp/sector1.bin" bs=1 skip=2048 count=128 2>/dev/null

  # pointers in that header
  idx4=$(xxd -p -l4 -s32 "$tmp/sector1.bin")
  idx4_rev=$(echo "$idx4" | sed -E 's/(..)(..)(..)(..)/\4\3\2\1/')
  sector_index=$((0x$idx4_rev))

  size4=$(xxd -p -l4 -s36 "$tmp/sector1.bin")
  size4_rev=$(echo "$size4" | sed -E 's/(..)(..)(..)(..)/\4\3\2\1/')
  num_sectors=$((0x$size4_rev))

  # build buffer: the full 128-byte header, then boot code
  buf="$tmp/buffer"
  dd if="$tmp/sector1.bin" bs=1 count=128 > "$buf" 2>/dev/null

  dd if="$iso" of="$tmp/boot.bin" bs=1 skip=$((sector_index*2048)) count=$((num_sectors*2048)) 2>/dev/null
  cat "$tmp/boot.bin" >> "$buf"

  calc_md5 "$buf"

  rm -rf "$tmp"
}
