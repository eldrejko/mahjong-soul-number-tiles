# simple-tile-watcher

Readable number tiles for **Mahjong Soul (Steam)**. The Chinese numerals on the number tiles become
big digits, so you can tell 1-9 apart at a glance:

- characters (man): black digit, red 萬 kept
- dots (pin): blue digit
- bamboo (sou): green digit
- red fives: red digit

Winds, dragons and the table centre are left exactly as the game ships them.

![preview](preview.png)

## Install

1. Download `MahjongSoul_SerbianTiles.zip` from the [latest release](../../releases/latest) and unzip it.
2. Close Mahjong Soul.
3. Double-click `install.bat`. It backs up your original files first. If the game isn't in the
   default Steam folder, it asks for the path to `Jantama_MahjongSoul_Data`.
4. In the game, use the **default** tile design (only that one is changed).

## Uninstall

Close the game and run `uninstall.bat`, or use Steam → Properties → Installed Files →
*Verify integrity of game files*.

## Notes

- Built for the current Steam version. If `install.bat` says **skip** for a file, your game has a
  different version of that file and that part won't change.
- A game update can undo it. Just run `install.bat` again.
- Modifying game files is against the Mahjong Soul terms of service. Use at your own risk.
