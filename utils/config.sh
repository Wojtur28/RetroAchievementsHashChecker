#!/bin/bash
set -e

# project root is one level up from utils/
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# exports the root directory and utility directories
export ROOT_DIR
export UTILS_DIR="$ROOT_DIR/utils"
export EMUS_DIR="$ROOT_DIR/emulators"
