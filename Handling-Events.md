# DownloadFileChangedEventArgs

Represent the download progress data of `MDownloader`

[Source Code](https://github.com/AlphaBs/CmlLib.Core/blob/master/CmlLib/Core/DownloadFileChangedEventArgs.cs)

## Properties

### FileKind
*Type: [MFile](#MFile)*

Specifies the type of file currently being downloaded.

### FileName
*Type: string*

The name of the file currently being downloaded.  
*Note: if FileKind is MFile.Resource, This property would be empty string.*

### TotalFileCount;
*Type: int*

The number of all files to download.

### ProgressedFileCount;
*Type: int*

The number of files already downloaded.

# MFile

Indicates game file type.

`public enum MFile { Runtime, Library, Resource, Minecraft };`

## Fields

### Runtime
Java Runtime

### Library
Libraries (GAME_DIR/libraries)

### Resource
Resources, Assets (GAME_DIR/assets)

### Minecraft
Minecraft jar file (GAME_DIR/versions)

