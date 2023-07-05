---
description: CmlLib.Core 의 래퍼 클래스. 라이브러리의 대부분 기능을 여기서 쉽게 사용할 수 있습니다.
---

# CMLauncher

## 기본 사용방법

아래 코드는 아주 기본적인 런처이지만 모든 주요 기능이 포함되어 있습니다. 콘솔 프로젝트에 복사 붙여넣기 해서 직접 사용해 보세요.

```csharp
System.Net.ServicePointManager.DefaultConnectionLimit = 256;

var path = new MinecraftPath();
var launcher = new CMLauncher(path);

launcher.FileChanged += (e) =>
{
    Console.WriteLine("파일종류 " + e.FileKind.ToString());
    Console.WriteLine("파일이름 " + e.FileName);
    Console.WriteLine("진행한 파일 수: " + e.ProgressedFileCount);
    Console.WriteLine("총 파일 수: " + e.TotalFileCount);
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

### 코드설명

```csharp
System.Net.ServicePointManager.DefaultConnectionLimit = 256;
```

최대 커넥션 갯수 제한을 늘립니다. 이 코드가 다운로드 속도를 높혀 줍니다.

```csharp
var path = new MinecraftPath();
var launcher = new CMLauncher(path);
```

마인크래프트 디렉터리 구조를 만들고 런처를 초기화합니다. 여기서 마인크래프트 경로와 디렉터리 구조를 바꿀 수 있습니다. [MinecraftPath.md](MinecraftPath.md "mention") 참고

```csharp
launcher.FileChanged += (e) =>
{
    Console.WriteLine("파일종류 " + e.FileKind.ToString());
    Console.WriteLine("파일이름 " + e.FileName);
    Console.WriteLine("진행한 파일 개수: " + e.ProgressedFileCount);
    Console.WriteLine("총 파일 개수: " + e.TotalFileCount);
};
launcher.ProgressChanged += (s, e) =>
{
    Console.WriteLine("{0}%", e.ProgressPercentage);
};
```

이벤트 헨들러를 추가합니다. 다운로드 진행 상황을 콘솔에 출력합니다. [Handling-Events.md](Handling-Events.md "mention")참고

```csharp
var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine(v.Name);
}
```

모든 버전을 불러오고 이름을 출력합니다. [VersionLoader.md](../more-apis/VersionLoader.md "mention")참고

```csharp
var process = await launcher.CreateProcessAsync("1.16.5", new MLaunchOption
{
    MaximumRamMb = 2048,
    Session = MSession.GetOfflineSession("hello123"),
});
```

실행 옵션을 설정하고, 게임 파일을 검사하고, 게임 파일을 다운로드하고, 게임을 실행해 마인크래프트 `Process` 인스턴스를 반환합니다. [MLaunchOption.md](MLaunchOption.md "mention") 에서 더 많은 실행 옵션을 확인하세요.

## 오프라인 모드

{% hint style="info" %}
모든 게임 파일이 정상적으로 설정되어 있을 때에만 작동합니다.
{% endhint %}

이 모드에서는 인터넷 연결 없이 게임을 실행할 수 있습니다. `FileDownloader` 를 `null` 로 설정하고, `VersionLoader` 를 `LocalVersionLoader` 로 설정하세요.

```csharp
var launcher = new CMLauncher(path);

launcher.VersionLoader = new LocalVersionLoader(launcher.MinecraftPath);
launcher.FileDownloader = null;

// ~~~
```

## 게임 파일 확인 / 설치 없이 실행

{% hint style="info" %}
모든 게임 파일이 정상적으로 설정되어 있을 때에만 작동합니다.
{% endhint %}

게임을 아주 빠르게 실행합니다. (1초 미만)

```csharp
var process = await launcher.CreateProcess("1.18.1", new MLaunchOption()
{
    // game options
}, checkAndDownload: false);
process.Start();
```

## API References

<details>

<summary>Methods</summary>

**MVersionCollection GetAllVersions()**

Refresh version list and return them.

**async Task GetAllVersionsAsync()**

Async version of `GetAllVersions()`.

**MVersion GetVersion(string versionname)**

Get `MVersion` instance.

**async Task GetVersionAsync(string versionname)**

Get `MVersion` instance asynchronously.

**DownloadFile\[] CheckLostGameFiles(MVersion version)**

Check all game files and return file list that should be downloaded. It checks all game files using `IFileChecker` in `GameFileChekers` property, combines all game files that should be downloaded into array and return array.

**async Task\<DownloadFile\[]> CheckLostGameFilesTaskAsync(MVersion version)**

Asynchronous version of `CheckLostGameFiles` method.

**async Task DownloadGameFiles(DownloadFile\[] files)**

Download `files` using `FileDownloader` property.

**void CheckAndDownload(MVersion version)**

Check all game files and download files.

**async Task CheckAndDownloadAsync(MVersion version)**

Asynchrounous version of `CheckAndDownload` method.

**Process CreateProcess(string versionName, MLaunchOption option, bool checkAndDownload=true)**

Find `versionName` version from `Versions` property, check game files, and return game process.\
If `checkAndDownload` argument is false, It does not check game files.\
This method does not start game process. You should call `Start()` method of process.

**Process CreateProcess(MVersion version, MLaunchOption option, bool checkAndDownload=false)**

Check game files of `version` and return game process. If `checkAndDownload` argument is false, It does not check game files.\
This method does not start game process. You should call `Start()` method of process.

**async Task CreateProcessAsync(string versionName, MLaunchOption option, bool checkAndDownload=false)**

Asynchrounous version of `CreateProcess(string versionName, MLaunchOption option)` method.

**async Task CreateProcessAsync(MVersion version, MLaunchOption option, bool checkAndDownload=false)**

Asynchrounous version of `CreateProcess(MVersion version, MLaunchOption option)` method.

**Process CreateProcess(MLaunchOption option)**

Create game process which game version is `StartVersion` property of `option`. This method does not check and download game files. This method does not start game process. You should call `Start()` method of process.

**async Task CreateProcessAsync(MLaunchOption option)**

Asynchrounous version of `CreateProcess(MLaunchOption option)` method.

**Process CreateProcess(string mcversion, string forgeversion, MLaunchOption option)**

(not stable)

</details>

<details>

<summary>Properties</summary>

**MinecraftPath**

_Type: MinecraftPath_

**Versions**

_Type: MVersionCollection?_

**VersionLoader**

_Type: IVersionLoader_

**GameFileCheckers**

_Type: FileCheckerCollection_

**FileDownloader**

_Type: IDownloader?_

</details>
