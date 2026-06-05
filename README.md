# 🎮 TrinityCore Scripts Downloader

Two scripts for downloading `src/server/scripts` from the **TrinityCore** GitHub repository:

| Script | What it does |
|---|---|
| **`download_trinitycore_scripts.sh`** | Downloads all **147 tagged TDB releases** spanning every expansion |
| **`download_trinitycore_current_branches.sh`** | Downloads the **4 current active branches** |

---

## 📁 What You Get

```
TrinityCore_Scripts_Downloader/
├── download_trinitycore_scripts.sh           ← 147-branch archive downloader
├── download_trinitycore_current_branches.sh  ← 4 current branches downloader
└── README.md                                 ← this file
```

After running both scripts:

```
TrinityCore_Scripts_Downloader/
├── TrinityCore_Scripts/                      ← from the archive script
│   ├── 01_TheWarWithin_Dragonflight/
│   │   ├── TDB1200.26021/src/server/scripts/...
│   │   └── ...
│   ├── 02_Shadowlands/
│   ├── 03_BattleForAzeroth/
│   ├── 04_Legion/
│   ├── 05_WarlordsOfDraenor/
│   ├── 06_TDB6xx/
│   ├── 07_CataclysmClassic/
│   ├── 08_MoPClassic/
│   └── 09_WotLK_3.3.5a/
│       ├── TDB335.25101/src/server/scripts/...
│       └── ...
├── TrinityCore_Scripts_log.txt               ← archive script log
│
├── TrinityCore_Current/                      ← from the current branches script
│   ├── 01_Master_TheWarWithin/master/...
│   ├── 02_WotLK_3.3.5/3.3.5/...
│   ├── 03_CataclysmClassic/cata_classic/...
│   └── 04_WotLKClassic/wotlk_classic/...
└── TrinityCore_Current_log.txt               ← current branches script log
```

---

## ✅ Requirements

