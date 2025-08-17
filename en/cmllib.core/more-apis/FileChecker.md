---
description: Extract game files
---

# FileExtractor

`IFileExtractor` extracts all `GameFile` from a given version.  

The library provides five built-in extractors:

* AssetFileExtractor: extract asset files (`<game_directory>/assets/objects`)
* ClientFileExtractor: extract version.jar file (`<game_directory>/versions/<version>/<version>.jar`)
* JavaFileExtractor: extract java files (`<game_directory>/runtime`)
* LibraryFileExtractor: extract library files (`<game_directory>/libraries`)
* LogFileExtractor: extract log config file (`<game_directory>/assets/log_configs`)

Any `GameFile` generated here is passed to [GameInstaller](Downloader.md), which would download a file if the file does not exist or its checksum is not equal.

Implement the `IFileExtractor` interface and add it to the launcher if you want the launcher to check and download more files (e.g. mod files). See [MinecraftLauncherParameters](minecraftlauncherparameters.md)
