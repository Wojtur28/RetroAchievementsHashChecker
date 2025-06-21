#!/bin/bash
set -e

# calculate MD5 of a file
calc_md5() {
  md5sum "$1" | awk '{print $1}'
}

# calculate MD5 skipping the first N bytes
calc_md5_skip_bytes() {
  local file="$1"; local skip="$2"
  tail -c +$((skip + 1)) "$file" | md5sum | awk '{print $1}'
}

# extract a single file from an ISO/CUE container into a directory
extract_from_iso() {
  local iso="$1"
  local path_in_iso="$2"
  local outdir="$3"
  7z e "$iso" "$path_in_iso" -o"$outdir" -y > /dev/null
}

# parse SYSTEM.CNF for a key (e.g. BOOT= or BOOT2=) and return its value
parse_cnf_boot_path() {
  local cnf="$1"
  local key="$2"
  grep "^${key}" "$cnf" | head -1 \
    | sed -e "s/^${key}=//" -e 's/[[:space:]]//g' -e "s/[\;']$//g"
}
