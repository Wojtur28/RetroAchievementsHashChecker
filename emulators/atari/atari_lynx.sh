#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

atarilynx_hash() {
  local rom="$1"
  # check for “LYNX\0” header
  local magic
  magic=$(head -c 5 "$rom")
  if [[ "$magic" == $'LYNX\0' ]]; then
    # skip the 64-byte header, hash the rest
    tail -c +65 "$rom" | md5sum | awk '{print $1}'
  else
    calc_md5 "$rom"
  fi
}
