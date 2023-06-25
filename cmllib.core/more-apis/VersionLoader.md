---
description: Get version metadata list
---

# VersionLoader

All VersionLoader should inherit `IVersionLoader`.\
There are 3 version loaders, and you can make your own version loader.\
VersionLoader return version metadata list as `MVersionCollection` type.

`LocalVersionLoader`: Get version metadata list from `MinecraftPath.Versions` directory.\
`MojangVersionLoader`: Get version metadata list from mojang metadata server.

`DefaultVersionLoader`: Get version metadatas using `LocalVersionLoader` and `MojangVersionLoader`, and merge two lists.

## Example

```csharp
var launcher = new CMLauncher(new MinecraftPath());

// CMLauncher class create DefaultVersionLoader instance automatically
// MVersionCollection versions = launcher.VersionLoader.GetVersionMetadatasAsync();
MVersionCollection versions = await launcher.GetAllVersionsAsync(); // shortcut

// show all versions
foreach (MVersionMetadata ver in versions)
{
    Console.WriteLine(ver.Type + " : " ver.Name);
}

// Get latest release version name:
Console.WriteLine(versions.LatestReleaseVersion.Name);

// Get latest snapshot version name:
Console.WriteLine(versions.LatestSnapshotVersion.Name);

// Get MVersion
MVersion realVersion = versions.GetVersion("1.15.2");
```

## IVersionLoader interface

#### Task GetVersionMetadatasAsync();

Get version metadata list.

#### MVersionCollection GetVersionMetadatas();

Get version metadata list.

## LocalVersionLoader class

Get version metadata list from `MinecraftPath.Versions` directory.\
Inherit `IVersionLoader`.

### Constructors

#### public LocalVersionLoader(MinecraftPath path)

Set path to load versions.

## MojangVersionLoader class

Get version metadata list from mojang version metadata server.\
Inherit `IVersionLoader`.

## DefaultVersionLoader class

Get version metadata list using `LocalVersionLoader` and `MojangVersionLoader`, and merge two lists.

### Constructors

#### public DefaultVersionLoader(MinecraftPath path)

Set path to load local versions.

## MVersionCollection class

Manage MVersionMetadata lists.

### Properties

#### LatestReleaseVersion

_Type: MVersionMetadata_

#### LatestSnapshotVersion

_Type: MVersionMetadata_

### Methods

#### public MVersion GetVersion(string name)

Find MVersionMetadata named `name`, parse that version metadata to `MVersion`, and return it.

#### public MVersion GetVersion(MVersionMetadata versionMetadata)

Find `versionMetadata`, parse that version metadata to `MVersion`, and return it.

#### public void Merge(MVersionCollection from)

Merge two version collections.\
Remove duplications, change `LatestReleaseVersion`, `LatestSnapshotVersion` properties.
