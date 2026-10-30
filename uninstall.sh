#!/usr/bin/env bash
# Puts the original Mahjong Soul files back. Close Mahjong Soul first.
# Per file: the copy install.sh saved (original_backup/), or else the untouched original shipped in backup/.
# usage: bash uninstall.sh [path/to/Jantama_MahjongSoul_Data]
set -u
HERE="$(cd "$(dirname "$0")" && pwd)"
REL="steamapps/common/Mahjong Soul/Jantama_MahjongSoul_Data"

find_game() {  # every Steam library of native, Flatpak and Snap Steam
  local root lib
  for root in "$HOME/.steam/steam" "$HOME/.local/share/Steam" \
              "$HOME/.var/app/com.valvesoftware.Steam/.local/share/Steam" "$HOME/snap/steam/common/.local/share/Steam"; do
    [ -d "$root/steamapps" ] || continue
    while IFS= read -r lib; do
      if [ -d "$lib/$REL/StreamingAssets" ]; then echo "$lib/$REL"; return; fi
    done < <(echo "$root"; sed -n 's/.*"path"[[:space:]]*"\(.*\)".*/\1/p' "$root/steamapps/libraryfolders.vdf" 2>/dev/null)
  done
}

GAME="${1:-$(find_game)}"
if [ ! -d "$GAME/StreamingAssets" ]; then
  echo "Mahjong Soul not found in your Steam libraries."
  read -r -p "Paste the path of your Jantama_MahjongSoul_Data folder: " GAME
fi
[ -d "$GAME/StreamingAssets" ] || { echo "That is not the game data folder."; exit 1; }
echo "Game: $GAME"

for dir in StreamingAssets ABM-Fold; do
  for f in "$HERE/backup/$dir"/*; do
    [ -f "$f" ] || continue
    name="$(basename "$f")"; t="$GAME/$dir/StandaloneWindows64/$name"
    [ -f "$t" ] || continue
    [ -f "$HERE/original_backup/$dir/$name" ] && f="$HERE/original_backup/$dir/$name"
    cp "$f" "$t" && echo "restored $dir/$name"
  done
done
echo 'Done. (Steam "Verify integrity of game files" also restores everything.)'
