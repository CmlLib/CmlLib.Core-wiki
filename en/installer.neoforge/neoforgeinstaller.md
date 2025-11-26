# NeoForgeInstaller

NeoForgeInstaller provides functionality to download and install NeoForge versions for Minecraft.

## Initializing the Installer

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);
var neoForgeInstaller = new NeoForgeInstaller(launcher);
```

Optionally, you can configure the HttpClient used to access the NeoForge website by using `new NeoForgeInstaller(launcher, new HttpClient())`.

## Listing Available Versions

```csharp
var versions = await neoForgeInstaller.GetForgeVersions("1.21.10");
foreach (var version in versions)
{
    Console.WriteLine();
    Console.WriteLine("MinecraftVersion: " + version.MinecraftVersion);
    Console.WriteLine("VersionName: " + version.VersionName);

    var installerFile = version.GetInstallerFile();
    if (installerFile != null)
    {
        Console.WriteLine("DirectUrl: " + installerFile.DirectUrl);
    }
}
```

This retrieves all available NeoForge versions that can be installed for the specified Minecraft version.

## Installation

### Installing the Best Version

```csharp
var installedVersionName = await neoForgeInstaller.Install("1.21.10", new NeoForgeInstallOptions());
```

This finds and installs the most appropriate NeoForge version available for Minecraft 1.21.10.

The appropriate version is selected using the following priority rules:

1. First version with the 'Recommended Version' flag
2. First version with the 'Latest Version' flag
3. The topmost version in the version list

### Installing a Specific Version

```csharp
var installedVersionName = await neoForgeInstaller.Install("1.21.10", "21.10.56-beta", new NeoForgeInstallOptions());
```

This installs NeoForge version 21.10.56-beta for Minecraft 1.21.10.

### Installing the Latest Version

```csharp
var versions = await neoForgeInstaller.GetForgeVersions("1.21.10");
var latestVersion = versions.First();
var installedVersionName = await neoForgeInstaller.Install(latestVersion, new NeoForgeInstallOptions());
```

This finds and installs the latest NeoForge version available for Minecraft 1.21.10.

## Installation Options

To use features like installation progress display and cancellation, configure the appropriate values in `ForgeInstallOptions`.

```csharp
var installOptions = new NeoForgeInstallOptions
{
    FileProgress = new Progress<InstallerProgressChangedEventArgs>(e =>
        Console.WriteLine($"[{e.EventType}][{e.ProgressedTasks}/{e.TotalTasks}] {e.Name}")),
    ByteProgress = new Progress<ByteProgress>(e =>
        Console.WriteLine(e.ToRatio() * 100 + "%")),
    InstallerOutput = new Progress<string>(e =>
        Console.WriteLine(e)),
    CancellationToken = CancellationToken.None,

    JavaPath = "java.exe",
    SkipIfAlreadyInstalled = true,
};
var installedVersionName = await neoForgeInstaller.Install("1.21.10", installOptions);
```

- **FileProgress** and **ByteProgress**: Report file download progress. See [Event Handling](../cmllib.core/getting-started/Handling-Events.md) for more details.
- **InstallerOutput**: Reports logs output from the installer's console.
- **CancellationToken**: Allows you to cancel the installation process.
- **JavaPath**: Sets the path to the Java runtime used to execute the installer. The default value is `null`, which automatically determines the Java runtime path.
- **SkipIfAlreadyInstalled**: When set to `true`, skips installation if the target version is already installed. The default value is `true`.

## Important Note About Complete Installation

`forgeInstaller.Install` does not fully install the NeoForge version. The version still needs additional files such as sound assets, Java runtime, and vanilla version files. Therefore, you should always call `launcher.InstallAsync` before launching the game.

```csharp
// Install NeoForge
var versionName = await neoForgeInstaller.Install("1.21.10", new NeoForgeInstallOptions());

// Install remaining dependencies (sound assets, Java runtime, vanilla version)
await launcher.InstallAsync(versionName);

// Launch the game
var process = await launcher.BuildProcessAsync(versionName, new MLaunchOption
{
    MaximumRamMb = 1024,
    Session = MSession.CreateOfflineSession("GamerVII"),
});
process.Start();
```