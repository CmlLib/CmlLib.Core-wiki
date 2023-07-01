---
description: Download game files
---

# Downloader

Downloaders should inherit `IDownloader` class. Currently, there are only two downloader, `SequenceDownloader` and `AsyncParallelDownloader`. `AsyncParallelDownloader` is default downloader.

## IDownloader

#### public event DownloadFileChangedHandler ChangeFile;

When the **file** being downloaded changes.\
See [Handling-Events.md](../getting-started/Handling-Events.md "mention").

#### public event ProgressChangedEventHandler ChangeProgress;

When the **progress** of the file currently being downloaded changes.\
See [Handling-Events.md](../getting-started/Handling-Events.md "mention").

#### public Task DownloadFiles(DownloadFile\[] files);

Download all files.

## SequenceDownloader

Download files sequentially.

## AsyncParallelDownloader

Download files in parallel.\
In this class, The progress of `ChangeProgress` means (received bytes) / (the sum of the byte sizes of **All files** to download) \* 100

### Constructors

#### public AsyncParallelDownloader()

Same as `new AsyncParallelDownloader(10)`

#### public AsyncParallelDownloader(int parallelism)

Limit the max number of parallelism.

## Example

```csharp
var launcher = new CMLauncher(new MinecraftPath());

// Use SequenceDownloader
launcher.Downloader = new SequenceDownloader();

// Use AsyncParallelDownloader with limiting max parallelism number to 5
launcher.Downloader = new AsyncParallelDownloader(5);
```

## Make custom downloader

Make implementation of `IDownloader`.

## DownloadFile class

Represent file that requires to be downloaded.

### Properties

#### Type

_Type: MFile_ [Handling-Events.md](../getting-started/Handling-Events.md "mention")

#### Name

_Type: string_

#### Path

_Type: string_

#### Url

_Type: string_

#### Size

_Type: long_

#### AfterDownload

_Type: Func\<Task>\[]_

The list of work to do after download was completed.

### Methods

#### Equals(object obj)

Return `true` if `Path` property is same.
