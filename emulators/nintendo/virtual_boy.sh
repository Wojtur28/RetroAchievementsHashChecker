#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

virtual_boy_hash() {
  calc_md5 "$1"
}
