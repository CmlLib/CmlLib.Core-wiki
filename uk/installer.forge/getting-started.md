# Перші кроки

## Встановлення

Встановіть NuGet-пакет [CmlLib.Core.Installer.Forge](https://www.nuget.org/packages/CmlLib.Core.Installer.Forge)

```
dotnet add package CmlLib.Core.Installer.Forge
```

## Приклад

```csharp
using CmlLib.Core;
using CmlLib.Core.Auth;
using CmlLib.Core.Installer.Forge;
using CmlLib.Core.Installers;
using CmlLib.Core.ProcessBuilder;

var path = new MinecraftPath(); // використання директорії за замовчуванням
var launcher = new MinecraftLauncher(path);
var forgeInstaller = new ForgeInstaller(launcher);

var fileProgress = new Progress<InstallerProgressChangedEventArgs>(e =>
        Console.WriteLine($"[{e.EventType}][{e.ProgressedTasks}/{e.TotalTasks}] {e.Name}"));
var byteProgress = new Progress<ByteProgress>(e =>
        Console.WriteLine(e.ToRatio() * 100 + "%"));

// встановлення forge
// вивід прогресу в консоль
var versionName = await forgeInstaller.Install("1.20.1", new ForgeInstallOptions
{
    FileProgress = fileProgress,
    ByteProgress = byteProgress,
    InstallerOutput = new Progress<string>(e =>
        Console.WriteLine(e)),
});

// ForgeInstaller не встановлює версію повністю, вам все одно потрібно викликати InstallAsync
await launcher.InstallAsync(versionName, fileProgress, byteProgress);
var process = await launcher.BuildProcessAsync(versionName, new MLaunchOption
{
    MaximumRamMb = 1024,
    Session = MSession.CreateOfflineSession("Gamer123"),
});

// вивід логів гри
var processUtil = new ProcessWrapper(process);
processUtil.OutputReceived += (s, e) => Console.WriteLine(e);
processUtil.StartWithEvents();
await processUtil.WaitForExitTaskAsync();
```

## Приклад інсталятора

[SampleForgeInstaller](https://github.com/CmlLib/CmlLib.Core.Installer.Forge/blob/main/SampleForgeInstaller/Program.cs)

## Довідник API

- [ForgeInstaller](https://cmllib.github.io/CmlLib.Core.Installer.Forge/api/CmlLib.Core.Installer.Forge.ForgeInstaller.html)
- [ForgeInstallOptions](https://cmllib.github.io/CmlLib.Core.Installer.Forge/api/CmlLib.Core.Installer.Forge.ForgeInstallOptions.html)
