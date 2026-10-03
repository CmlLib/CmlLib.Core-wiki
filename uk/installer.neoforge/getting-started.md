# Перші кроки

## Встановлення

Встановіть NuGet-пакет [CmlLib.Core.Installer.NeoForge](https://www.nuget.org/packages/CmlLib.Core.Installer.NeoForge)

```
dotnet add package CmlLib.Core.Installer.NeoForge
```

## Приклад

```csharp
using CmlLib.Core;
using CmlLib.Core.Auth;
using CmlLib.Core.Installer.NeoForge;
using CmlLib.Core.Installer.NeoForge.Installers;
using CmlLib.Core.Installers;
using CmlLib.Core.ProcessBuilder;

var path = new MinecraftPath(); // використання директорії за замовчуванням
var launcher = new MinecraftLauncher(path);

// вивід прогресу завантаження в консоль
var fileProgress = new SyncProgress<InstallerProgressChangedEventArgs>(e =>
    Console.WriteLine($"[{e.EventType}][{e.ProgressedTasks}/{e.TotalTasks}] {e.Name}"));
var byteProgress = new SyncProgress<ByteProgress>(e =>
    Console.WriteLine(e.ToRatio() * 100 + "%"));
var installerOutput = new SyncProgress<string>(e =>
    Console.WriteLine(e));

// Ініціалізація змінних із версією Minecraft та версією NeoForge
var mcVersion = "1.21.10";
var forgeVersion = "21.10.2-beta";

// Ініціалізація NeoForge
var forge = new NeoForgeInstaller(launcher);

var version_name = await forge.Install(mcVersion, forgeVersion, new NeoForgeInstallOptions
{
    FileProgress = fileProgress,
    ByteProgress = byteProgress,
    InstallerOutput = installerOutput,
});

// Запуск Minecraft
var launchOption = new MLaunchOption
{
    MaximumRamMb = 1024,
    Session = MSession.CreateOfflineSession("GamerVII"),
};

var process = await launcher.CreateProcessAsync(version_name, launchOption);

// вивід логів гри
var processUtil = new ProcessWrapper(process);
processUtil.OutputReceived += (s, e) => Console.WriteLine(e);
processUtil.StartWithEvents();
await processUtil.WaitForExitTaskAsync();
```

## Приклад інсталятора

[SampleForgeInstaller](https://github.com/Gml-Launcher/CmlLib.Core.Installer.NeoForge/blob/master/SampleNeoForgeInstaller/Program.cs)
