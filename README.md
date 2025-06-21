# RetroAchievementsHashChecker

A Bash script to calculate ROM hashes according to the [RetroAchievements](https://docs.retroachievements.org/developer-docs/game-identification.html) identification rules.  
Supports a wide range of systems, including custom‐hash formats (PS1, PS2, PSP, GameCube, Dreamcast, Neo Geo CD, NDS, etc.) and plain MD5‐only systems (GBA, NES, SNES, Atari 2600, etc.).

---


## Prerequisites

- **Bash** (≥ 4.0)  
- **md5sum** (part of GNU coreutils)  
- **p7zip** (provides the `7z` command for ISO/archive extraction)  
  - macOS: `brew install p7zip`  
  - Debian/Ubuntu: `sudo apt-get install p7zip-full`  
- **dd**, **tail**, **grep**, **awk**, **stat**, **od**, **xxd** (standard Unix utilities)

## Usage

```bash
./retro_achievements_hash_checker.sh <emulator> <path/to/rom_or_iso>
```

```bash
./retro_achievements_hash_checker.sh ps1 "/isos/Final Fantasy VII (Europe).iso"
```

```bash
./retro_achievements_hash_checker.sh gamecube "/isos/Metroid Prime (USA).iso"
```

## Supported Emulators & Invocation

- **Amstrad CPC**  
  `./retro_achievements_hash_checker.sh amstrad /path/to/game.dsk`
- **Apple II**  
  `./retro_achievements_hash_checker.sh apple2 /path/to/game.dsk`
- **Atari 2600**  
  `./retro_achievements_hash_checker.sh atari2600 /path/to/game.rom`
- **Atari Jaguar**  
  `./retro_achievements_hash_checker.sh atarijaguar /path/to/game.rom`
- **Atari 7800**  
  `./retro_achievements_hash_checker.sh atari7800 /path/to/game.rom`
- **Atari Jaguar CD**  
  `./retro_achievements_hash_checker.sh atarijaguar_cd /path/to/game.iso`
- **Atari Lynx**  
  `./retro_achievements_hash_checker.sh atarilynx /path/to/game.rom`
- **Bandai WonderSwan**  
  `./retro_achievements_hash_checker.sh wonderswan /path/to/game.rom`
- **Bandai WonderSwan Color**  
  `./retro_achievements_hash_checker.sh wonderswancolor /path/to/game.rom`
- **ColecoVision**  
  `./retro_achievements_hash_checker.sh colecovision /path/to/game.rom`
- **Fairchild Channel F**  
  `./retro_achievements_hash_checker.sh channelf /path/to/game.rom`
- **GCE Vectrex**  
  `./retro_achievements_hash_checker.sh vectrex /path/to/game.rom`
- **Magnavox Odyssey²**  
  `./retro_achievements_hash_checker.sh odyssey2 /path/to/game.rom`
- **Mattel Intellivision**  
  `./retro_achievements_hash_checker.sh intellivision /path/to/game.rom`
- **Microsoft MSX / MSX2**  
  `./retro_achievements_hash_checker.sh msx /path/to/game.dsk`  
  `./retro_achievements_hash_checker.sh msx2 /path/to/game.dsk`
- **NEC PC-8001 / PC-8801**  
  `./retro_achievements_hash_checker.sh pc8001 /path/to/game.dsk`  
  `./retro_achievements_hash_checker.sh pc8801 /path/to/game.dsk`
- **NEC PC Engine / TurboGrafx-16 / SuperGrafx**  
  `./retro_achievements_hash_checker.sh pc_engine /path/to/game.rom`
- **NEC PC Engine CD / TurboGrafx-CD**  
  `./retro_achievements_hash_checker.sh pc_engine_cd /path/to/game.iso`
- **NEC PC-FX**  
  `./retro_achievements_hash_checker.sh pc_fx /path/to/game.iso`
- **NES / Famicom**  
  `./retro_achievements_hash_checker.sh nes /path/to/game.nes`
- **SNES / Super Famicom**  
  `./retro_achievements_hash_checker.sh snes /path/to/game.smc`
- **Famicom Disk System**  
  `./retro_achievements_hash_checker.sh fds /path/to/game.fds`
- **Game Boy**  
  `./retro_achievements_hash_checker.sh gameboy /path/to/game.gb`
- **Game Boy Advance**  
  `./retro_achievements_hash_checker.sh gba /path/to/game.gba`
- **Game Boy Color**  
  `./retro_achievements_hash_checker.sh gbc /path/to/game.gbc`
- **Pokémon Mini**  
  `./retro_achievements_hash_checker.sh pokemon_mini /path/to/game.min`
- **WASM-4**  
  `./retro_achievements_hash_checker.sh wasm4 /path/to/game.wasm`
- **Watara Supervision**  
  `./retro_achievements_hash_checker.sh supervision /path/to/game.rom`
- **Wellback Mega Duck**  
  `./retro_achievements_hash_checker.sh megaduck /path/to/game.rom`
- **Nintendo Virtual Boy**  
  `./retro_achievements_hash_checker.sh virtual_boy /path/to/game.vboy`
- **GameCube**  
  `./retro_achievements_hash_checker.sh gamecube /path/to/game.iso`
- **Nintendo 64**  
  `./retro_achievements_hash_checker.sh n64 /path/to/game.z64`
- **Nintendo DS**  
  `./retro_achievements_hash_checker.sh nds /path/to/game.nds`
- **PlayStation 1**  
  `./retro_achievements_hash_checker.sh playstation /path/to/game.iso`
- **PlayStation 2**  
  `./retro_achievements_hash_checker.sh playstation2 /path/to/game.iso`
- **PlayStation Portable (PSP)**  
  `./retro_achievements_hash_checker.sh playstation_portable /path/to/game.iso`
- **Sega Dreamcast**  
  `./retro_achievements_hash_checker.sh dreamcast /path/to/game.iso`
- **Sega Saturn**  
  `./retro_achievements_hash_checker.sh saturn /path/to/game.iso`
- **Sega CD**  
  `./retro_achievements_hash_checker.sh sega_cd /path/to/game.iso`
- **SNK Neo Geo CD**  
  `./retro_achievements_hash_checker.sh neogeo_cd /path/to/game.iso`
- **3DO Interactive Multiplayer**  
  `./retro_achievements_hash_checker.sh 3do /path/to/game.iso`
 
