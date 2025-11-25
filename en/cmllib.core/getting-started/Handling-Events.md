---
description: Show installer progress to user
---

# Event Handling

The game installer provides two types of event:

* `FileProgress` indicates the name, type, and number of files in progress.
* `ByteProgress` indicates the size of files processed / the size of all files in bytes.

And there are two ways to register an event handler:

* Pass `IProgress<>` to the method of the game installer.
* Register event handler. (will be invoked on the current `SynchronizationContext`, so it is safe to access UI components)

If the `IProgress<>` is passed to the method, any event handlers will be ignored.  

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

## Performance Tips

`FileProgress` is called very frequently (4000 to 8000 times each time InstallAsync is called), so if you put time-consuming tasks in the event handler, it can affect the performance of your program. `ByteProgress`, on the other hand, is only called 3-4 times per second, so it's relatively less sensitive to performance.

When you register an event handler, it is internally converted to a `new Progress<T>(handler)`.  [Progress<T\>](https://learn.microsoft.com/en-us/dotnet/api/system.progress-1?view=net-8.0) will have different behavior depending on the current SynchronizationContext. If it's a WinForm or WPF app, the handler's code will run in the UI thread, and if it's a console app, it will run in the ThreadPool.

So if you use an event handler in a console app, you'll be making a lot of calls to the ThreadPool. This can have a bad impact on the performance of your application, so either don't use `FileProgress`, or implement `IProgress<T>`, which doesn't use ThreadPool. The library provides `SyncProgress<T>`, which runs the handler directly on the thread that called the event. `SyncProgress<T>` should not directly access the UI and should contain as little code as possible.

```csharp
// example
IProgress<InstallerProgressChangedEventArgs> fileProgress = new SyncProgress<InstallerProgressChangedEventArgs>(e => 
{ 
    Console.WriteLine($"{e.ProgressedTasks} / {e.TotalTasks}");
});
```

## API Reference

- [MinecraftLauncher](https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.MinecraftLauncher.html)
- [ByteProgress](https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.ByteProgress.html)
- [InstallerProgressChangedEventArgs](https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.Installers.InstallerProgressChangedEventArgs.html)
- [FileProgressChanged](https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.MinecraftLauncher.html#CmlLib_Core_MinecraftLauncher_FileProgressChanged)
- [ByteProgressChanged](https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.MinecraftLauncher.html#CmlLib_Core_MinecraftLauncher_ByteProgressChanged)