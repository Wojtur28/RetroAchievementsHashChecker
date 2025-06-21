#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

atarijaguarcd_hash() {
  local iso="$1"
  local tmp
  tmp=$(mktemp -d)

  # 1. extract first 2048-byte sector
  dd if="$iso" of="$tmp/sector0.bin" bs=2048 count=1 2>/dev/null

  # 2. parse location (4-byte LE) & size (4-byte LE) at offsets 0x00 and 0x04 in sector0.bin
  local loc size
  loc=$(xxd -p -l4 -s0   "$tmp/sector0.bin" | tac -rs.. | tr -d '\n')
  size=$(xxd -p -l4 -s4   "$tmp/sector0.bin" | tac -rs.. | tr -d '\n')
  # convert hex LE to decimal
  loc=$((0x$(echo "$loc" | sed 's/\(..\)/\1/g')))
  size=$((0x$(echo "$size" | sed 's/\(..\)/\1/g')))

  # 3. load and hash boot code
  dd if="$iso" of="$tmp/boot.bin" bs=2048 skip="$loc" count="$size" 2>/dev/null
  local hash
  hash=$(md5sum "$tmp/boot.bin" | awk '{print $1}')

  # 4. if it's the homebrew‐bootloader, re‐read track 2
  if [[ "$hash" == "254487b59ab21bc005338e85cbf9fd2f" ]]; then
    dd if="$iso" of="$tmp/boot2.bin" bs=2048 skip=1 count="$size" 2>/dev/null
    hash=$(md5sum "$tmp/boot2.bin" | awk '{print $1}')
  fi

  echo "$hash"
  rm -rf "$tmp"
}
