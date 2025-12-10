---
description: Install LiteLoader
---

# LiteLoader Installer

{% hint style="warning" %}
**This document is outdated!** The latest documentation has moved to [here](https://cmllib.github.io/CmlLib.Core-wiki/en/).
{% endhint %}

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
