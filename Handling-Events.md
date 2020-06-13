## This document is not complete

# Handling Events

CmlLib.Core uses only two event handler.  
[`DownloadFileChangedHandler`](#DownloadFileChangedEventHandler) is used when the **file** being downloaded changes.  
[`ProgressChangedEventHandler`](https://docs.microsoft.com/en-us/dotnet/api/system.componentmodel.progresschangedeventhandler?view=netcore-3.1) is used when the **progress** of the currently downloading file changes.  

# DownloadFileChangedEventHandler

`public delegate void DownloadFileChangedHandler(DownloadFileChangedEventArgs e);`

Represents the method that will handle download progress events.  

`e` [DownloadFileChangedEventArgs](#DownloadFileChangedEventArgs)  
The event data

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
Java Runtime. CMLauncher.CheckJRE() raises `FileChange` event with this type.

### Library
Libraries (GAME_DIR/libraries)

### Resource
Resources, Assets (GAME_DIR/assets)

### Minecraft
Minecraft jar file (GAME_DIR/versions)