| Tool | Why | Install |
|---|---|---|
| **Git** | Clones repos via sparse checkout | [git-scm.com](https://git-scm.com/) |
| **Bash** | Runs the scripts | Built into macOS/Linux, use Git Bash on Windows |

### Windows Users
Install **Git for Windows** (includes Git Bash). Right-click in the folder → **Git Bash Here** → run the scripts.

### macOS / Linux
Open Terminal, `cd` into this folder, and run.

---

## 🚀 Quick Start

### Step 1 — Make scripts executable (first time only)

```bash
chmod +x download_trinitycore_scripts.sh
chmod +x download_trinitycore_current_branches.sh
```

### Step 2 — Run them

**Download all 147 tagged releases:**
```bash
./download_trinitycore_scripts.sh
```

**Download the 4 current active branches:**
```bash
./download_trinitycore_current_branches.sh
```

**Run both back-to-back:**
```bash
./download_trinitycore_current_branches.sh && ./download_trinitycore_scripts.sh
```

### Step 3 — Check the results

- Browse the `TrinityCore_Scripts/` or `TrinityCore_Current/` folders for your files
- Open the log files to see timestamps, file counts, and a summary

---

## 📜 Script 1 — `download_trinitycore_scripts.sh`

Downloads `src/server/scripts` from **147 tagged TDB releases** organised by expansion.

### Expansion Groups

| # | Group | Branches | Description |
|---|---|---|---|
| 01 | TheWarWithin_Dragonflight | 27 | TDB 1000+ / build tags |
| 02 | Shadowlands | 13 | TDB 900–927 |
| 03 | BattleForAzeroth | 9 | TDB 820–837 |
| 04 | Legion | 10 | TDB 703–735 |
| 05 | WarlordsOfDraenor | 3 | 6.x tags |
| 06 | TDB6xx | 5 | Older format TDB6.xx |
| 07 | CataclysmClassic | 7 | TDB434/440/441/442 |
| 08 | MoPClassic | 2 | TDB343.xx |
| 09 | WotLK_3.3.5a | 70 | TDB335.xx (largest group) |
| | **Total** | **147** | |

### Output

| Item | Path |
|---|---|
| Downloaded files | `TrinityCore_Scripts/` |
| Log file | `TrinityCore_Scripts_log.txt` |

### How to configure

Open the script in any text editor. Each download is a line like:

```bash
download_branch "TAG_NAME"  "GROUP_FOLDER"
```

**To add a new branch** — add a line to the appropriate group:

```bash
download_branch "TDB335.26001"  "09_WotLK_3.3.5a"
```

**To add a new group** — add a new section:

```bash
# ==============================================================
# GROUP 10 — My Custom Group
# ==============================================================
download_branch "some_tag"   "10_MyCustomGroup"
download_branch "other_tag"  "10_MyCustomGroup"
```

**To remove a branch** — delete or comment out the line:

```bash
# download_branch "TDB335.11.43"   "09_WotLK_3.3.5a"
```

---

## 📜 Script 2 — `download_trinitycore_current_branches.sh`

Downloads `src/server/scripts` from the **4 current active TrinityCore branches**.

### Current Branches

| Branch | Group Folder | Description |
|---|---|---|
| `master` | 01_Master_TheWarWithin | The War Within (latest mainline) |
| `3.3.5` | 02_WotLK_3.3.5 | WotLK 3.3.5a maintenance |
| `cata_classic` | 03_CataclysmClassic | Cataclysm Classic |
| `wotlk_classic` | 04_WotLKClassic | WotLK Classic |

### Output

| Item | Path |
|---|---|
| Downloaded files | `TrinityCore_Current/` |
| Log file | `TrinityCore_Current_log.txt` |

### How to configure

Open the script and find the branch download section. Each branch is one line:

```bash
download_branch "BRANCH_NAME"   "FOLDER_NAME"
```

**To add another branch:**

```bash
download_branch "some_branch"   "05_MyBranch"
```

**To remove a branch** — delete or comment out the line:

```bash
# download_branch "wotlk_classic"   "04_WotLKClassic"
```

---

## 📋 Log Files

Both scripts create their own log file with timestamps, file counts, and a final summary.

### Example log entry

```
[2026-06-05 14:35:00] ========================================
[2026-06-05 14:35:00] Downloading branch: TDB335.64 -> ./TrinityCore_Scripts/09_WotLK_3.3.5a/TDB335.64
[2026-06-05 14:35:00] ========================================
[2026-06-05 14:35:12]   [DONE] 09_WotLK_3.3.5a/TDB335.64 — 703 files downloaded
```

### Example summary

```
[2026-06-05 14:50:00] ============================================================
[2026-06-05 14:50:00]   ALL DONE!
[2026-06-05 14:50:00]   Total files in TrinityCore_Scripts/: 108426
[2026-06-05 14:50:00]   Saved to: ./TrinityCore_Scripts
[2026-06-05 14:50:00]   Log saved: ./TrinityCore_Scripts_log.txt
[2026-06-05 14:50:00] ============================================================
```

---

## 🔄 Re-Downloading

Both scripts **skip** anything that already exists. To re-download:

**Remove a single branch:**
```bash
rm -rf TrinityCore_Scripts/09_WotLK_3.3.5a/TDB335.64
rm -rf TrinityCore_Current/04_WotLKClassic
```

**Remove everything and start fresh:**
```bash
rm -rf TrinityCore_Scripts TrinityCore_Current
```

Then re-run the script(s).

---

## 🛠️ Troubleshooting

| Problem | Solution |
|---|---|
| `command not found: git` | Install Git from [git-scm.com](https://git-scm.com/) |
| `Permission denied` | Run `chmod +x download_trinitycore_scripts.sh` |
| Branch/tag not found | Check the tag exists on the GitHub repo's releases page |
| Download stalls | Check your internet. Re-run to resume (skips existing) |
| Want to update a branch | Delete its folder and re-run |

---

## 📊 Quick Reference

| | `download_trinitycore_scripts.sh` | `download_trinitycore_current_branches.sh` |
|---|---|---|
| **What** | All 147 tagged TDB releases | 4 current active branches |
| **Output** | `TrinityCore_Scripts/` | `TrinityCore_Current/` |
| **Log** | `TrinityCore_Scripts_log.txt` | `TrinityCore_Current_log.txt` |
| **Branches** | 147 (fixed list) | 4 (easy to add more) |
| **Configure** | Edit `download_branch` lines | Edit `download_branch` lines |

---

*Made for the WoW private server development community.*
