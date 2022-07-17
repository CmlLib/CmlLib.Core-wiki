# LiteLoader Installer

LiteLoader 버전 설치

## 예제

```csharp
var path = new MinecraftPath();
var launcher = new CMLauncher(path);
launcher.FileChanged += Downloader_ChangeFile;
launcher.ProgressChanged += Downloader_ChangeProgress;

// initialize LiteLoader installer
var liteLoaderVersionLoader = new LiteLoaderVersionLoader();
var liteLoaderVersions = await liteLoaderVersionLoader.GetVersionMetadatasAsync();

// LiteLoader 모든 버전 출력
foreach (var item in liteLoaderVersions)
{
    Console.WriteLine(item);
}

Console.WriteLine("LiteLoader 버전을 선택하세요 (ex: LiteLoader1.12.2) : ");
var selectLiteLoaderVersion = Console.ReadLine();

// 모든 게임 버전 출력
var versions = await launcher.GetAllVersionsAsync();
foreach (var item in versions)
{
    Console.WriteLine(item);
}

Console.WriteLine("설치할 마인크래프트 버전을 선택하세요 : ");
var selectGameVersion = Console.ReadLine();

if (string.IsNullOrEmpty(selectLiteLoaderVersion) || string.IsNullOrEmpty(selectGameVersion))
    return;

// install LiteLoader
var liteLoader =
    (LiteLoaderVersionMetadata)liteLoaderVersions.GetVersionMetadata(selectLiteLoaderVersion);
var startVersionName = liteLoader.Install(path, await versions.GetVersionAsync(selectGameVersion));

// update version list
await launcher.GetAllVersionsAsync();

// start
var process = await launcher.CreateProcessAsync(startVersionName, new MLaunchOption());

process.Start();
```