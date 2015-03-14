# TES5Edit-GoogleCode
TES5Dump (a.k.a. TES4Dump / FO3Dump / FNVDump) are utilities that dump the contents of a .esp or .esm plugin to a text file, using internal record definitions. By comparing its output with plugins of known contents, the record definitions can be tweaked until the correct structures have been decoded. TES5Dump also forms the plugin parsing backend for the TES5Edit utility. (a.k.a. TES4Edit / FO3Edit / FNVEdit)

Skyrim's record structure has not yet been fully decoded, and the Skyrim modding community suffers from the lack of a working TES5Edit. This project's aim is to help the decoding effort by providing TES5Dump and allowing many people to update its definitions using Subversion, and to provide the TES5Edit utility. 

Its predecessors FNVEdit, FO3Edit, and TES4Edit by ElminsterAU are the best tools to use for exploring overlaps between mods and cleaning mods. TES5Edit will have the same functionality since the compiled release will be made with the same TES4 back engine using the definitions as a result of this project. He would work on it himself, but unfortunately suffers from a severe lack of spare time. He has offered to compile TES5Edit after the necessary supporting files are changed for Skyrim's file format. 

This utility will let you easily see how multiple mods interact and override each other, as well as giving you a quick view of the changes that a plugin makes. It lets you browse a graphical record tree of your active plugins, revealing the values set by most record types and comparing overlapping changes from each active plugin.

When started it will automatically find your Skyrim Data directory. You then get a dialog to select which modules you want to load with the current selection from your plugins.txt as default value. Once you have confirmed that dialog the selected modules will start loading in the background. The program will then work the same as its predecessors.
