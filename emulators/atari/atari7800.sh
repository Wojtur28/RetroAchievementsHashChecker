#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

atari7800_hash() {
  local rom="$1"
  # read the first 9 bytes to check for the "\1ATARI7800" header
  local magic
  magic=$(head -c 9 "$rom")
  if [[ "$magic" == $'\x01ATARI7800' ]]; then
    # skip the 128-byte header, hash the rest
    tail -c +129 "$rom" | md5sum | awk '{print $1}'
  else
    calc_md5 "$rom"
  fi
}
