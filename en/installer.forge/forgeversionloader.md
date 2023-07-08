---
description: Get Forge version list
---

# ForgeVersionLoader

Print all Forge versions of `1.20.1:`

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

Install recommended forge version of `1.20.1`.

```csharp
var versionLoader = new ForgeVersionLoader(new HttpClient());
var versions = await versionLoader.GetForgeVersions("1.20.1");
var recommendedVersion = versions.First(v => v.IsRecommendedVersion);

var forge = new MForge(launcher);
// ~~~ event handlers ~~~
await forge.Install(recommendedVersion.MinecraftVersionName, recommendedVersion.ForgeVersionName);
// ~~~ launch codes ~~~
```
