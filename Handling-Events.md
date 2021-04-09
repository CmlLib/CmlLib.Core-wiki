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

Represents the download progress data of `IDownloader`.

[Source Code](https://github.com/AlphaBs/CmlLib.Core/blob/master/CmlLib/Core/Downloader/DownloadFileChangedEventArgs.cs)

## Properties

### FileKind

_Type: [MFile](#MFile)_

Specifies the type of file currently being downloaded.

### FileName

_Type: string_

The name of the file currently being downloaded.  
_Note: if FileKind is equal to MFile.Resource, this property would be an empty string._

### TotalFileCount;

_Type: int_

The total number of files to download.

### ProgressedFileCount;

_Type: int_

The number of files already downloaded.

# ProgressChangedEventHandler

[docs.microsoft.com](https://docs.microsoft.com/en-us/dotnet/api/system.componentmodel.progresschangedeventhandler?view=netcore-3.1)

# MFile

Indicates the game file type.

`public enum MFile { Runtime, Library, Resource, Minecraft };`

## Fields

### Runtime

Java runtime. `CMLauncher.CheckJRE()` raises `FileChange` event with this type.

### Library

Libraries (GAME_DIR/libraries)

### Resource

Resources and assets (GAME_DIR/assets)

### Minecraft

Minecraft jar file (GAME_DIR/versions)
