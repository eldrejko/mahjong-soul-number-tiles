#!/usr/bin/env bash
# Installs the Mahjong Soul number tiles (Steam on Linux / Proton). Close Mahjong Soul first.
# Your own files are saved to original_backup/ before anything is replaced.
# usage: bash install.sh [path/to/Jantama_MahjongSoul_Data]
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

n=0; skip=0
for dir in StreamingAssets ABM-Fold; do
  for f in "$HERE/files/$dir"/*; do
    [ -f "$f" ] || continue
    name="$(basename "$f")"; t="$GAME/$dir/StandaloneWindows64/$name"
    if [ ! -f "$t" ]; then echo "skip $dir/$name (not in your game)"; skip=$((skip+1)); continue; fi
    if cmp -s "$t" "$HERE/backup/$dir/$name"; then  # still the untouched original, not another version of this skin
      mkdir -p "$HERE/original_backup/$dir"
      [ -f "$HERE/original_backup/$dir/$name" ] || cp "$t" "$HERE/original_backup/$dir/$name"
    fi
    cp "$f" "$t" && echo "ok   $dir/$name" && n=$((n+1))
  done
done
echo
echo "Installed $n file(s), skipped $skip."
[ "$skip" -gt 0 ] && echo "Skipped files belong to a different game version - the matching part of the skin won't show."
exit 0
