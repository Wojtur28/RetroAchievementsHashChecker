#!/bin/bash
set -e
source "$UTILS_DIR/hash_utils.sh"

neogeocd_hash() {
  local iso="$1"
  local tmp=$(mktemp -d)
  local buf="$tmp/buffer"

  # 1) extract IPL.TXT
  extract_from_iso "$iso" "IPL.TXT" "$tmp"
  local ipl="$tmp/IPL.TXT"
  if [[ ! -f "$ipl" ]]; then
    echo "ERROR: IPL.TXT not found in ISO" >&2
    rm -rf "$tmp"
    exit 2
  fi

  # 2) build buffer by reading each line of IPL.TXT
  > "$buf"
  while IFS= read -r line; do
    # skip empty/comment lines
    [[ -z "$line" || "${line:0:1}" == "#" ]] && continue
    # extract the PRG file named on this line
    extract_from_iso "$iso" "$line" "$tmp"
    if [[ ! -f "$tmp/$line" ]]; then
      echo "WARNING: PRG file '$line' not found, skipping" >&2
      continue
    fi
    cat "$tmp/$line" >> "$buf"
  done < "$ipl"

  # 3) hash the combined buffer
  calc_md5 "$buf"

  # cleanup
  rm -rf "$tmp"
}
