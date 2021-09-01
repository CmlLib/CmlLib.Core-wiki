# CMLauncher

작성중

English: Writing

CMLauncher 는 CmlLib.Core 의 래퍼 클래스입니다. 버전 가져오기, 게임 실행 등 라이브러리의 대부분의 기능을 이 클래스를 통해 접근할 수 있습니다.  

English: CMLauncher is a wrapper class for CmlLib.Core . Most of the library's functionality, such as getting versions and running games, can be accessed through this class.

CmlLib.Core의 기능을 이용할 때에는 내부 클래스에 직접 접근하기 보다는 CMLauncher 를 통해 기능을 이용하는 것이 좋습니다.

English: When using the functions of CmlLib.Core, it is recommended to use the functions through CMLauncher rather than directly accessing the inner class.

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

Adds the event handler. It prints the download progress to the console.  
[Event Handler](https://github.com/CmlLib/CmlLib.Core/wiki/Handling-Events)

```csharp
var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine(v.Name);
}
```

Gets all the versions and prints each of their names.
[VersionLoader](https://github.com/CmlLib/CmlLib.Core/wiki/VersionLoader)

```csharp
var process = await launcher.CreateProcessAsync("1.16.5", new MLaunchOption
{
    MaximumRamMb = 2048,
    Session = MSession.GetOfflineSession("hello123"),
});
```

Once you have set launch options, checked game files, downloaded game files, this will return a Minecraft `Process` instance.  
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
*english note: Since files cannot be downloaded, the game may not run normally if all files are not installed.*
## Methods

#### MVersionCollection GetAllVersions()

`VersionLoader` 를 이용해 버전 목록을 반환합니다.
English: Uses VersionLoader to return a list of versions.

#### async Task<MVersionCollection> GetAllVersionsAsync()

`GetAllVersions()` 의 비동기 버전입니다. 
English: GetAllVersionsAsync() is the asynchronous version of GetAllVersions()

#### MVersion GetVersion(string versionname)

Gets `MVersion` instance.

#### async Task<MVersion> GetVersionAsync(string versionname)

Gets `MVersion` instance asynchronously.

#### DownloadFile[] CheckLostGameFiles(MVersion version)

모든 파일을 검사하고 다운로드가 필요한 파일의 목록을 반환합니다. `GameFileCheckers` 의 모든 `IFileChecker` 를 이용해 게임 파일을 검사하고 반환하는 모든 파일을 하나의 배열로 만들어 반환합니다.
    
English: Scans all files and returns a list of files that need to be downloaded. Checks game files using all `IFileChecker` of `GameFileCheckers` and returns all returned files as an array.

#### async Task<DownloadFile[]> CheckLostGameFilesTaskAsync(MVersion version)

CheckLostGameFiles 를 비동기적으로 수행합니다 (English: asynchronously).

#### async Task DownloadGameFiles(DownloadFile[] files)

`FileDownloader` 를 이용해 `files` 를 모두 다운로드합니다.
English: Downloads all files using FileDownloader.

#### void CheckAndDownload(MVersion version)

`versions` 의 모든 파일을 확인하고 존재하지 않거나 해시가 다른 파일을 모두 다운로드받습니다.
English: Check all files in your versions folder and downloads some files that aren't currently there.

#### async Task CheckAndDownloadAsync(MVersion version)

`CheckAndDownload` 를 비동기적으로 수행합니다.
English: Performs `CheckAndDownload` asynchronously.

#### Process CreateProcess(string versionName, MLaunchOption option)

`versionName` 의 이름을 가진 `Versions` 에서 찾고 게임 파일을 확인하고 다운로드 한 후 `Process` 를 반환합니다.
English: Looks in your `Versions` folder and finds the folder called versionName and returns a `Process` after checking and downloading the game file.

#### Process CreateProcess(MVersion version, MLaunchOption option)

`MVersion` 의 게임 파일을 확인하고 다운로드 한 후 `Process` 를 반환합니다.
English: It checks and downloads the game files in `MVersion` and returns a `Process`.

#### async Task<Process> CreateProcessAsync(string versionName, MLaunchOption option)

`CreateProcess(string versionName, MLaunchOption option)` 의 비동기 버전입니다. 
English: Asynchronous version of `CreateProcess(string versionName, MLaunchOption option)`

#### async Task<Process> CreateProcessAsync(MVersion version, MLaunchOption option)

`CreateProcess(MVersion version, MLaunchOption option)` 의 비동기 버전입니다.
English: Asynchronous version of `CreateProcess(MVersion version, MLaunchOption option)` .

#### Process CreateProcess(MLaunchOption option)

`option` 의 `StartVersion` 속성을 이용해 `Process` 를 만들어 반환합니다. 이 메서드는 게임 파일 확인과 다운로드를 수행하지 않습니다. 
English: Creates and returns a `Process` using the `StartVersion` property of `option`. This method does not check and download game files
    
#### async Task<Process> CreateProcessAsync(MLaunchOption option)

`CreateProcess(MLaunchOption option)` 의 비동기 버전입니다.
English: Asynchronous version of `CreateProcess(MLaunchOption option)`.

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

