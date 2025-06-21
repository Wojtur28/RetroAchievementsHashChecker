#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

n64_hash() {
  local rom="$1"
  # get extension (z64 = big-endian, v64/n64 need conversion)
  local ext="${rom##*.}"
  if [[ "$ext" == "z64" ]]; then
    calc_md5 "$rom"
  elif [[ "$ext" == "v64" || "$ext" == "n64" ]]; then
    # swap adjacent bytes to convert to big-endian, then hash
    dd if="$rom" conv=swab 2>/dev/null | md5sum | awk '{print $1}'
  else
    echo "Unknown N64 format: $ext" >&2
    exit 2
  fi
}
