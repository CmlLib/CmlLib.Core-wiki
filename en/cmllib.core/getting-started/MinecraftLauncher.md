# Minecraft Launcher

`MinecraftLauncher` is the core class of this library. It handles finding installed versions, downloading game files, and building the game process. It acts as the main entry point for most launcher operations.

## Basic Usage Steps

Here is the typical flow of using `MinecraftLauncher`:

### 1. Initialize

First, create a `MinecraftPath` object, which represents the game directory (e.g., `%appdata%\.minecraft`). Then, initialize the `MinecraftLauncher` with this path.

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);
```

You can customize the directory structure if needed. See [Minecraft Path](MinecraftPath.md) and [MinecraftLauncherParameters](../more-apis/minecraftlauncherparameters.md).

### 2. Versions

You can retrieve a list of all installed and available versions from Mojang's servers.

```csharp
var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine($"Name: {v.Name}, Type: {v.GetVersionType()}");
}
```

See [Versions](versions.md) for more details.

### 3. Install & Event Handling

Before launching, you must ensure all game files (JARs, libraries, assets) are downloaded and valid. The `InstallAsync` method handles this. You can subscribe to events to monitor download progress.

```csharp
// Event Handlers
launcher.FileProgressChanged += (sender, args) =>
{
    Console.WriteLine($"Name: {args.Name}");
    Console.WriteLine($"Type: {args.EventType}");
    Console.WriteLine($"Total: {args.TotalTasks}");
    Console.WriteLine($"Progressed: {args.ProgressedTasks}");
};
launcher.ByteProgressChanged += (sender, args) =>
{
    Console.WriteLine($"{args.ProgressedBytes} bytes / {args.TotalBytes} bytes");
};

// Install
await launcher.InstallAsync("1.20.4");
```

!!! info "Installation Recommendation"
    Always call `InstallAsync` before launching. It checks file integrity and only downloads missing or corrupted files, so it's efficient to call every time.

See [Event Handling](Handling-Events.md).

### 4. Launch

Once installed, build the game process using `BuildProcessAsync`. This creates a standard .NET `Process` object configured with the correct arguments.

```csharp
var launchOption = new MLaunchOption
{
    MaximumRamMb = 4096,
    Session = MSession.CreateOfflineSession("Gamer123"),
};

var process = await launcher.BuildProcessAsync("1.20.4", launchOption);
```

See [Launch Options](MLaunchOption.md).

### 5. Process Management

You can use the helper class `ProcessWrapper` to easily handle game output and exit events.

```csharp
var processWrapper = new ProcessWrapper(process);
processWrapper.OutputReceived += (s, e) => Console.WriteLine($"[Game] {e}");
processWrapper.StartWithEvents();
var exitCode = await processWrapper.WaitForExitTaskAsync();
Console.WriteLine($"Exited with code {exitCode}");
```

See [ProcessWrapper](../utilities/processwrapper.md).

---

## Full Example

Here is the complete code combining all the steps above.

```csharp
using System;
using CmlLib.Core;
using CmlLib.Core.Auth;
using CmlLib.Core.ProcessBuilder;

// 1. Initialize
var path = new MinecraftPath(); 
var launcher = new MinecraftLauncher(path);

Console.WriteLine($"Initialized launcher at: {path.BasePath}");

// 2. List versions

var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine($"Name: {v.Name}, Type: {v.GetVersionType()}");
}
var selectedVersion = "1.21.6";

// 3. Add event handlers and Install
launcher.FileProgressChanged += (sender, args) =>
{
    Console.WriteLine($"Name: {args.Name}");
    Console.WriteLine($"Type: {args.EventType}");
    Console.WriteLine($"Total: {args.TotalTasks}");
    Console.WriteLine($"Progressed: {args.ProgressedTasks}");
};
launcher.ByteProgressChanged += (sender, args) =>
{
    Console.WriteLine($"{args.ProgressedBytes} bytes / {args.TotalBytes} bytes");
};

await launcher.InstallAsync(selectedVersion);

// 4. Build Process
var launchOption = new MLaunchOption
{
    MaximumRamMb = 4096,
    Session = MSession.CreateOfflineSession("DevUser"),
};

var process = await launcher.BuildProcessAsync(selectedVersion, launchOption);

// 5. Launch & Monitor
var processWrapper = new ProcessWrapper(process);

processWrapper.OutputReceived += (sender, log) => 
    Console.WriteLine($"[Game] {log}");

processWrapper.StartWithEvents();
var exitCode = await processWrapper.WaitForExitTaskAsync();
Console.WriteLine($"Game exited with code: {exitCode}");
```

!!! tip ".NET Framework Optimization"
    If you are using **.NET Framework**, set the `DefaultConnectionLimit` at the **start of your application** (before initializing `MinecraftLauncher`) to maximize download speed. This is not necessary in .NET Core or .NET 5+.

    ```csharp
    System.Net.ServicePointManager.DefaultConnectionLimit = 256;
    ```

## More Methods

### Extract Files

```csharp
// by version name
IEnumerable<GameFile> files = await launcher.ExtractFiles("1.20.4", cancellationToken);
```

```csharp
// by IVersion 
IVersion version = await launcher.GetVersionAsync("1.20.4", cancellationToken);
IEnumerable<GameFile> files = await launcher.ExtractFiles(version, cancellationToken);
```

### Install Files

```csharp
// report install progress to launcher.FileProgressChanged, launcher.ByteProgressChanged
await launcher.InstallAsync("1.20.4", cancellationToken); // by version name
await launcher.InstallAsync(version, cancellationToken); // by IVersion 

// report install progress to fileProgress, byteProgress
await launcher.InstallAsync("1.20.4", fileProgress, byteProgress, cancellationToken); // by version name 
await launcher.InstallAsync(version, fileProgress, byteProgress, cancellationToken); // by IVersion 
```

### Build game process

```csharp
// by version name
Process process = await launcher.BuildProcessAsync("1.20.4", new MLaunchOption(), cancellationToken);
```

```csharp
// by IVersion
IVersion version = await launcher.GetVersionAsync("1.20.4", cancellationToken);
Process process = launcher.BuildProcess(version, new MLaunchOption());
```

### Get Java Path

```csharp
IVersion version = await launcher.GetVersionAsync("1.20.4", cancellationToken);
string? javaPath = await launcher.GetJavaPath(version);
```

Get the path to the first installed Java

```csharp
string? javaPath = await launcher.GetDefaultJavaPath();
```

## API References

- https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.MinecraftLauncher.html