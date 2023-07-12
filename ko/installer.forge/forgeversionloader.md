---
description: 포지 버전 목록 가져오기
---

# ForgeVersionLoader

`1.20.1` 모든 포지 버전 출력

```csharp

var versionLoader = new ForgeVersionLoader(new HttpClient());
var versions = await versionLoader.GetForgeVersions("1.20.1");

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

recommended `1.20.1` 포지 버전을 설치합니다. 

```csharp
var versionLoader = new ForgeVersionLoader(new HttpClient());
var versions = await versionLoader.GetForgeVersions("1.20.1");
var recommendedVersion = versions.First(v => v.IsRecommendedVersion);

var forge = new MForge(launcher);
// ~~~ 이벤트 헨들러 ~~~
await forge.Install(recommendedVersion.MinecraftVersionName, recommendedVersion.ForgeVersionName);
// ~~~ 실행 코드 ~~~
```
