#!/bin/bash

# ============================================================
# TrinityCore — ALL TAGGED BRANCHES DOWNLOADER
#
# Downloads src/server/scripts from every tagged TDB release
# in the TrinityCore repo, organised by expansion group.
#
# Run this on YOUR machine — requires git to be installed.
# Usage:
#   chmod +x download_trinitycore_scripts.sh
#   ./download_trinitycore_scripts.sh
#
# Creates:
#   ./TrinityCore_Scripts/          — all downloaded script files
#   ./TrinityCore_Scripts_log.txt   — timestamped download log
# ============================================================

REPO="https://github.com/TrinityCore/TrinityCore.git"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUTPUT_DIR="$SCRIPT_DIR/TrinityCore_Scripts"
LOG_FILE="$SCRIPT_DIR/TrinityCore_Scripts_log.txt"
SPARSE_PATH="src/server/scripts"

mkdir -p "$OUTPUT_DIR"

# ---- Logging helper ----
log() {
    local MSG="[$(date '+%Y-%m-%d %H:%M:%S')] $1"
    echo "$MSG" | tee -a "$LOG_FILE"
}

# ---- Download function ----
download_branch() {
    local BRANCH="$1"
    local GROUP="$2"
    local SAFE_BRANCH="${BRANCH//\//_}"
    local TARGET="$OUTPUT_DIR/$GROUP/$SAFE_BRANCH"

    log "========================================"
    log "Downloading branch: $BRANCH -> $TARGET"
    log "========================================"

    if [ -d "$TARGET" ]; then
        log "  [SKIP] Already exists: $TARGET"
        log ""
        return 0
    fi

    mkdir -p "$TARGET"

    git clone \
        --depth 1 \
        --branch "$BRANCH" \
        --filter=blob:none \
        --sparse \
        "$REPO" \
        "$TARGET" 2>&1 | tee -a "$LOG_FILE"

    cd "$TARGET" || { log "  [ERROR] Failed to cd into $TARGET"; log ""; return 1; }

    git sparse-checkout set "$SPARSE_PATH" 2>&1 | tee -a "$LOG_FILE"

    local FILE_COUNT=0
    if [ -d "$SPARSE_PATH" ]; then
        FILE_COUNT=$(find "$SPARSE_PATH" -type f 2>/dev/null | wc -l)
        log "  [DONE] $GROUP/$SAFE_BRANCH — $FILE_COUNT files downloaded"
    else
        log "  [DONE] $GROUP/$SAFE_BRANCH (sparse path check skipped)"
    fi

    cd - > /dev/null
    log ""
}

# ============================================================
# Fresh log
# ============================================================
echo "" > "$LOG_FILE"
log "============================================================"
log "  download_trinitycore_scripts.sh — Started"
log "  Output: $OUTPUT_DIR"
log "  Log:    $LOG_FILE"
log "============================================================"
log ""

# ==============================================================
# GROUP 1 — The War Within / Dragonflight (TDB 1100+)
# ==============================================================
download_branch "TDB1200.26021"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1127.26011"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1125.25101"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1120.25081"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1117.25071"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1115.25051"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1110.25031"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1107.24121"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1105.24111"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1102.24092"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1102.24091"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1027.24051"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1025.24021"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1020.23111"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1017.23101"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1015.23071"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1007.23041"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1005.23021"  "01_TheWarWithin_Dragonflight"
download_branch "TDB1002.22121"  "01_TheWarWithin_Dragonflight"
download_branch "11.2.5.64502"   "01_TheWarWithin_Dragonflight"
download_branch "11.0.0.56008"   "01_TheWarWithin_Dragonflight"
download_branch "10.2.7.55664"   "01_TheWarWithin_Dragonflight"
download_branch "10.2.0.52808"   "01_TheWarWithin_Dragonflight"
download_branch "10.1.0.50000"   "01_TheWarWithin_Dragonflight"
download_branch "10.0.7.49343"   "01_TheWarWithin_Dragonflight"
download_branch "10.0.5.48526"   "01_TheWarWithin_Dragonflight"
download_branch "10.0.2.47631"   "01_TheWarWithin_Dragonflight"

# ==============================================================
# GROUP 2 — Shadowlands (TDB 900–927)
# ==============================================================
download_branch "TDB927.22111"   "02_Shadowlands"
download_branch "TDB927.22082"   "02_Shadowlands"
download_branch "TDB927.22081"   "02_Shadowlands"
download_branch "TDB925.22071"   "02_Shadowlands"
download_branch "TDB920.22031"   "02_Shadowlands"
download_branch "TDB915.22012"   "02_Shadowlands"
download_branch "TDB915.22011"   "02_Shadowlands"
download_branch "TDB915.21111"   "02_Shadowlands"
download_branch "TDB910.21101"   "02_Shadowlands"
download_branch "TDB910.21081"   "02_Shadowlands"
download_branch "TDB905.21071"   "02_Shadowlands"
download_branch "9.2.7.45745"    "02_Shadowlands"
download_branch "9.1.5/42010"    "02_Shadowlands"

