#!/bin/bash
set -e

# p7zip is required for ISO extraction!!!

# Resolve script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UTILS_DIR="$SCRIPT_DIR/utils"
EMUS_DIR="$SCRIPT_DIR/emulators"

# Load shared helpers
source "$UTILS_DIR/hash_utils.sh"

emulator="$1"
romfile="$2"

if [[ -z "$emulator" || -z "$romfile" ]]; then
  echo "Usage: $0 <emulator> <romfile>"
  exit 1
fi

case "$emulator" in
  gba)
    calc_md5 "$romfile"
    ;;
  ps1|playstation)
    source "$EMUS_DIR/playstation.sh"
    psx_hash "$romfile"
    ;;
  ps2|playstation2)
    source "$EMUS_DIR/playstation2.sh"
    ps2_hash "$romfile"
    ;;
  psp)
    source "$EMUS_DIR/psp.sh"
    psp_hash "$romfile"
    ;;
  *)
    echo "Emulator not supported: $emulator"
    exit 2
    ;;
esac
