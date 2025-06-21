#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

pce_hash() {
  local rom="$1"
  # get file size (portable between Linux/macOS)
  if stat --version &>/dev/null; then
    size=$(stat -c%s "$rom")
  else
    size=$(stat -f%z "$rom")
  fi

  # 128 KB = 131072 bytes
  if [ $(( (size - 512) % 131072 )) -eq 0 ]; then
    # skip 512-byte header
    calc_md5_skip_bytes "$rom" 512
  else
    calc_md5 "$rom"
  fi
}
