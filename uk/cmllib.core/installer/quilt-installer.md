---
description: Встановлення завантажувача модів Quilt
---

# Інсталятор Quilt

## Отримання версій Minecraft

```csharp
var quiltInstaller = new QuiltInstaller(new HttpClient());
var versions = await quiltInstaller.GetSupportedVersionNames();

foreach (var version in versions)
{
    Console.WriteLine(version);
}
```

### Отримання версій Quilt

```csharp
var quiltInstaller = new QuiltInstaller(new HttpClient());
var versions = await quiltInstaller.GetLoaders("1.20.6");

foreach (var version in versions)
{
    Console.WriteLine(version.Version);
}
```

### Встановлення

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);

var quiltInstaller = new QuiltInstaller(new HttpClient());

// встановлення найновішої версії Quilt Loader для 1.20.4
var versionName = await quiltInstaller.Install("1.20.4", path);

// встановлення конкретної версії Quilt Loader
var versionName = await quiltInstaller.Install("1.20.4", "0.16.0", path);
```
