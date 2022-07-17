# CMLauncher

`CMLauncher` 는 `CmlLib.Core` 의 래퍼 클래스입니다. 라이브러리의 대부분의 기능은 이 클래스를 통해서 사용할 수 있으니 이 클래스의 사용 방법을 잘 알아두시는 것이 좋습니다.

## 기본적인 사용 방법 - 비동기 버전

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

### 코드 설명

```csharp
System.Net.ServicePointManager.DefaultConnectionLimit = 256;
```
최대 동시 연결 수를 늘립니다. CmlLib.Core 의 파일 다운로더는 기본적으로 동시에 여러 파일을 받기 때문에, 이 코드가 있어야 빠른 다운로드가 가능합니다.  
이 코드는 프로그램 실행 후 CmlLib.Core 를 사용하기 전에 단 한번만 설정하면 됩니다. 

```csharp
var path = new MinecraftPath();
var launcher = new CMLauncher(path);
```
마인크래프트 디렉터리를 생성하고 런처 인스턴스를 초기화합니다.  
마인크래프트 디렉터리 경로와 디렉터리 구조를 바꿀 수도 있습니다: [MinecraftPath](https://github.com/CmlLib/CmlLib.Core-wiki/blob/master/ko/MinecraftPath.md)

```csharp
launcher.FileChanged += (e) =>
{
    Console.WriteLine($"파일 종류: {e.FileKind.ToString()}");
    Console.WriteLine($"파일 이름: {e.FileName}");
    Console.WriteLine($"파일 갯수: {e.ProgressedFileCount} / {e.TotalFileCount}");
};
launcher.ProgressChanged += (s, e) =>
{
    // 파일 진행률%
    Console.WriteLine("{0}%", e.ProgressPercentage);
};
```

이벤트 헨들러를 등록해서 런처 진행 상황을 콘솔에 전부 출력하는 코드입니다.  
진행률 표시에 대한 더 자세한 정보는 [Event Handler](https://github.com/CmlLib/CmlLib.Core-wiki/blob/master/ko/Handling-Events.md)를 참고하세요.

```csharp
var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine(v.Name);
}
```

런처에서 실행 가능한 모든 버전을 출력합니다.  
[VersionLoader](https://github.com/CmlLib/CmlLib.Core-wiki/blob/master/ko/VersionLoader.md)는 실행 가능한 버전의 목록을 가져오는 역할을 합니다.

```csharp
var process = await launcher.CreateProcessAsync("1.16.5", new MLaunchOption
{
    MaximumRamMb = 2048,
    Session = MSession.GetOfflineSession("hello123"),
});
```

실행 옵션을 설정하고, 게임 파일을 확인하고, 게임 파일을 다운로드 한 후 게임을 실행시켜 마인크래프트의 프로세스 정보가 담긴 `Process` 인스턴스를 만들어 반환합니다.  
[MLaunchOption](https://github.com/CmlLib/CmlLib.Core-wiki/blob/master/ko/MLaunchOption.md) 에서 설정 가능한 모든 실행 옵션을 볼 수 있습니다. 

## 기본적인 사용 방법 - 동기 버전

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

## 오프라인 모드

오프라인 모드에서는 인터넷 연결이 없어도 게임을 실행할 수 있습니다.  
`FileDownloader` 를 `null` 로 설정하고, `VersionLoader` 를 `LocalVersionLoader` 로 설정하세요. 

```csharp
var launcher = new CMLauncher(path);

launcher.VersionLoader = new LocalVersionLoader(launcher.MinecraftPath);
launcher.FileDownloader = null;

// ~~~
```
*note: 실행할 버전의 모든 파일이 설치된 경우에만 정상적으로 작동합니다.*

## 파일 확인, 다운로드 과정 없이 게임 실행하기

게임 파일을 확인하고 다운로드 하는 과정은 오래 걸립니다. 아래 코드는 파일 확인, 다운로드 과정을 뛰어넘고 바로 게임을 실행합니다. (소요시간 1초 미만)

```csharp
var process = await launcher.CreateProcess("1.18.1", new MLaunchOption()
{
    // game options
}, checkAndDownload: false);
process.Start();
```

## Methods

#### MVersionCollection GetAllVersions()

Refresh version list and return them.  

#### async Task<MVersionCollection> GetAllVersionsAsync()

Async version of `GetAllVersions()`.  

#### MVersion GetVersion(string versionname)

Get `MVersion` instance.

#### async Task<MVersion> GetVersionAsync(string versionname)

Get `MVersion` instance asynchronously.

#### DownloadFile[] CheckLostGameFiles(MVersion version)

Check all game files and return file list that should be downloaded. It checks all game files using `IFileChecker` in `GameFileChekers` property, combines all game files that should be downloaded into array and return array.

#### async Task<DownloadFile[]> CheckLostGameFilesTaskAsync(MVersion version)

Asynchronous version of `CheckLostGameFiles` method.

#### async Task DownloadGameFiles(DownloadFile[] files)

Download `files` using `FileDownloader` property.

#### void CheckAndDownload(MVersion version)

Check all game files and download files.

#### async Task CheckAndDownloadAsync(MVersion version)

Asynchrounous version of `CheckAndDownload` method.

#### Process CreateProcess(string versionName, MLaunchOption option, bool checkAndDownload=true)

Find `versionName` version from `Versions` property, check game files, and return game process.   
If `checkAndDownload` argument is false, It does not check game files.  
This method does not start game process. You should call `Start()` method of process.  

#### Process CreateProcess(MVersion version, MLaunchOption option, bool checkAndDownload=false)

Check game files of `version` and return game process.
If `checkAndDownload` argument is false, It does not check game files.  
This method does not start game process. You should call `Start()` method of process.  

#### async Task<Process> CreateProcessAsync(string versionName, MLaunchOption option, bool checkAndDownload=false)

Asynchrounous version of `CreateProcess(string versionName, MLaunchOption option)` method.

#### async Task<Process> CreateProcessAsync(MVersion version, MLaunchOption option, bool checkAndDownload=false)

Asynchrounous version of `CreateProcess(MVersion version, MLaunchOption option)` method.

#### Process CreateProcess(MLaunchOption option)

Create game process which game version is `StartVersion` property of `option`. This method does not check and download game files. 
This method does not start game process. You should call `Start()` method of process.  

#### async Task<Process> CreateProcessAsync(MLaunchOption option)

Asynchrounous version of `CreateProcess(MLaunchOption option)` method.

#### Process CreateProcess(string mcversion, string forgeversion, MLaunchOption option)

(not stable)

## Properties

#### MinecraftPath

*Type: MinecraftPath*

MinecraftPath

#### Versions

*Type: MVersionCollection?*

#### VersionLoader

*Type: IVersionLoader*

#### GameFileCheckers

*Type: FileCheckerCollection*

#### FileDownloader

*Type: IDownloader?*

