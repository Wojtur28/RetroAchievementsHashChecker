#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

fds_hash() {
  local rom="$1"
  # check for "FDS\x1A"
  if head -c 4 "$rom" | grep -q $'FDS\032'; then
    calc_md5_skip_bytes "$rom" 16
  else
    calc_md5 "$rom"
  fi
}
