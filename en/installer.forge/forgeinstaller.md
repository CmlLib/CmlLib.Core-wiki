# ForgeInstaller

ForgeInstaller provides functionality to download and install Forge versions for Minecraft.

## Initializing the Installer

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);
var forgeInstaller = new ForgeInstaller(launcher);
```

Optionally, you can configure the HttpClient used to access the Forge website by using `new ForgeInstaller(launcher, new HttpClient())`.

## Listing Available Versions

```csharp
var versions = await forgeInstaller.GetForgeVersions("1.20.1");
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

This retrieves all available Forge versions that can be installed for the specified Minecraft version.

## Installation

### Installing the Best Version

```csharp
var installedVersionName = await forgeInstaller.Install("1.20.1", new ForgeInstallOptions());
```

This finds and installs the most appropriate Forge version available for Minecraft 1.20.1.

The appropriate version is selected using the following priority rules:

1. First version with the 'Recommended Version' flag
2. First version with the 'Latest Version' flag
3. The topmost version in the version list

### Installing a Specific Version

```csharp
var installedVersionName = await forgeInstaller.Install("1.20.1", "47.1.0", new ForgeInstallOptions());
```

This installs Forge version 47.1.0 for Minecraft 1.20.1.

### Installing the Latest Version

```csharp
var versions = await forgeInstaller.GetForgeVersions("1.20.1");
var latestVersion = versions.First(v => v.IsLatestVersion);
var installedVersionName = await forgeInstaller.Install(latestVersion, new ForgeInstallOptions());
```

This finds and installs the latest Forge version available for Minecraft 1.20.1.

## Installation Options

To use features like installation progress display and cancellation, configure the appropriate values in `ForgeInstallOptions`.

```csharp
var installOptions = new ForgeInstallOptions
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
var installedVersionName = await forgeInstaller.Install("1.20.1", installOptions);
```

- **FileProgress** and **ByteProgress**: Report file download progress. See [Event Handling](../cmllib.core/getting-started/Handling-Events.md) for more details.
- **InstallerOutput**: Reports logs output from the installer's console.
- **CancellationToken**: Allows you to cancel the installation process.
- **JavaPath**: Sets the path to the Java runtime used to execute the installer. The default value is `null`, which automatically determines the Java runtime path.
- **SkipIfAlreadyInstalled**: When set to `true`, skips installation if the target version is already installed. The default value is `true`.

## Important Note About Complete Installation

`forgeInstaller.Install` does not fully install the Forge version. The version still needs additional files such as sound assets, Java runtime, and vanilla version files. Therefore, you should always call `launcher.InstallAsync` before launching the game.

```csharp
// Install Forge
var versionName = await forgeInstaller.Install("1.20.1", new ForgeInstallOptions());

// Install remaining dependencies (sound assets, Java runtime, vanilla version)
await launcher.InstallAsync(versionName);

// Launch the game
var process = await launcher.BuildProcessAsync(versionName, new MLaunchOption
{
    MaximumRamMb = 1024,
    Session = MSession.CreateOfflineSession("Gamer123"),
});
process.Start();
```

## About Ads

`ForgeInstaller` will display an ad page after a successful installation. The official Forge installer shows the following message:

```
Please do not automate the download and installation of Forge.
Our efforts are supported by ads from the download page.
If you MUST automate this, please consider supporting the project through https://www.patreon.com/LexManos
```

If you want to disable this behavior, you can modify the [ForgeInstaller source code](https://github.com/CmlLib/CmlLib.Core.Installer.Forge/blob/main/CmlLib.Core.Installer.Forge/ForgeInstaller.cs) yourself.