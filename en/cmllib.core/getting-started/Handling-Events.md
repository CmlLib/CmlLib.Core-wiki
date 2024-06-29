---
description: Show installer progress to user
---

# Event Handling

The game installer provides two types of event:

* `FileProgress` indicates the name, type, and number of files in progress.
* `ByteProgress` indicates the size of files processed / the size of all files in bytes.

And there are two ways to register an event handler:

* Pass `IProgress<>` interface to the method of the game installer.
* Register event handler. (will be invoked on the current `SynchronizationContext`, so it is safe to access UI components)

If the `IProgress<>` interface is passed to the method, any event handlers will be ignored.&#x20;

### Example (with IProgress)

```csharp
var launcher = new MinecraftLauncher();
await launcher.InstallAsync(
    "1.20.4", 
    new Progress<InstallerProgressChangedEventArgs>(e =>
    {
        Console.WriteLine("Name: " + e.Name);
        Console.WriteLine("EventType: " + e.EventType);
        Console.WriteLine("TotalTasks: " + e.TotalTasks);
        Console.WriteLine("ProgressedTasks: " + e.ProgressedTasks);
    }),
    new Progress<ByteProgress>(e =>
    {
        Console.WriteLine("TotalBytes: " + e.TotalBytes);
        Console.WriteLine("ProgressedBytes: " + e.ProgressedBytes);
        Console.WriteLine("Percentage: " + e.ToRatio() * 100);
    }),
    CancellationToken.None);
```

### Example (with Event handler)

```csharp
var launcher = new MinecraftLauncher();
launcher.FileProgressChanged += (_, e) =>
{
    Console.WriteLine("Name: " + e.Name);
    Console.WriteLine("EventType: " + e.EventType);
    Console.WriteLine("TotalTasks: " + e.TotalTasks);
    Console.WriteLine("ProgressedTasks: " + e.ProgressedTasks);
};
launcher.ByteProgressChanged += (_, e) =>
{
    Console.WriteLine("TotalBytes: " + e.TotalBytes);
    Console.WriteLine("ProgressedBytes: " + e.ProgressedBytes);
    Console.WriteLine("Percentage: " + e.ToRatio() * 100);
};
await launcher.InstallAsync("1.20.4", CancellationToken.None);
```
