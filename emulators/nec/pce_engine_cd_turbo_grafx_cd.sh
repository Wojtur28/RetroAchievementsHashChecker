#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

pcecd_hash() {
  local iso="$1"
  local tmp=$(mktemp -d)

  # read 128 bytes from sector 1
  dd if="$iso" of="$tmp/sector1.bin" bs=1 skip=2048 count=128 2>/dev/null

  # check signature at offset 32
  sig=$(dd if="$tmp/sector1.bin" bs=1 skip=32 count=22 2>/dev/null)
  if [[ "$sig" != "PC Engine CD-ROM SYSTEM" ]]; then
    echo "Invalid PCE-CD image" >&2
    rm -rf "$tmp"
    exit 2
  fi

  # disc title = last 22 bytes of those 128
  disc_title=$(dd if="$tmp/sector1.bin" bs=1 skip=106 count=22 2>/dev/null)

  # sector index (little-endian 3 bytes at offset 0)
  idx_hex=$(xxd -p -l3 -s0 "$tmp/sector1.bin")
  idx_hex_rev=$(echo "$idx_hex" | sed -E 's/(..)(..)(..)/\3\2\1/')
  sector_index=$((0x$idx_hex_rev))

  # number of sectors (1 byte at offset 3)
  num_sectors=$(dd if="$tmp/sector1.bin" bs=1 skip=3 count=1 2>/dev/null | od -An -tu1)

  # extract boot code
  dd if="$iso" of="$tmp/boot.bin" bs=1 skip=$((sector_index*2048)) count=$((num_sectors*2048)) 2>/dev/null

  # build buffer: disc title + boot code, then hash
  buf="$tmp/buffer"
  echo -n "$disc_title" > "$buf"
  cat "$tmp/boot.bin" >> "$buf"
  calc_md5 "$buf"

  rm -rf "$tmp"
}
