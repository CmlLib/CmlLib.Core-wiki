---
description: Show launching progress to user
---

# Event Handling

When you want to show progress to users, add event handlers.\
CmlLib.Core uses only two event handlers.\
[`DownloadFileChangedHandler`](Handling-Events.md#DownloadFileChangedEventHandler) is used when the **file** being downloaded changes. (ex: file counts)\
[`ProgressChangedEventHandler`](https://docs.microsoft.com/en-us/dotnet/api/system.componentmodel.progresschangedeventhandler?view=netcore-3.1) is used when the **progress** of the file currently being downloaded changes. (ex: byte progress)

### Example

```csharp
// add event handlers
var launcher = new CMLauncher(new MinecraftPath());
launcher.FileChanged += Launcher_FileChanged;
launcher.ProgressChanged += Launcher_ProgressChanged;
```

```csharp
// event handler
private void Launcher_FileChanged(DownloadFileChangedEventArgs e)
{
    Console.WriteLine("FileKind: " + e.FileKind.ToString());
    Console.WriteLine("FileName: " + e.FileName);
    Console.WriteLine("TotalFileCount: " + e.TotalFileCount);
    Console.WriteLine("ProgressedFiles: " + e.ProgressedFileCount);
}

private void Launcher_ProgressChanged(object sender, System.ComponentModel.ProgressChangedEventArgs e)
{
    Console.WriteLine("{0}%", e.ProgressPercentage);
}
```

## DownloadFileChangedEventHandler

`public delegate void DownloadFileChangedHandler(DownloadFileChangedEventArgs e);`

Represents the method that will handle download progress events.

[DownloadFileChangedEventArgs](Handling-Events.md#DownloadFileChangedEventArgs) contains the download progress.

## DownloadFileChangedEventArgs

Represents the download progress data of `IDownloader`.

[Source Code](https://github.com/CmlLib/CmlLib.Core/blob/master/CmlLib/Core/Downloader/DownloadFileChangedEventArgs.cs)

### Properties

#### FileKind

_Type:_ [_MFile_](Handling-Events.md#MFile)

Specifies the type of file currently being downloaded.

#### FileName

_Type: string_

The name of the file currently being downloaded.\
_Note: if FileKind is equal to MFile.Resource, this property would be an empty string._

#### Source

_Type: object_

The source of event. You can determine what object raised the event.\
Example:

```csharp
if (e.Source is IFileChecker)
{
    // raised by IFileChecker
    // game file checking
}
else if (e.Source is IDownloader)
{
    // raised by IDownloader
    // file downloading
}
else
{
    // etc (MForge, or )
}
```

#### TotalFileCount;

_Type: int_

The total number of files to download.

#### ProgressedFileCount;

_Type: int_

The number of files already downloaded.

## ProgressChangedEventHandler

[docs.microsoft.com](https://docs.microsoft.com/en-us/dotnet/api/system.componentmodel.progresschangedeventhandler?view=netcore-3.1)

## MFile

Indicates the game file type.

`public enum MFile { Runtime, Library, Resource, Minecraft };`

### Fields

#### Runtime

Java runtime. `CMLauncher.CheckJRE()` raises `FileChange` event with this type.

#### Library

Libraries (GAME\_DIR/libraries)

#### Resource

Resources and assets (GAME\_DIR/assets)

#### Minecraft

Minecraft jar file (GAME\_DIR/versions)
