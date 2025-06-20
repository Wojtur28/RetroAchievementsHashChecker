#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

atari2600_hash() {
  calc_md5 "$1"
}
