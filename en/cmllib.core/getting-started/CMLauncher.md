# Minecraft Launcher

Basic Usage

!!! tip ".NET Framework Optimization"
    In .NET Framework, add the following code to maximize the download speed. This is not necessary in .NET Core.

    ```csharp
    System.Net.ServicePointManager.DefaultConnectionLimit = 256;
    ```

```csharp
using CmlLib.Core;
using CmlLib.Core.Auth;
using CmlLib.Core.ProcessBuilder;
using CmlLib.Core.VersionMetadata;

// initialize the launcher
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);

// add event handlers
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

// get all versions
var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine(v.GetVersionType());
    Console.WriteLine(v.Name);
}

// install and launch the game
await launcher.InstallAsync("1.20.6");
var process = await launcher.BuildProcessAsync("1.20.6", new MLaunchOption
{
    Session = MSession.CreateOfflineSession("Gamer123"),
    MaximumRamMb = 4096
});
Console.WriteLine(process.StartInfo.Arguments);

// launch the game
var processWrapper = new ProcessWrapper(process);
processWrapper.OutputReceived += (s, e) => Console.WriteLine(e);
processWrapper.StartWithEvents();

var exitCode = await processWrapper.WaitForExitTaskAsync();
Console.WriteLine($"Exited with code {exitCode}");
```

### Explanation

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);
```

Create Minecraft directory structure and initialize launcher instance. You can change the path and directory structure. See [Minecraft Path](MinecraftPath.md) and [MinecraftLauncherParameters](../more-apis/minecraftlauncherparameters.md)

```csharp
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
```

Add event handler. It prints download progress to console. See [Event Handling](Handling-Events.md)

```csharp
var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine(v.Name);
}
```

Get all version and print its names. See [Versions](versions.md)

```csharp
await launcher.InstallAsync("1.20.4");
var process = await launcher.BuildProcessAsync("1.20.4", new MLaunchOption
{
    Session = MSession.CreateOfflineSession("Gamer123"),
    MaximumRamMb = 4096
});
process.Start();
```

Install the game and build the game process and return it. See [Launch Options](MLaunchOption.md) for more launch options.

!!! info "Installation Recommendation"
    It is recommended to always call the InstallAsync method before launching, regardless of whether it is installed or not. The InstallAsync method checks all installed files and only downloads files that are corrupted or missing.

```csharp
var processWrapper = new ProcessWrapper(process);
processWrapper.OutputReceived += (s, e) => Console.WriteLine(e);
processWrapper.StartWithEvents();

var exitCode = await processWrapper.WaitForExitTaskAsync();
Console.WriteLine($"Exited with code {exitCode}");
```

Launch the game process and output game logs to console. Wait for the game to exit and output the exit code. See [ProcessWrapper](../utilities/processwrapper.md)

!!! info "Process Object"
    The `process` variable is a standard .NET [Process](https://learn.microsoft.com/en-us/dotnet/api/system.diagnostics.process) object. You can launch it immediately with `process.Start();` without using `ProcessWrapper`.

### More Methods

Get all files to launch the version

```csharp
// by version name
IEnumerable<GameFile> files = await launcher.ExtractFiles("1.20.4", cancellationToken);
```

```csharp
// by IVersion 
IVersion version = await launcher.GetVersionAsync("1.20.4", cancellationToken);
IEnumerable<GameFile> files = await launcher.ExtractFiles(version, cancellationToken);
```

Scan files and download any files that need to be downloaded

```csharp
// report install progress to launcher.FileProgressChanged, launcher.ByteProgressChanged
await launcher.InstallAsync("1.20.4", cancellationToken); // by version name
await launcher.InstallAsync(version, cancellationToken); // by IVersion 

// report install progress to fileProgress, byteProgress
await launcher.InstallAsync("1.20.4", fileProgress, byteProgress, cancellationToken); // by version name 
await launcher.InstallAsync(version, fileProgress, byteProgress, cancellationToken); // by IVersion 
```

Build game process

```csharp
// by version name
Process process = await launcher.BuildProcessAsync("1.20.4", new MLaunchOption(), cancellationToken);
```

```csharp
// by IVersion
IVersion version = await launcher.GetVersionAsync("1.20.4", cancellationToken);
Process process = launcher.BuildProcess(version, new MLaunchOption());
```

Get the Java path required to launch the version

```csharp
IVersion version = await launcher.GetVersionAsync("1.20.4", cancellationToken);
string? javaPath = await launcher.GetJavaPath(version);
```

Get the path to the first installed Java

```csharp
string? javaPath = await launcher.GetDefaultJavaPath();
```

## API References

??? abstract "Methods"

    **ValueTask InstallAndBuildProcessAsync(string versionName, MLaunchOption launchOption, CancellationToken cancellationToken = default)**