# ==============================================================
# GROUP 3 — Battle for Azeroth (TDB 820–837)
# ==============================================================
download_branch "TDB837.20101"   "03_BattleForAzeroth"
download_branch "TDB837.20081"   "03_BattleForAzeroth"
download_branch "TDB830.20061"   "03_BattleForAzeroth"
download_branch "TDB820.19071"   "03_BattleForAzeroth"
download_branch "8.3.7/35662"    "03_BattleForAzeroth"
download_branch "8.2.5/32978"    "03_BattleForAzeroth"
download_branch "8.2.0/31478"    "03_BattleForAzeroth"
download_branch "8.1.5/30706"    "03_BattleForAzeroth"
download_branch "8.0.1/28153"    "03_BattleForAzeroth"

# ==============================================================
# GROUP 4 — Legion (TDB 703–735)
# ==============================================================
download_branch "TDB735.00"      "04_Legion"
download_branch "TDB720.00"      "04_Legion"
download_branch "TDB703.00"      "04_Legion"
download_branch "7.3.5/26972"    "04_Legion"
download_branch "7.2.5/24742"    "04_Legion"
download_branch "7.2.0/24015"    "04_Legion"
download_branch "7.2.0/23911"    "04_Legion"
download_branch "7.1.5/23420"    "04_Legion"
download_branch "7.0.3/22747"    "04_Legion"
download_branch "7.0.3/22248"    "04_Legion"

# ==============================================================
# GROUP 5 — Warlords of Draenor
# ==============================================================
download_branch "6.2.4/21742"    "05_WarlordsOfDraenor"
download_branch "6.2.4/21355"    "05_WarlordsOfDraenor"
download_branch "6.2.3/20886"    "05_WarlordsOfDraenor"

# ==============================================================
# GROUP 6 — TDB6.xx (older format)
# ==============================================================
download_branch "TDB6.04"        "06_TDB6xx"
download_branch "TDB6.03"        "06_TDB6xx"
download_branch "TDB6.02"        "06_TDB6xx"
download_branch "TDB6.01"        "06_TDB6xx"
download_branch "TDB6.00"        "06_TDB6xx"

# ==============================================================
# GROUP 7 — Cataclysm Classic (TDB434/440/441/442)
# ==============================================================
download_branch "TDB442.25051"   "07_CataclysmClassic"
download_branch "TDB441.25021"   "07_CataclysmClassic"
download_branch "TDB440.24101"   "07_CataclysmClassic"
download_branch "TDB440.24061"   "07_CataclysmClassic"
download_branch "TDB434.09"      "07_CataclysmClassic"
download_branch "4.4.1/59069"    "07_CataclysmClassic"
download_branch "4.4.0/57244"    "07_CataclysmClassic"

# ==============================================================
# GROUP 8 — MoP Classic (TDB343.xx)
# ==============================================================
download_branch "TDB343.24081"   "08_MoPClassic"
download_branch "TDB343.23121"   "08_MoPClassic"

