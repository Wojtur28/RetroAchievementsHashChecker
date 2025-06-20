#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

supervision_hash() {
  calc_md5 "$1"
}
