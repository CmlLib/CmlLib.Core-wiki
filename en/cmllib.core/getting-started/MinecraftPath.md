---
description: Represents minecraft directory path and structure.
---

# Minecraft Path

You can customize Minecraft game directory path and structure where all game files is stored.

## Example

Initialize `MinecraftLauncher` with custom Minecraft path and default directory structure.

```csharp
// initialize launcher with the specific path
MinecraftPath myPath = new MinecraftPath("./games");
MinecraftLauncher launcher = new MinecraftLauncher(myPath);

// myPath.BasePath : ./games
// myPath.Library : ./games/libraries
// myPath.Resource : ./games/resources
// myPath.Versions : ./games/versions
// myPath.GetVersionJarPath("1.16.5") : ./games/versions/1.16.5/1.16.5.jar
// myPath.GetIndexFilePath("1.16.5") : ./games/assets/indexes/1.16.5.json
```

## Default directory path

You can get default game directory path using `MinecraftPath.GetOSDefaultPath()`, or create new instance of `MinecraftPath` without any arguments.

Default Minecraft path is:

* Windows: `%appdata%\.minecraft`
* Linux: `$HOME/.minecraft`
* macOS: `$HOME/Library/Application Support/minecraft`

## Default directory structure

```
/ (MinecraftPath.BasePath)
├── assets/ (MinecraftPath.Assets)
│   ├── indexes/
│   │   └── {asset_id}.json (MinecraftPath.GetIndexFilePath(assetId))
│   ├── objects/ (MinecraftPath.GetAssetObjectPath(assetId))
│   └── virtual/
│       └── legacy/ (MinecraftPath.GetAssetLegacyPath(assetId))
├── libraries/ (MinecraftPath.Library)
├── resources/ (MinecraftPath.Resource)
├── runtime/ (MinecraftPath.Runtime)
└── versions/ (MinecraftPath.Versions)
    └── {version_name}/
        ├── {version_name}.jar (MinecraftPath.GetVersionJarPath("version_name"))
        ├── {version_name}.json (MinecraftPath.GetVersionJsonPath("version_name"))
        └── natives/ (MinecraftPath.GetNativePath("version_name"))
```

## Make custom directory structure

There are two ways to make custom directory structure.

### Set properties

Set path properties to what you want. All properties are described in [Properties](#properties)

!!! info "Information"
    Make sure to use absolute paths only.

```csharp
MinecraftPath myPath = new MinecraftPath();
myPath.Libraries = myPath.BasePath + "/commons/libs";
myPath.Versions = myPath.BasePath + "/commons/versions";
myPath.Assets = MinecraftPath.GetOSDefaultPath() + "/assets";
```

### Inheritence

!!! info "Information"
    When receiving a relative path as an argument, make sure to convert it to an absolute path and store it.

Create derived class of `MinecraftPath`, and override methods. Each methods (`CreateDirs`, `NormalizePath`, etc) are described in [Methods](#methods).

```csharp
class MyMinecraftPath : MinecraftPath
{
    public MyMinecraftPath(string p)
    {
        BasePath = NormalizePath(p);

        Library = NormalizePath(BasePath + "/libs");
        Versions = NormalizePath(BasePath + "/vers");
        Resource = NormalizePath(BasePath + "/resources");

        Runtime = NormalizePath(BasePath + "/java");
        Assets = NormalizePath(BasePath + "/assets");

        CreateDirs();
    }

    public override string GetVersionJarPath(string id)
        => NormalizePath($"{Versions}/{id}/{id}.jar");

    public override string GetVersionJsonPath(string id)
        => NormalizePath($"{Versions}/{id}/{id}.json");

    public override string GetNativePath(string id)
        => NormalizePath($"{Versions}/{id}/natives");
    
    // NOTE: Minecraft may not recognize the changed path
    public override string GetIndexFilePath(string assetId)
        => NormalizePath($"{Assets}/indexes/{assetId}.json");

    // NOTE: Minecraft may not recognize the changed path
    public override string GetAssetObjectPath(string assetId)
        => NormalizePath($"{Assets}/objects");

    // NOTE: Minecraft may not recognize the changed path
    public override string GetAssetLegacyPath(string assetId)
        => NormalizePath($"{Assets}/virtual/legacy");

    // NOTE: Minecraft may not recognize the changed path
    public override string GetLogConfigFilePath(string configId)
        => NormalizePath($"{Assets}/log_configs/{configId}" + (!configId.EndsWith(".xml") ? ".xml" : ""));
}
```

## API References

- CmlLib.Core.Commons