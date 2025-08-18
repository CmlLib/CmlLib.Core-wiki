---
description: Quilt 모드 로더 설치
---

# Quilt Installer

## Minecraft 버전 가져오기

```csharp
var quiltInstaller = new QuiltInstaller(new HttpClient());
var versions = await quiltInstaller.GetSupportedVersionNames();

foreach (var version in versions)
{
    Console.WriteLine(version);
}
```

### Quilt 버전 가져오기

```csharp
var quiltInstaller = new QuiltInstaller(new HttpClient());
var versions = await quiltInstaller.GetLoaders("1.20.6");

foreach (var version in versions)
{
    Console.WriteLine(version.Version);
}
```

### 설치

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);

var quiltInstaller = new QuiltInstaller(new HttpClient());

// install the latest quilt loader for 1.20.4
var versionName = await quiltInstaller.Install("1.20.4", path);

// install the specific quilt loader
var versionName = await quiltInstaller.Install("1.20.4", "0.16.0", path);
```
