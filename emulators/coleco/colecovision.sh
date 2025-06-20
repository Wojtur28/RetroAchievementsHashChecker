#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

colecovision_hash() {
  calc_md5 "$1"
}
