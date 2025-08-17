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
Root directory : MinecraftPath.BasePath
 | - assets : MinecraftPath.Assets
 |    | - indexes
 |    |    | - {asset id}.json : MinecraftPath.GetIndexFilePath(assetId)
 |    | - objects : MinecraftPath.GetAssetObjectPath(assetId)
 |    | - virtual
 |         | - legacy : MinecraftPath.GetAssetLegacyPath(assetId)
 |
 | - libraries : MinecraftPath.Library
 | - resources : MinecraftPath.Resource
 | - runtime : MinecraftPath.Runtime
 | - versions : MinecraftPath.Versions
      | - {version name}
            | - {version name}.jar : MinecraftPath.GetVersionJarPath("version_name")
            | - {version name}.json : MinecraftPath.GetVersionJsonPath("version_name")
            | - natives : MinecraftPath.GetNativePath("version_name")
```

## Make custom directory structure

There are two ways to make custom directory structure.

!!! info "Information"
    All paths are stored as absolute paths, even when a relative path is passed.

### Set properties

Set path properties to what you want. All properties (`Libraries`, `Versions`, etc) are described in [Properties](#properties)

```csharp
MinecraftPath myPath = new MinecraftPath();
myPath.Libraries = "./commons/libs";
myPath.Versions = "./commons/versions";
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

### Constructors

??? abstract "Constructors"

    **public MinecraftPath()**

    Initialize instance with default path.  
    Same as `new MinecraftPath(MinecraftPath.GetOSDefaultPath())`.

    **public MinecraftPath(string p)**

    Initialize instance with the specific path, `p`.  
    Call `Initialize(p)` and `CreateDirs()`.

### Properties

??? abstract "Properties"

    **BasePath**

    *Type: string*

    Root directory path

    **Assets**

    *Type: string*

    **Library**

    *Type: string*

    **Versions**

    *Type: string*

    **Runtime**

    *Type: string*

    The default download path of `MJava`

    **Resource**

    *Type: string*

    Old minecraft versions use this path as Assets directory.

### Methods

??? abstract "Methods"

    **public void CreateDirs()**

    Create `BasePath`, `Assets`, `Library`, `Versions`, `Runtime`, `Resource` directory.

    **public virtual string GetIndexFilePath(string assetId)**

    Get asset index file path.

    **public virtual string GetAssetObjectPath(string assetId)**

    Get asset object directory path.

    **public virtual string GetAssetLegacyPath(string assetId)**

    Get asset legacy directory path.

    **public virtual string GetVersionJarPath(string id)**

    Get client jar path.

    **public virtual string GetVersionJsonPath(string id)**

    Get client json path.

    **public virtual string GetNativePath(string id)**

    Get native directory path.  
    Native dll files will be stored here.

    **protected static string Dir(string path)**

    Normalize `path` and create directory.

    **protected static string NormalizePath(string path)**

    Normalize `path`. Convert relative path to absolute path and replace invalid directory separator. (In windows, replace `/` to `\`)
