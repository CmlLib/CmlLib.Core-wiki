---
description: Install Fabric mod loader
---

# Fabric Installer

### Get Minecraft versions

```csharp
var fabricInstaller = new FabricInstaller(new HttpClient());
var versions = await fabricInstaller.GetSupportedVersionNames();

foreach (var version in versions)
{
    Console.WriteLine(version);
}
```

### Get Fabric versions

```csharp
var fabricInstaller = new FabricInstaller(new HttpClient());
var versions = await fabricInstaller.GetLoaders("1.20.6");

foreach (var version in versions)
{
    Console.WriteLine(version.Version);
}
```

### Install

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);

var fabricInstaller = new FabricInstaller(new HttpClient());

// install the latest fabric loader for 1.20.4
var versionName = await fabricInstaller.Install("1.20.4", path);

// install the specific fabric loader
var versionName = await fabricInstaller.Install("1.20.4", "0.16.0", path);
```
