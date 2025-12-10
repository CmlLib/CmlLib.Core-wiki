---
description: Install Quilt mod loader
---

# Quilt Installer

{% hint style="warning" %}
**This document is outdated!** The latest documentation has moved to [here](https://cmllib.github.io/CmlLib.Core-wiki/en/).
{% endhint %}

### Get Minecraft versions

```csharp
var quiltInstaller = new QuiltInstaller(new HttpClient());
var versions = await quiltInstaller.GetSupportedVersionNames();

foreach (var version in versions)
{
    Console.WriteLine(version);
}
```

### Get Quilt versions

```csharp
var quiltInstaller = new QuiltInstaller(new HttpClient());
var versions = await quiltInstaller.GetLoaders("1.20.6");

foreach (var version in versions)
{
    Console.WriteLine(version.Version);
}
```

### Install

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);

var quiltInstaller = new QuiltInstaller(new HttpClient());

// install the latest quilt loader for 1.20.4
var versionName = await quiltInstaller.Install("1.20.4", path);

// install the specific quilt loader
var versionName = await quiltInstaller.Install("1.20.4", "0.16.0", path);
```
