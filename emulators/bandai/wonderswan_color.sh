#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

wonderswan_color_hash() {
  calc_md5 "$1"
}
