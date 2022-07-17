# Handling Events

런처의 진행 상황을 유저에게 보여주고 싶다면 이벤트 헨들러를 등록하세요.  
CmlLib.Core 는 오직 두가지의 이벤트 헨들러만 사용합니다.  
[`DownloadFileChangedHandler`](#DownloadFileChangedEventHandler) 는 처리중인 파일이 바뀌었을 때, 어떤 파일을 처리 중인지, 남은 파일의 수는 얼마나 되는지 등을 알려주기 위한 헨들러입니다.  
[`ProgressChangedEventHandler`](https://docs.microsoft.com/en-us/dotnet/api/system.componentmodel.progresschangedeventhandler?view=netcore-3.1) 는 진행 상황을 바이트 단위로 계산하여 백분율을 알려주기 위한 헨들러입니다. 

## 예시

```csharp
// 이벤트 헨들러 등록
var launcher = new CMLauncher(new MinecraftPath());
launcher.FileChanged += Launcher_FileChanged;
launcher.ProgressChanged += Launcher_ProgressChanged;
```

```csharp
// 이벤트 헨들러
private void Launcher_FileChanged(DownloadFileChangedEventArgs e)
{
    Console.WriteLine($"파일 종류: {e.FileKind.ToString()}");
    Console.WriteLine($"파일 이름: {e.FileName}");
    Console.WriteLine($"파일 갯수: {e.ProgressedFileCount} / {e.TotalFileCount}");
}

private void Launcher_ProgressChanged(object sender, System.ComponentModel.ProgressChangedEventArgs e)
{
    Console.WriteLine(e.ProgressPercentage + "%");
}
```

# DownloadFileChangedEventHandler

`public delegate void DownloadFileChangedHandler(DownloadFileChangedEventArgs e);`

Represents the method that will handle download progress events.

[DownloadFileChangedEventArgs](#DownloadFileChangedEventArgs) contains the download progress.

# DownloadFileChangedEventArgs

Represents the download progress data of `IDownloader`.

[Source Code](https://github.com/CmlLib/CmlLib.Core/blob/master/CmlLib/Core/Downloader/DownloadFileChangedEventArgs.cs)

## Properties

### FileKind

_Type: [MFile](#MFile)_

Specifies the type of file currently being downloaded.

### FileName

_Type: string_

The name of the file currently being downloaded.  
_Note: if FileKind is equal to MFile.Resource, this property would be an empty string._

### Source

_Type: object_  

The source of event. You can determine what object raised the event.  
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
