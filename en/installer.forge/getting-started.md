# Getting Started

## Install

Install nuget package [CmlLib.Core.Installer.Forge](https://www.nuget.org/packages/CmlLib.Core.Installer.Forge).

## Example

```csharp
﻿using CmlLib.Core.Installer.Forge;
using CmlLib.Core;
using CmlLib.Core.Auth;
using CmlLib.Core.Downloader;
using System.ComponentModel;
using CmlLib.Utils;

// show launch progress to console
void fileChanged(DownloadFileChangedEventArgs e)
{
    Console.WriteLine($"[{e.FileKind.ToString()}] {e.FileName} - {e.ProgressedFileCount}/{e.TotalFileCount}");
}
void progressChanged(object? sender, ProgressChangedEventArgs e)
{
    Console.WriteLine($"{e.ProgressPercentage}%");
}

// Initialize CMLauncher
var path = new MinecraftPath(); // use default directory
var launcher = new CMLauncher(path);
launcher.FileChanged += fileChanged;
launcher.ProgressChanged += progressChanged;

//Initialize MForge
var forge = new MForge(launcher);
forge.FileChanged += fileChanged;
forge.ProgressChanged += progressChanged;
forge.InstallerOutput += (s, e) => Console.WriteLine(e);

// Install the best forge for specific minecraft version
var versionName = await forge.Install("1.20.1");

// Install with specific forge version
// var versionName = await forge.Install("1.20.1", "47.0.35");

//Start Minecraft
var launchOption = new MLaunchOption
{
    MaximumRamMb = 1024,
    Session = MSession.GetOfflineSession("TaiogStudio"),
};

var process = await launcher.CreateProcessAsync(versionName, launchOption);
process.Start();
```

## Sample Installer

[SampleForgeInstaller](https://github.com/CmlLib/CmlLib.Core.Installer.Forge/blob/main/SampleForgeInstaller/Program.cs)
