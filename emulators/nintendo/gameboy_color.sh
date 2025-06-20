#!/bin/zsh
set -e
source "$UTILS_DIR/hash_utils.sh"

gameboy_color_hash() {
  calc_md5 "$1"
}
