#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

amstrad_hash() {
  local disk="$1"

  calc_md5 "$disk"
}
