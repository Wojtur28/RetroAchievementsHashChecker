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

  atari2600) source "$EMUS_DIR/atari/atari2600.sh";                atari_hash        "$romfile" ;;
  atari_jaguar) source "$EMUS_DIR/atari/atari_jaguar.sh";          atari_jaguar_hash "$romfile" ;;

  gameboy) source "$EMUS_DIR/nintendo/gameboy.sh";                 gameboy_hash      "$romfile" ;;
  gameboy_advance) source "$EMUS_DIR/nintendo/gameboy_advance.sh"; gameboy_advance_hash "$romfile" ;;
  gameboy_color) source "$EMUS_DIR/nintendo/gameboy_color.sh";     gameboy_color_hash "$romfile" ;;
  pokemon_mini) source "$EMUS_DIR/nintendo/pokemon_mini.sh";       pokemon_mini_hash "$romfile" ;;
  virtual_boy) source "$EMUS_DIR/nintendo/virtual_boy.sh";         virtual_boy_hash  "$romfile" ;;

  playstation) source "$EMUS_DIR/playstation/playstation.sh";      psx_hash          "$romfile" ;;
  playstation2) source "$EMUS_DIR/playstation/playstation2.sh";    ps2_hash          "$romfile" ;;
  playstation_portable) source "$EMUS_DIR/playstation/psp.sh";     psp_hash          "$romfile" ;;


  wasm4) source "$EMUS_DIR/wasm4/wasm4.sh";                        wasm4_hash        "$romfile" ;;

  supervision) source "$EMUS_DIR/watara/supervision.sh";           supervision_hash  "$romfile" ;;

  megaduck) source "$EMUS_DIR/wellback/megaduck.sh";               megaduck_hash     "$romfile" ;;

  wonderswan) source "$EMUS_DIR/bandai/wonderswan.sh";             wonderswan_hash   "$romfile" ;;
  wonderswancolor) source "$EMUS_DIR/bandai/wonderswancolor.sh";   wonderswancolor_hash "$romfile" ;;

  colecovision) source "$EMUS_DIR/coleco/colecovision.sh";         colecovision_hash "$romfile" ;;

  channelf) source "$EMUS_DIR/fairchild/channelf.sh";              channelf_hash     "$romfile" ;;

  vectrex) source "$EMUS_DIR/gce/vectrex.sh";                      vectrex_hash      "$romfile" ;;

  odyssey2) source "$EMUS_DIR/magnavox/odyssey2.sh";               odyssey2_hash     "$romfile" ;;

  intellivision) source "$EMUS_DIR/mattel/intellivision.sh";       intellivision_hash "$romfile" ;;

  *)
    echo "Emulator not supported: $emulator"
    exit 2
    ;;
esac
