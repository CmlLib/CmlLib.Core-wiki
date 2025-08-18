---
description: Mod Loader File Extraction
---

# Mod Loader File Extraction

You can extract files from any type of client including Forge, Fabric, and automate installation.

!!! danger "Copyright Warning"
    **Extracted files may contain copyrighted content. Distributing these files may violate Minecraft EULA or related laws. Please verify before distribution.**

## Extraction Method

1. Delete `.minecraft` directory
2. Launch vanilla version of the version you want to extract using Mojang launcher and exit (e.g., to extract 1.7.10 forge, first run vanilla 1.7.10)
3. Install the mod loader in `.minecraft`
4. Launch the installed mod loader using Mojang launcher and exit
5. Copy `libraries` directory and `versions/<version name>` directory from `.minecraft`. These two directories are the extracted files.

Example: 1.21.4-forge-54.1.0

```
/
├── libraries/
│   ├── org/
│   ├── net/
│   └── ...
└── versions/
    └── 1.21.4-forge-54.1.0/
        └── 1.21.4-forge-54.1.0.json
```

!!! danger "JAR File Warning"
    If `versions/<version name>/<version name>.jar` file exists, **please verify before distribution!**

    * In most cases, CmlLib will install this file from Mojang's official distribution server even if it's missing.
    * If distribution is necessary, **verify that you are not violating Minecraft EULA or copyright laws.**

## Distribution and Installation

Distribute the extracted files with your launcher. There are several distribution methods:

* Upload extracted files to your own file server
* Embed extracted files into launcher executable using EmbeddedResource

Implement code to copy or download distributed files to the game directory for installation.

## Launching

After loading versions, the installed version names will be displayed. Launch the game using the version name. See [Minecraft Launcher](../getting-started/CMLauncher.md)

```csharp
var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine(v.Name);
}

// Example: when installed version is 1.21.4-forge-54.1.0

await launcher.InstallAsync("1.21.4-forge-54.1.0");
var process = await launcher.BuildProcessAsync("1.21.4-forge-54.1.0", new MLaunchOption
{
    Session = MSession.CreateOfflineSession("Gamer123"),
    MaximumRamMb = 4096
});
process.Start();
```

Since extracted files are usually incomplete, always call `InstallAsync` to ensure all missing files are installed.
