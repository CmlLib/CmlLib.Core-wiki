# MinecraftPath

Represents minecraft directory path and structure.

## Default directory path

You can get default game directory path using `MinecraftPath.GetOSDefaultPath()`, or create new instance of `MinecraftPath` without any arguments.

- Windows: %appdata%\.minecraft
- Linux: $HOME/.minecraft
- macOS: $HOME/Library/Application Support/minecraft

## Default directory structure

```
Root directory : BasePath
 | - assets : Assets
 |    | - indexes
 |    |    | - {asset id}.json : GetIndexFilePath(assetId)
 |    | - objects : GetAssetObjectPath(assetId)
 |    | - virtual
 |         | - legacy : GetAssetLegacyPath(assetId)
 |
 | - libraries : Library
 | - resources : Resource
 | - runtime : Runtime
 | - versions : Versions
      | - {version name}
            | - {version name}.jar : GetVersionJarPath(id)
            | - {version name}.json : GetVersionJsonPath(id)
            | - natives : GetNativePath(id)
```

## Example

This example shows creating default directory structure with specific game path.

```csharp
// create default path
MinecraftPath defaultPath = new MinecraftPath();

// windows: %appdata%\.minecraft
// linux: $HOME/.minecraft
// mac: $HOME/Library/Application Support/minecraft

// create instance with the specific path
// root directory (myPath.BasePath): ./games
MinecraftPath myPath = new MinecraftPath("./games");

// myPath.BasePath : ./games
// myPath.Library : ./games/libraries
// myPath.Resource : ./games/resources
// myPath.Versions : ./games/versions
// myPath.GetVersionJarPath("1.16.5") : ./games/versions/1.16.5/1.16.5.jar
// myPath.GetIndexFilePath("1.16.5") : ./games/assets/indexes/1.16.5.json
```

**Note** : all paths are converted to absolute path.

## Make custom directory structure

There are two ways to make custom directory structure.  
Choose what you need.

### Set properties

Set path properties to what you want.

```csharp
MinecraftPath myPath = new MinecraftPath();
myPath.Libraries = "./commons/libs";
myPath.Versions = "./commons/versions";
myPath.Assets = MinecraftPath.GetOSDefaultPath() + "/assets";
```

### Inheritence

Create derived class of `MinecraftPath`, and override methods.  
Each methods (`CreateDirs`, `NormalizePath`, etc) are described [below](#Methods).

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
        => NormalizePath($"{Versions}/{id}/client.jar");
    
    public override string GetVersionJsonPath(string id)
        => NormalizePath($"{Versions}/{id}/client.json");

    public override string GetAssetObjectPath(string assetId)
        => NormalizePath($"{Assets}/files");
}
```

### Properties

#### BasePath

*Type: string*

Root directory path

#### Assets

*Type: string*

#### Library

*Type: string*

#### Versions

*Type: string*

#### Runtime

*Type: string*

The default download path of `MJava`

#### Resource

*Type: string*

Old minecraft versions use this path as Assets directory.

### Constructors

#### public MinecraftPath()

Initialize instance with default path.  
Same as `new MinecraftPath(MinecraftPath.GetOSDefaultPath())`.

#### public MinecraftPath(string p)

Initializze instance with the specific path, `p`.  
Call `Initialize(p)` and `CreateDirs()`.

### Methods

#### public void CreateDirs()

Create `BasePath`, `Assets`, `Library`, `Versions`, `Runtime`, `Resouce` directory.

#### public virtual string GetIndexFilePath(string assetId)

Get asset index file path.

#### public virtual string GetAssetObjectPath(string assetId)

Get asset object directory path.

#### public virtual string GetAssetLegacyPath(string assetId)

Get asset legacy directory path.

#### public virtual string GetVersionJarPath(string id)

Get client jar path.

#### public virtual string GetVersionJsonPath(string id)

Get client json path.

#### public virtual string GetNativePath(string id)

Get native directory path.  
Native dll files will be stored here.

#### protected static string Dir(string path)

Normalize `path` and create directory.

#### protected static string NormalizePath(string path)

Normalize `path`. Convert relative path to absolute path and replace invalid directory separator. (In windows, replace `/` to `\`)