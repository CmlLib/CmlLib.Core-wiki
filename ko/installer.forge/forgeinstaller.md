# ForgeInstaller

ForgeInstaller는 마인크래프트용 포지 버전을 다운로드하고 설치하는 기능을 제공합니다.

## 설치 프로그램 초기화

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);
var forgeInstaller = new ForgeInstaller(launcher);
```

선택적으로 `new ForgeInstaller(launcher, new HttpClient())`와 같이 포지 웹사이트에 접근할 때 사용할 HttpClient를 설정할 수 있습니다.

## 사용 가능한 버전 목록

```csharp
var versions = await forgeInstaller.GetForgeVersions("1.20.1");
foreach (var version in versions)
{
    Console.WriteLine();
    Console.WriteLine("MinecraftVersion: " + version.MinecraftVersionName);
    Console.WriteLine("ForgeVersion: " + version.ForgeVersionName);
    Console.WriteLine("Time: " + version.Time);
    Console.WriteLine("IsLatestVersion: " + version.IsLatestVersion);
    Console.WriteLine("IsRecommendedVersion: " + version.IsRecommendedVersion);

    var installerFile = version.GetInstallerFile();
    if (installerFile != null)
    {
        Console.WriteLine("Type: " + installerFile.Type);
        Console.WriteLine("DirectUrl: " + installerFile.DirectUrl);
        Console.WriteLine("AdUrl: " + installerFile.AdUrl);
        Console.WriteLine("MD5: " + installerFile.MD5);
        Console.WriteLine("SHA1: " + installerFile.SHA1);
    }
}
```

지정된 마인크래프트 버전에 대해 설치 가능한 모든 포지 버전을 가져옵니다.

## 설치

### 최적 버전 설치

```csharp
var installedVersionName = await forgeInstaller.Install("1.20.1", new ForgeInstallOptions());
```

마인크래프트 1.20.1에 사용 가능한 가장 적절한 포지 버전을 찾아 설치합니다.

적절한 버전은 다음 우선순위 규칙을 따라 선택됩니다:

1. 'Recommended Version' 플래그가 있는 첫 번째 버전
2. 'Latest Version' 플래그가 있는 첫 번째 버전
3. 버전 목록에서 최상위 버전

### 특정 버전 설치

```csharp
var installedVersionName = await forgeInstaller.Install("1.20.1", "47.1.0", new ForgeInstallOptions());
```

마인크래프트 1.20.1용 포지 버전 47.1.0을 설치합니다.

### 최신 버전 설치

```csharp
var versions = await forgeInstaller.GetForgeVersions("1.20.1");
var latestVersion = versions.First(v => v.IsLatestVersion);
var installedVersionName = await forgeInstaller.Install(latestVersion, new ForgeInstallOptions());
```

마인크래프트 1.20.1에 사용 가능한 최신 포지 버전을 찾아 설치합니다.

## 설치 옵션

설치 진행률 표시, 설치 취소 등의 기능을 사용하려면 `ForgeInstallOptions`에 적절한 값을 설정하세요.

```csharp
var installOptions = new ForgeInstallOptions
{
    FileProgress = new Progress<InstallerProgressChangedEventArgs>(e =>
        Console.WriteLine($"[{e.EventType}][{e.ProgressedTasks}/{e.TotalTasks}] {e.Name}")),
    ByteProgress = new Progress<ByteProgress>(e =>
        Console.WriteLine(e.ToRatio() * 100 + "%")),
    InstallerOutput = new Progress<string>(e =>
        Console.WriteLine(e)),
    CancellationToken = CancellationToken.None,

    JavaPath = "java.exe",
    SkipIfAlreadyInstalled = true,
};
var installedVersionName = await forgeInstaller.Install("1.20.1", installOptions);
```

- **FileProgress** 및 **ByteProgress**: 파일 다운로드 진행률을 보고합니다. 자세한 내용은 [이벤트 처리](../cmllib.core/getting-started/Handling-Events.md)를 참조하세요.
- **InstallerOutput**: 설치 프로그램의 콘솔에서 출력되는 로그를 보고합니다.
- **CancellationToken**: 설치 과정을 취소할 수 있습니다.
- **JavaPath**: 설치 프로그램을 실행하는 데 사용할 Java 런타임의 경로를 설정합니다. 기본값은 `null`이며, Java 런타임 경로를 자동으로 결정합니다.
- **SkipIfAlreadyInstalled**: `true`로 설정하면 대상 버전이 이미 설치되어 있는 경우 설치를 건너뜁니다. 기본값은 `true`입니다.

## 완전한 설치에 대한 중요 사항

`forgeInstaller.Install`은 포지 버전을 완전히 설치하지 않습니다. 버전에는 사운드 에셋, Java 런타임, 바닐라 버전 파일 등의 추가 파일이 여전히 필요합니다. 따라서 게임을 실행하기 전에 항상 `launcher.InstallAsync`를 호출해야 합니다.

```csharp
// 포지 설치
var versionName = await forgeInstaller.Install("1.20.1", new ForgeInstallOptions());

// 나머지 종속성 설치 (사운드 에셋, Java 런타임, 바닐라 버전)
await launcher.InstallAsync(versionName);

// 게임 실행
var process = await launcher.BuildProcessAsync(versionName, new MLaunchOption
{
    MaximumRamMb = 1024,
    Session = MSession.CreateOfflineSession("Gamer123"),
});
process.Start();
```

## 광고에 대해

`ForgeInstaller`는 성공적인 설치 후 광고 페이지를 표시합니다. 공식 포지 설치 프로그램은 다음 메시지를 표시합니다:

```
Please do not automate the download and installation of Forge.
Our efforts are supported by ads from the download page.
If you MUST automate this, please consider supporting the project through https://www.patreon.com/LexManos
```

이 동작을 비활성화하려면 [ForgeInstaller 소스 코드](https://github.com/CmlLib/CmlLib.Core.Installer.Forge/blob/main/CmlLib.Core.Installer.Forge/ForgeInstaller.cs)를 직접 수정할 수 있습니다.
