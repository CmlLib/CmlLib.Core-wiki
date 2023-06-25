---
description: >-
  Wrapper class of CmlLib.Core. You can easily access many feature of this
  library through this class.
---

# CMLauncher

## Basic Usage

Below codes are very basic launcher but all main features are included. Copy and paste to Console project and try it by yourself.

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

Create Minecraft directory structure and initialize launcher instance. You can change minecraft path and directory structure. See [MinecraftPath.md](MinecraftPath.md "mention")

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

Add event handler. It prints download progress to console. See [Handling-Events.md](Handling-Events.md "mention")

```csharp
var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine(v.Name);
}
```

Get all version and print its names. See [VersionLoader.md](../more-apis/VersionLoader.md "mention")

```csharp
var process = await launcher.CreateProcessAsync("1.16.5", new MLaunchOption
{
    MaximumRamMb = 2048,
    Session = MSession.GetOfflineSession("hello123"),
});
```

Set launch options, check game files, download game files, and return minecraft `Process` instance. See [MLaunchOption.md](MLaunchOption.md "mention") for more launch options.

## Offline mode

In this mode, you can launch game without internet connection. Set `FileDownloader` to `null`, and set `VersionLoader` to `LocalVersionLoader`.

```csharp
var launcher = new CMLauncher(path);

launcher.VersionLoader = new LocalVersionLoader(launcher.MinecraftPath);
launcher.FileDownloader = null;

// ~~~
```

_note: this works only when all game files is normally installed._

## Launch without checking / downloading

This code launch game super fast. (< 1sec)

```csharp
var process = await launcher.CreateProcess("1.18.1", new MLaunchOption()
{
    // game options
}, checkAndDownload: false);
process.Start();
```

_note: this works only when all game files is normally installed._

## API References

<details>

<summary>Methods</summary>

#### MVersionCollection GetAllVersions()

Refresh version list and return them.

#### async Task GetAllVersionsAsync()

Async version of `GetAllVersions()`.

#### MVersion GetVersion(string versionname)

Get `MVersion` instance.

#### async Task GetVersionAsync(string versionname)

Get `MVersion` instance asynchronously.

#### DownloadFile\[] CheckLostGameFiles(MVersion version)

Check all game files and return file list that should be downloaded. It checks all game files using `IFileChecker` in `GameFileChekers` property, combines all game files that should be downloaded into array and return array.

#### async Task\<DownloadFile\[]> CheckLostGameFilesTaskAsync(MVersion version)

Asynchronous version of `CheckLostGameFiles` method.

#### async Task DownloadGameFiles(DownloadFile\[] files)

Download `files` using `FileDownloader` property.

#### void CheckAndDownload(MVersion version)

Check all game files and download files.

#### async Task CheckAndDownloadAsync(MVersion version)

Asynchrounous version of `CheckAndDownload` method.

#### Process CreateProcess(string versionName, MLaunchOption option, bool checkAndDownload=true)

Find `versionName` version from `Versions` property, check game files, and return game process.\
If `checkAndDownload` argument is false, It does not check game files.\
This method does not start game process. You should call `Start()` method of process.

#### Process CreateProcess(MVersion version, MLaunchOption option, bool checkAndDownload=false)

Check game files of `version` and return game process. If `checkAndDownload` argument is false, It does not check game files.\
This method does not start game process. You should call `Start()` method of process.

#### async Task CreateProcessAsync(string versionName, MLaunchOption option, bool checkAndDownload=false)

Asynchrounous version of `CreateProcess(string versionName, MLaunchOption option)` method.

#### async Task CreateProcessAsync(MVersion version, MLaunchOption option, bool checkAndDownload=false)

Asynchrounous version of `CreateProcess(MVersion version, MLaunchOption option)` method.

#### Process CreateProcess(MLaunchOption option)

Create game process which game version is `StartVersion` property of `option`. This method does not check and download game files. This method does not start game process. You should call `Start()` method of process.

#### async Task CreateProcessAsync(MLaunchOption option)

Asynchrounous version of `CreateProcess(MLaunchOption option)` method.

#### Process CreateProcess(string mcversion, string forgeversion, MLaunchOption option)

(not stable)

</details>

<details>

<summary>Properties</summary>

#### MinecraftPath

_Type: MinecraftPath_

#### Versions

_Type: MVersionCollection?_

#### VersionLoader

_Type: IVersionLoader_

#### GameFileCheckers

_Type: FileCheckerCollection_

#### FileDownloader

_Type: IDownloader?_

</details>
