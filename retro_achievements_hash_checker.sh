#!/bin/bash
set -e
source "$(dirname "${BASH_SOURCE[0]}")/utils/config.sh"
source "$UTILS_DIR/hash_utils.sh"

emulator="$1"
romfile="$2"

if [[ -z "$emulator" || -z "$romfile" ]]; then
  echo "Usage: $0 <emulator> <romfile>"
  exit 1
fi

case "$emulator" in

  amstrad|apple2|atari2600|atarijaguar|wonderswan|wonderswancolor|colecovision|channelf|vectrex|odyssey2|intellivision|msx|msx2|pc8001|pc8801|gameboy|gba|gbc|pokemon_mini|wasm4|supervision|megaduck|atari_jaguar|gameboy_advance|gameboy_color|virtual_boy)
    calc_md5 "$romfile"
    ;;

  3do) source "$EMUS_DIR/the3docompany/3do_interactive_multiplayer.sh"; 3do_interactive_multiplayer_hash "$romfile" ;;

  playstation) source "$EMUS_DIR/playstation/playstation.sh";      psx_hash          "$romfile" ;;
  playstation2) source "$EMUS_DIR/playstation/playstation2.sh";    ps2_hash          "$romfile" ;;
  playstation_portable) source "$EMUS_DIR/playstation/psp.sh";     psp_hash          "$romfile" ;;

  *)
    echo "Emulator not supported: $emulator"
    exit 2
    ;;
esac
