#!/bin/zsh
set -e
source "$UTILS_DIR/hash_utils.sh"

atari_jaguar_hash() {
  calc_md5 "$1"
}
