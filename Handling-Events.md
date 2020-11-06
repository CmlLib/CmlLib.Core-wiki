## This document is not complete

# Handling Events

CmlLib.Core uses only two event handlers.  
[`DownloadFileChangedHandler`](#DownloadFileChangedEventHandler) is used when the **file** being downloaded changes.  
[`ProgressChangedEventHandler`](https://docs.microsoft.com/en-us/dotnet/api/system.componentmodel.progresschangedeventhandler?view=netcore-3.1) is used when the **progress** of the file currently being downloaded changes.  

# DownloadFileChangedEventHandler

`public delegate void DownloadFileChangedHandler(DownloadFileChangedEventArgs e);`

Represents the method that will handle download progress events.  


[DownloadFileChangedEventArgs](#DownloadFileChangedEventArgs) contains the download progress.

# DownloadFileChangedEventArgs

Represents the download progress data of `MDownloader`.

[Source Code](https://github.com/AlphaBs/CmlLib.Core/blob/master/CmlLib/Core/Downloader/DownloadFileChangedEventArgs.cs)

## Properties

### FileKind
*Type: [MFile](#MFile)*

Specifies the type of file currently being downloaded.

### FileName
*Type: string*

The name of the file currently being downloaded.  
*Note: if FileKind is equal to MFile.Resource, this property would be an empty string.*

### TotalFileCount;
*Type: int*

The total number of files to download.

### ProgressedFileCount;
*Type: int*

The number of files already downloaded.

# MFile

Indicates the game file type.

`public enum MFile { Runtime, Library, Resource, Minecraft };`

## Fields

### Runtime
Java runtime. CMLauncher.CheckJRE() raises `FileChange` event with this type.

### Library
Libraries (GAME_DIR/libraries)

### Resource
Resources and assets (GAME_DIR/assets)

### Minecraft
Minecraft jar file (GAME_DIR/versions)

