#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

psp_hash() {
  local iso="$1"
  local tmp=$(mktemp -d)

  extract_from_iso "$iso" "PSP_GAME/PARAM.SFO"    "$tmp"
  extract_from_iso "$iso" "PSP_GAME/SYSDIR/EBOOT.BIN" "$tmp"
  local sfo="$tmp/PARAM.SFO"
  local eboot="$tmp/EBOOT.BIN"
  if [[ ! -f "$sfo" || ! -f "$eboot" ]]; then
    echo "PSP_GAME/PARAM.SFO or EBOOT.BIN missing" >&2; rm -rf "$tmp"; exit 2
  fi

  local buf="$tmp/buffer"
  cat "$sfo"   > "$buf"
  cat "$eboot" >> "$buf"
  calc_md5 "$buf"
  rm -rf "$tmp"
}
