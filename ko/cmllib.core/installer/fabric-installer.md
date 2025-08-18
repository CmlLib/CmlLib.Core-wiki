---
description: Install Fabric mod loader
---

# Fabric Installer

## Minecraft 버전 가져오기

```csharp
var fabricInstaller = new FabricInstaller(new HttpClient());
var versions = await fabricInstaller.GetSupportedVersionNames();

foreach (var version in versions)
{
    Console.WriteLine(version);
}
```

### Fabric 버전 가져오기

```csharp
var fabricInstaller = new FabricInstaller(new HttpClient());
var versions = await fabricInstaller.GetLoaders("1.20.6");

foreach (var version in versions)
{
    Console.WriteLine(version.Version);
}
```

### 설치

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);

var fabricInstaller = new FabricInstaller(new HttpClient());

// 1.20.4 의 최신 fabric 버전 설치
var versionName = await fabricInstaller.Install("1.20.4", path);

// 1.20.4 의 설정한 fabric 버전 설치
var versionName = await fabricInstaller.Install("1.20.4", "0.16.0", path);
```