# ==============================================================
# GROUP 9 — WotLK 3.3.5a (TDB335.xx) — largest group
# ==============================================================
download_branch "TDB335.25101"   "09_WotLK_3.3.5a"
download_branch "TDB335.24111"   "09_WotLK_3.3.5a"
download_branch "TDB335.24081"   "09_WotLK_3.3.5a"
download_branch "TDB335.24041"   "09_WotLK_3.3.5a"
download_branch "TDB335.24011"   "09_WotLK_3.3.5a"
download_branch "TDB335.23061"   "09_WotLK_3.3.5a"
download_branch "TDB335.23011"   "09_WotLK_3.3.5a"
download_branch "TDB335.22101"   "09_WotLK_3.3.5a"
download_branch "TDB335.22081"   "09_WotLK_3.3.5a"
download_branch "TDB335.22061"   "09_WotLK_3.3.5a"
download_branch "TDB335.22041"   "09_WotLK_3.3.5a"
download_branch "TDB335.22021"   "09_WotLK_3.3.5a"
download_branch "TDB335.22011"   "09_WotLK_3.3.5a"
download_branch "TDB335.21121"   "09_WotLK_3.3.5a"
download_branch "TDB335.21111"   "09_WotLK_3.3.5a"
download_branch "TDB335.21101"   "09_WotLK_3.3.5a"
download_branch "TDB335.21091"   "09_WotLK_3.3.5a"
download_branch "TDB335.21081"   "09_WotLK_3.3.5a"
download_branch "TDB335.21071"   "09_WotLK_3.3.5a"
download_branch "TDB335.21061"   "09_WotLK_3.3.5a"
download_branch "TDB335.21051"   "09_WotLK_3.3.5a"
download_branch "TDB335.21041"   "09_WotLK_3.3.5a"
download_branch "TDB335.21031"   "09_WotLK_3.3.5a"
download_branch "TDB335.21021"   "09_WotLK_3.3.5a"
download_branch "TDB335.21011"   "09_WotLK_3.3.5a"
download_branch "TDB335.20121"   "09_WotLK_3.3.5a"
download_branch "TDB335.20111"   "09_WotLK_3.3.5a"
download_branch "TDB335.20101"   "09_WotLK_3.3.5a"
download_branch "TDB335.20091"   "09_WotLK_3.3.5a"
download_branch "TDB335.20082"   "09_WotLK_3.3.5a"
download_branch "TDB335.20081"   "09_WotLK_3.3.5a"
download_branch "TDB335.20071"   "09_WotLK_3.3.5a"
download_branch "TDB335.20061"   "09_WotLK_3.3.5a"
download_branch "TDB335.20051"   "09_WotLK_3.3.5a"
download_branch "TDB335.20041"   "09_WotLK_3.3.5a"
download_branch "TDB335.20031"   "09_WotLK_3.3.5a"
download_branch "TDB335.20021"   "09_WotLK_3.3.5a"
download_branch "TDB335.20011"   "09_WotLK_3.3.5a"
download_branch "TDB335.19121"   "09_WotLK_3.3.5a"
download_branch "TDB335.19111"   "09_WotLK_3.3.5a"
download_branch "TDB335.19101"   "09_WotLK_3.3.5a"
download_branch "TDB335.19091"   "09_WotLK_3.3.5a"
download_branch "TDB335.19081"   "09_WotLK_3.3.5a"
download_branch "TDB335.19071"   "09_WotLK_3.3.5a"
download_branch "TDB335.19061"   "09_WotLK_3.3.5a"
download_branch "TDB335.19051"   "09_WotLK_3.3.5a"
download_branch "TDB335.19041"   "09_WotLK_3.3.5a"
download_branch "TDB335.19031"   "09_WotLK_3.3.5a"
download_branch "TDB335.64"      "09_WotLK_3.3.5a"
download_branch "TDB335.63"      "09_WotLK_3.3.5a"
download_branch "TDB335.62"      "09_WotLK_3.3.5a"
download_branch "TDB335.61"      "09_WotLK_3.3.5a"
download_branch "TDB335.60"      "09_WotLK_3.3.5a"
download_branch "TDB335.59"      "09_WotLK_3.3.5a"
download_branch "TDB335.58"      "09_WotLK_3.3.5a"
download_branch "TDB335.57"      "09_WotLK_3.3.5a"
download_branch "TDB335.56"      "09_WotLK_3.3.5a"
download_branch "TDB335.55"      "09_WotLK_3.3.5a"
download_branch "TDB335.54"      "09_WotLK_3.3.5a"
download_branch "TDB335.53"      "09_WotLK_3.3.5a"
download_branch "TDB335.52"      "09_WotLK_3.3.5a"
download_branch "TDB335.51"      "09_WotLK_3.3.5a"
download_branch "TDB335.50"      "09_WotLK_3.3.5a"
download_branch "TDB335.49"      "09_WotLK_3.3.5a"
download_branch "TDB335.11.48"   "09_WotLK_3.3.5a"
download_branch "TDB335.11.47"   "09_WotLK_3.3.5a"
download_branch "TDB335.11.46"   "09_WotLK_3.3.5a"
download_branch "TDB335.11.45"   "09_WotLK_3.3.5a"
download_branch "TDB335.11.44"   "09_WotLK_3.3.5a"
download_branch "TDB335.11.43"   "09_WotLK_3.3.5a"

# ============================================================
# Final summary
# ============================================================
TOTAL_FILES=0
if [ -d "$OUTPUT_DIR" ]; then
    TOTAL_FILES=$(find "$OUTPUT_DIR" -type f \
        ! -path "*/.git/*" \
        ! -path "*/.gitattributes" \
        ! -path "*/.gitignore" \
        ! -path "*/README.md" \
        2>/dev/null | wc -l)
fi

log "============================================================"
log "  ALL DONE!"
log "  Total files in TrinityCore_Scripts/: $TOTAL_FILES"
log "  Saved to: $OUTPUT_DIR"
log "  Log saved: $LOG_FILE"
log "============================================================"

echo ""
echo "✅  Finished! Check TrinityCore_Scripts/ and TrinityCore_Scripts_log.txt"
