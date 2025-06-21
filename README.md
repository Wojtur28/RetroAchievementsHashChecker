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
./RetroAchievementsHashChecker.sh <emulator> <path/to/rom_or_iso>
```

```bash
./RetroAchievementsHashChecker.sh ps1 "/isos/Final Fantasy VII (Europe).iso"
```

```bash
./RetroAchievementsHashChecker.sh gamecube "/isos/Metroid Prime (USA).iso"
```

## Supported Emulators

### Plain MD5‐only systems
- `amstrad` (Amstrad CPC)  
- `apple2` (Apple II)  
- `atari2600` (Atari 2600)  
- `atarijaguar` (Atari Jaguar)  
- `atar i_jaguar` (alternate key for Atari Jaguar)  
- `wonderswan` (Bandai WonderSwan)  
- `wonderswancolor` (Bandai WonderSwan Color)  
- `colecovision` (ColecoVision)  
- `channelf` (Fairchild Channel F)  
- `vectrex` (GCE Vectrex)  
- `odyssey2` (Magnavox Odyssey²)  
- `intellivision` (Mattel Intellivision)  
- `msx` (Microsoft MSX)  
- `msx2` (Microsoft MSX2)  
- `pc8001` (NEC PC-8001)  
- `pc8801` (NEC PC-8801)  
- `gameboy` (Nintendo Game Boy)  
- `gba` (Game Boy Advance)  
- `gameboy_advance` (alternate key for GBA)  
- `gbc` (Game Boy Color)  
- `gameboy_color` (alternate key for GBC)  
- `pokemon_mini` (Pokémon Mini)  
- `wasm4` (WASM-4)  
- `supervision` (Watara Supervision)  
- `megaduck` (Wellback Mega Duck)  
- `virtual_boy` (Nintendo Virtual Boy)  

### Systems with custom or header-aware hashes
- **Atari 7800**: `atari7800`  
- **Atari Lynx**: `atarilynx`  
- **Atari Jaguar CD**: `atarijaguar_cd`  

- **PC Engine / TurboGrafx-16 / SuperGrafx**:  
  `pc_engine` / `turbo_grafx` / `super_grafx`  
- **PC Engine CD / TurboGrafx-CD**:  
  `pc_engine_cd` / `turbo_grafx_cd`  
- **PC-FX**: `pc_fx`  

- **Famicom Disk System**: `fds` / `famicom_disk_system`  

- **NES / Famicom**: `nes` / `nintendo_entertainment_system`  
- **SNES / Super Famicom**: `snes` / `super_nintendo_entertainment_system`  

- **GameCube**: `gamecube`  
- **Nintendo 64**: `n64` / `nintendo_64`  
- **Nintendo DS**: `nds` / `nintendo_ds`  

- **PlayStation 1**: `playstation`  
- **PlayStation 2**: `playstation2`  
- **PlayStation Portable (PSP)**: `playstation_portable`  

- **Dreamcast**: `dreamcast` / `dc`  
- **Saturn**: `saturn`  
- **Sega CD**: `sega_cd`  

- **Neo Geo CD**: `neo_geo_cd` / `neogeo_cd`  

- **3DO Interactive Multiplayer**: `3do`  
