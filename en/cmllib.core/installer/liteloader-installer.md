---
description: Install LiteLoader
---

# LiteLoader Installer

## Get all versions

```csharp
var liteLoaderInstaller = new LiteLoaderInstaller(new HttpClient());
var loaders = await liteLoaderInstaller.GetAllLiteLoaders();

foreach (var loader in loaders)
{
    Console.WriteLine($"GameVersion: {loader.BaseVersion}, LoaderVersion: {loader.Version}");
}
```

### Install (1.7.10)

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);
var version = "1.7.10";

var liteLoaderInstaller = new LiteLoaderInstaller(new HttpClient());
var loaders = await liteLoaderInstaller.GetAllLiteLoaders();
var loaderToInstall = loaders.First(loader => loader.BaseVersion == version);

var installedVersion = await liteLoaderInstaller.Install(
    loaderToInstall, 
    await launcher.GetVersionAsync(version), 
    path);
```
