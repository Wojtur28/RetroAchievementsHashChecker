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

  atari7800) source "$EMUS_DIR/atari/atari7800.sh";                atari7800_hash "$romfile" ;;
  atarilynx) source "$EMUS_DIR/atari/atarilynx.sh";                atarilynx_hash "$romfile" ;;
  atarijaguar_cd) source "$EMUS_DIR/atari/atari_jaguar_cd.sh";     atarijaguarcd_hash "$romfile" ;;

  pc_engine|turbo_grafx|super_grafx) source "$EMUS_DIR/nec/pce_engine_trubo_grafx16_super_grafx.sh"; pce_hash "$romfile" ;;
  pc_engine_cd|turbo_grafx_cd) source "$EMUS_DIR/nec/pce_engine_cd_turbo_grafx_cd.sh"; pcecd_hash "$romfile" ;;
  pc_fx) source "$EMUS_DIR/nec/pc_fx.sh";                          pcfx_hash "$romfile" ;;

  nintendo_entertainment_system|nes) source "$EMUS_DIR/nintendo/nintendo_entertainment_system.sh"; nes_hash "$romfile" ;;
  super_nintendo_entertainment_system|snes) source "$EMUS_DIR/nintendo/super_nintendo_entertainment_system.sh"; snes_hash "$romfile" ;;
  gamecube) source "$EMUS_DIR/nintendo/gamecube.sh";               gamecube_hash "$romfile" ;;
  famicom_disk_system|fds) source "$EMUS_DIR/nintendo/famicom_disk_system.sh"; fds_hash "$romfile" ;;
  nintendo_64|n64) source "$EMUS_DIR/nintendo/nintendo_64.sh";     n64_hash "$romfile" ;;
  nintendo_ds|nds) source "$EMUS_DIR/nintendo/nintendo_ds.sh";     nds_hash "$romfile" ;;

  playstation) source "$EMUS_DIR/playstation/playstation.sh";      psx_hash          "$romfile" ;;
  playstation2) source "$EMUS_DIR/playstation/playstation2.sh";    ps2_hash          "$romfile" ;;
  playstation_portable) source "$EMUS_DIR/playstation/psp.sh";     psp_hash          "$romfile" ;;

  dreamcast|dc) source "$EMUS_DIR/sega/dreamcast.sh";              dreamcast_hash    "$romfile" ;;
  saturn) source "$EMUS_DIR/sega/saturn.sh";                       saturn_hash       "$romfile" ;;
  sega_cd) source "$EMUS_DIR/sega/sega_cd.sh";                     sega_cd_hash      "$romfile" ;;

  neo_geo_cd|neogeo_cd) source "$EMUS_DIR/snk/neo_geo_cd.sh"; neogeo_cd_hash "$romfile" ;;

  3do) source "$EMUS_DIR/the3docompany/3do_interactive_multiplayer.sh"; 3do_interactive_multiplayer_hash "$romfile" ;;

  *)
    echo "Emulator not supported: $emulator"
    exit 2
    ;;
esac
