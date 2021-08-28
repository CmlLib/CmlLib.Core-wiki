# CMLauncher

작성중 (writing)  
Use google translator for english user. 

CMLauncher 는 CmlLib.Core 의 래퍼 클래스입니다. 버전 가져오기, 게임 실행 등 라이브러리의 대부분의 기능을 이 클래스를 통해 접근할 수 있습니다.  

CmlLib.Core의 기능을 이용할 때에는 내부 클래스에 직접 접근하기 보다는 CMLauncher 를 통해 기능을 이용하는 것이 좋습니다.

## Basic Usage - Async version

```csharp
System.Net.ServicePointManager.DefaultConnectionLimit = 256;

var path = new MinecraftPath();
var launcher = new CMLauncher(path);

launcher.FileChanged += (e) =>
{
    Console.WriteLine("[{0}] {1} - {2}/{3}", e.FileKind.ToString(), e.FileName, e.ProgressedFileCount, e.TotalFileCount);
};
launcher.ProgressChanged += (s, e) =>
{
    Console.WriteLine("{0}%", e.ProgressPercentage);
};

var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine(v.Name);
}

var process = await launcher.CreateProcess("1.16.5", new MLaunchOption
{
    MaximumRamMb = 2048,
    Session = MSession.GetOfflineSession("hello123"),
});

process.Start();
```

### Explaination

```csharp
System.Net.ServicePointManager.DefaultConnectionLimit = 256;
```
Increase the maximum number of concurrent connections. This code would increase download speed. 

```csharp
var path = new MinecraftPath();
var launcher = new CMLauncher(path);
```
Create Minecraft directory structure and initialize launcher instance.  
You can change minecraft path and directory structure.  
[MinecraftPath](https://github.com/CmlLib/CmlLib.Core/wiki/MinecraftPath)

```csharp
launcher.FileChanged += (e) =>
{
    Console.WriteLine("[{0}] {1} - {2}/{3}", e.FileKind.ToString(), e.FileName, e.ProgressedFileCount, e.TotalFileCount);
};
launcher.ProgressChanged += (s, e) =>
{
    Console.WriteLine("{0}%", e.ProgressPercentage);
};
```

Add event handler. It prints download progress to console.  
[Event Handler](https://github.com/CmlLib/CmlLib.Core/wiki/Handling-Events)

```csharp
var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine(v.Name);
}
```

Get all version and print all version names.  
[VersionLoader](https://github.com/CmlLib/CmlLib.Core/wiki/VersionLoader)

```csharp
var process = await launcher.CreateProcessAsync("1.16.5", new MLaunchOption
{
    MaximumRamMb = 2048,
    Session = MSession.GetOfflineSession("hello123"),
});
```

Set launch options, check game files, download game files, and return minecraft `Process` instance.  
[MLaunchOption](https://github.com/CmlLib/CmlLib.Core/wiki/MLaunchOption)

## Basic Usage - Sync Version

```csharp
System.Net.ServicePointManager.DefaultConnectionLimit = 256;

var path = new MinecraftPath();
var launcher = new CMLauncher(path);

launcher.FileChanged += (e) =>
{
    Console.WriteLine("[{0}] {1} - {2}/{3}", e.FileKind.ToString(), e.FileName, e.ProgressedFileCount, e.TotalFileCount);
};
launcher.ProgressChanged += (s, e) =>
{
    Console.WriteLine("{0}%", e.ProgressPercentage);
};

var versions = launcher.GetAllVersions();
foreach (var v in versions)
{
    Console.WriteLine(v.Name);
}

var process = launcher.CreateProcess("1.16.5", new MLaunchOption
{
    MaximumRamMb = 2048,
    Session = MSession.GetOfflineSession("hello123"),
});

process.Start();
```

## Offline mode

이 모드에서는 인터넷 연결이 없어도 게임 실행을 정상적으로 할 수 있습니다.  
Set `FileDownloader` to `null`, and set `VersionLoader` to `LocalVersionLoader`.

```csharp
var launcher = new CMLauncher(path);

launcher.VersionLoader = new LocalVersionLoader(launcher.MinecraftPath);
launcher.FileDownloader = null;

// ~~~
```
*note: 파일 다운로드를 할 수 없기 때문에 모든 파일이 설치되어 있지 않은 경우에는 정상적으로 게임 실행이 불가할 수 있습니다.*

## Methods

#### MVersionCollection GetAllVersions()

`VersionLoader` 를 이용해 버전 목록을 반환합니다.

#### async Task<MVersionCollection> GetAllVersionsAsync()

`GetAllVersions()` 의 비동기 버전입니다. 

#### MVersion GetVersion(string versionname)

Get `MVersion` instance.

#### async Task<MVersion> GetVersionAsync(string versionname)

Get `MVersion` instance asynchronously.

#### DownloadFile[] CheckLostGameFiles(MVersion version)

모든 파일을 검사하고 다운로드가 필요한 파일의 목록을 반환합니다. `GameFileCheckers` 의 모든 `IFileChecker` 를 이용해 게임 파일을 검사하고 반환하는 모든 파일을 하나의 배열로 만들어 반환합니다.

#### async Task<DownloadFile[]> CheckLostGameFilesTaskAsync(MVersion version)

CheckLostGameFiles 를 비동기적으로 수행합니다.

#### async Task DownloadGameFiles(DownloadFile[] files)

`FileDownloader` 를 이용해 `files` 를 모두 다운로드합니다.

#### void CheckAndDownload(MVersion version)

`versions` 의 모든 파일을 확인하고 존재하지 않거나 해시가 다른 파일을 모두 다운로드받습니다.

#### async Task CheckAndDownloadAsync(MVersion version)

`CheckAndDownload` 를 비동기적으로 수행합니다.

#### Process CreateProcess(string versionName, MLaunchOption option)

`versionName` 의 이름을 가진 `Versions` 에서 찾고 게임 파일을 확인하고 다운로드 한 후 `Process` 를 반환합니다.

#### Process CreateProcess(MVersion version, MLaunchOption option)

`MVersion` 의 게임 파일을 확인하고 다운로드 한 후 `Process` 를 반환합니다.

#### async Task<Process> CreateProcessAsync(string versionName, MLaunchOption option)

`CreateProcess(string versionName, MLaunchOption option)` 의 비동기 버전입니다. 

#### async Task<Process> CreateProcessAsync(MVersion version, MLaunchOption option)

`CreateProcess(MVersion version, MLaunchOption option)` 의 비동기 버전입니다.

#### Process CreateProcess(MLaunchOption option)

`option` 의 `StartVersion` 속성을 이용해 `Process` 를 만들어 반환합니다. 이 메서드는 게임 파일 확인과 다운로드를 수행하지 않습니다. 

#### async Task<Process> CreateProcessAsync(MLaunchOption option)

`CreateProcess(MLaunchOption option)` 의 비동기 버전입니다.

#### Process CreateProcess(string mcversion, string forgeversion, MLaunchOption option)

(not stable)

## Properties

#### MinecraftPath

*Type: MinecraftPath*

MinecraftPath

#### Versions

*Type: MVersionCollection?*

public

#### VersionLoader

*Type: IVersionLoader*

#### GameFileCheckers

*Type: FileCheckerCollection*

#### FileDownloader

*Type: IDownloader?*

