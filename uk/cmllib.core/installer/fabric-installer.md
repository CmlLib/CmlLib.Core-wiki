---
description: Встановлення завантажувача модів Fabric
---

# Інсталятор Fabric

### Отримання версій Minecraft

```csharp
var fabricInstaller = new FabricInstaller(new HttpClient());
var versions = await fabricInstaller.GetSupportedVersionNames();

foreach (var version in versions)
{
    Console.WriteLine(version);
}
```

### Отримання версій Fabric

```csharp
var fabricInstaller = new FabricInstaller(new HttpClient());
var versions = await fabricInstaller.GetLoaders("1.20.6");

foreach (var version in versions)
{
    Console.WriteLine(version.Version);
}
```

### Встановлення

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);

var fabricInstaller = new FabricInstaller(new HttpClient());

// встановлення найновішої версії Fabric Loader для 1.20.4
var versionName = await fabricInstaller.Install("1.20.4", path);

// встановлення конкретної версії Fabric Loader
var versionName = await fabricInstaller.Install("1.20.4", "0.16.0", path);
```
