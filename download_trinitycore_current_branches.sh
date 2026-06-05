#!/bin/bash

# ============================================================
# TrinityCore — CURRENT ACTIVE BRANCHES DOWNLOADER
#
# Downloads src/server/scripts from the 4 current active
# TrinityCore branches (master, 3.3.5, cata_classic, wotlk_classic).
#
# Run this on YOUR machine — requires git to be installed.
# Usage:
#   chmod +x download_trinitycore_current_branches.sh
#   ./download_trinitycore_current_branches.sh
#
# Creates:
#   ./TrinityCore_Current/          — all downloaded script files
#   ./TrinityCore_Current_log.txt   — timestamped download log
# ============================================================

REPO="https://github.com/TrinityCore/TrinityCore.git"
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
OUTPUT_DIR="$SCRIPT_DIR/TrinityCore_Current"
LOG_FILE="$SCRIPT_DIR/TrinityCore_Current_log.txt"
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
log "  download_trinitycore_current_branches.sh — Started"
log "  Output: $OUTPUT_DIR"
log "  Log:    $LOG_FILE"
log "============================================================"
log ""

# ==============================================================
# Current active branches from TrinityCore
# ==============================================================

# master — The War Within (latest mainline development)
download_branch "master"          "01_Master_TheWarWithin"

# 3.3.5 — WotLK 3.3.5a (long-standing maintenance branch)
download_branch "3.3.5"           "02_WotLK_3.3.5"

# cata_classic — Cataclysm Classic
download_branch "cata_classic"    "03_CataclysmClassic"

# wotlk_classic — WotLK Classic
download_branch "wotlk_classic"   "04_WotLKClassic"

# ==============================================================
# To add more branches, add lines like:
#
#   download_branch "branch_name"   "05_FolderName"
#
# ==============================================================

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
log "  Total files in TrinityCore_Current/: $TOTAL_FILES"
log "  Saved to: $OUTPUT_DIR"
log "  Log saved: $LOG_FILE"
log "============================================================"

echo ""
echo "✅  Finished! Check TrinityCore_Current/ and TrinityCore_Current_log.txt"
