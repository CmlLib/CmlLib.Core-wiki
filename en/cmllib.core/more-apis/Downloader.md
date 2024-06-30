---
description: Download game files
---

# GameInstaller

`IGameInstaller` checks for the existence and integrity of the file and downloads it if necessary.

The GameInstaller fires events that indicate the progress of the installation. See [Handling-Events.md](../getting-started/Handling-Events.md "mention")

### Example

```csharp
var installer = ParallelGameInstaller.CreateAsCoreCount(new HttpClient());
var file = new GameFile("name")
{
    Path = "absolute path of the file",
    Hash = "SHA1 checksum, in hex string",
    Size = 1024, // file size
    Url = "URL to download the file",
};
await installer.Install([file], fileProgress, byteProgress, CancellationToken.None);
```

### BasicGameInstaller

Single-threaded installer

```csharp
var installer = new BasicGameInstaller(new HttpClient());
```

### ParallelGameInstaller

Multi-threaded installer. `CreateAsCoreCount` method initializes a new `ParallelGameInstaller` with the number of cores of the current PC.

```csharp
var installer = ParallelGameInstaller.CreateAsCoreCount(new HttpClient());
```

You can specify the maximum number of concurrences for each task:

```csharp
var installer = new ParallelGameInstaller(
    maxChecker: 4,
    maxDownloader: 8,
    boundedCapacity: 2048, // download queue size
    new HttpClient());
```
