# Getting Started

## Install

Install nuget package [CmlLib.Core.Installer.NeoForge](https://www.nuget.org/packages/CmlLib.Core.Installer.NeoForge)

```
dotnet add package CmlLib.Core.Installer.NeoForge
```

## Example

```csharp
using CmlLib.Core;
using CmlLib.Core.Auth;
using CmlLib.Core.Installer.NeoForge;
using CmlLib.Core.Installer.NeoForge.Installers;
using CmlLib.Core.Installers;
using CmlLib.Core.ProcessBuilder;

var path = new MinecraftPath(); // use default directory
var launcher = new MinecraftLauncher(path);

// show launch progress to console
var fileProgress = new SyncProgress<InstallerProgressChangedEventArgs>(e =>
    Console.WriteLine($"[{e.EventType}][{e.ProgressedTasks}/{e.TotalTasks}] {e.Name}"));
var byteProgress = new SyncProgress<ByteProgress>(e =>
    Console.WriteLine(e.ToRatio() * 100 + "%"));
var installerOutput = new SyncProgress<string>(e =>
    Console.WriteLine(e));

//Initialize variables with the Minecraft version and the Forge version
var mcVersion = "1.21.10";
var forgeVersion = "21.10.2-beta";

//Initialize MForge
var forge = new NeoForgeInstaller(launcher);

var version_name = await forge.Install(mcVersion, forgeVersion, new NeoForgeInstallOptions
{
    FileProgress = fileProgress,
    ByteProgress = byteProgress,
    InstallerOutput = installerOutput,
});

//Start Minecraft
var launchOption = new MLaunchOption
{
    MaximumRamMb = 1024,
    Session = MSession.CreateOfflineSession("GamerVII"),
};

var process = await launcher.CreateProcessAsync(version_name, launchOption);

// print game logs
var processUtil = new ProcessWrapper(process);
processUtil.OutputReceived += (s, e) => Console.WriteLine(e);
processUtil.StartWithEvents();
await processUtil.WaitForExitTaskAsync();
```

## Sample Installer

[SampleForgeInstaller](https://github.com/Gml-Launcher/CmlLib.Core.Installer.NeoForge/blob/master/SampleNeoForgeInstaller/Program.cs)

## API Reference

- [ForgeInstaller](https://cmllib.github.io/CmlLib.Core.Installer.Forge/api/CmlLib.Core.Installer.Forge.ForgeInstaller.html)
- [ForgeInstallOptions](https://cmllib.github.io/CmlLib.Core.Installer.Forge/api/CmlLib.Core.Installer.Forge.ForgeInstallOptions.html)