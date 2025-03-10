# akalabeth128
Akalabeth: World of Doom (1979) by Richard Garriott, ported to the Commodore 128 (VIC II/40 column mode) in pure MS BASIC 7.0

This is a single-file almost line-by-line conversion of the original Apple II source found here: https://archive.org/details/a2_Akalabeth_1980_California_Pacific_Computer_a

There are already better conversions for the Commodore 64, but the purpose of this exercise was not to compete with them.
Instead, noting the similarities between the two versions of BASIC, the goal was simply to create a conversion that was as close to the original code as possible.

One of the main differences is that AppleSoft BASIC lets you move the cursor and output characters outside of the "text window".
The way around that is to change the window every time instead (e.g. lines 60237, 60240).
Also, when the bitmap screen in split mode is cleared, the current text window is also cleared.
To prevent that, a dummy window is defined before clearing the bitmap screen (lines 1097, 1098).

MS BASIC also does not have a command to move the cursor to an arbitrary position that corrisponds to the VTAB()/HTAB() commands of AppleSoft BASIC.
Luckily there is a Kernal routine to do exactly that (line 5 sets up the "pointer").
BASIC v7.0 also has the CHAR command, which can be used with an empty string to the same effect, but that would be slightly slower.

Another minor difference: screen coordinates for text are 1 to 40 and 1 to 25 in AppleSoft BASIC, but 0 to 39 and 0 to 24 on the Commodore.

## Game Controls
Controls had to be remapped due to the different keyboard layout:
- Move North/forward: cursor up OR 'O'
- Move East/turn right: cursor right OR 'L'
- Move West/turn left: cursor left OR 'K'
- Move South/backwards: cursor down OR ','
- Attack: 'A'
- Stats: 'S'
- Enter: 'X'
- Pause: 'P'
- Pass: space bar OR escape

## Version History
- v1.0
  - Initial release
- v1.1
  - Fixed a bug that prevented some doors being drawn in dungeons.
  - Fixed a bug that didn't show the dialogue in Lord British's castle correctly.
- v1.2 (fixes by Wil)
  - removed spaces in lines 384-386 since they caused the line length to exceed maximum length, leading to a system hang after loading the file with LOAD or DLOAD (BLOAD worked though)
  - added missing PRINT in line 6030
  - changed lines 1700-1720 to wait for input before clearing the screen when viewing stats
  
  
  