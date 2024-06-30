---
description: Main class of CmlLib.Core.
---

# Minecraft Launcher

## Basic Usage

```csharp
System.Net.ServicePointManager.DefaultConnectionLimit = 256;

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
    Console.WriteLine(v.Name);
}

// install and launch the game
await launcher.InstallAsync("1.20.6");
var process = await launcher.BuildProcessAsync("1.20.6", new MLaunchOption
{
    Session = MSession.CreateOfflineSession("Gamer123"),
    MaximumRamMb = 4096
});
process.Start();
```

### Explaination

```csharp
System.Net.ServicePointManager.DefaultConnectionLimit = 256;
```

Increase the maximum number of concurrent connections. This code would increase the download speed.

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);
```

Create Minecraft directory structure and initialize launcher instance. You can change the path and directory structure. See [MinecraftPath.md](MinecraftPath.md "mention") and [minecraftlauncherparameters.md](../more-apis/minecraftlauncherparameters.md "mention")

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

Add event handler. It prints download progress to console. See [Handling-Events.md](Handling-Events.md "mention")

```csharp
var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine(v.Name);
}
```

Get all version and print its names. See [versions.md](versions.md "mention")

```csharp
await launcher.InstallAsync("1.20.4");
var process = await launcher.BuildProcessAsync("1.20.4", new MLaunchOption
{
    Session = MSession.CreateOfflineSession("Gamer123"),
    MaximumRamMb = 4096
});
process.Start();
```

Install the game and build the game process and return it. See [MLaunchOption.md](MLaunchOption.md "mention") for more launch options.

## API References

<details>

<summary>Methods</summary>

**ValueTask InstallAndBuildProcessAsync(string versionName, MLaunchOption launchOption, CancellationToken cancellationToken = default)**

Install `versionName` and build process.

</details>

<details>

<summary>Properties</summary>

**MinecraftPath**

_Type: MinecraftPath_

</details>
