# LiteLoader Installer

Install LiteLoader versions.

## Example

```csharp
var path = new MinecraftPath();
var launcher = new CMLauncher(path);
launcher.FileChanged += Downloader_ChangeFile;
launcher.ProgressChanged += Downloader_ChangeProgress;

// initialize LiteLoader installer
var liteLoaderVersionLoader = new LiteLoaderVersionLoader();
var liteLoaderVersions = await liteLoaderVersionLoader.GetVersionMetadatasAsync();

// print all LiteLoader versions
foreach (var item in liteLoaderVersions)
{
    Console.WriteLine(item);
}

Console.WriteLine("Select LiteLoader version name (ex: LiteLoader1.12.2) : ");
var selectLiteLoaderVersion = Console.ReadLine();

// print all game versions
var versions = await launcher.GetAllVersionsAsync();
foreach (var item in versions)
{
    Console.WriteLine(item);
}

Console.WriteLine("Select minecraft version where to install : ");
var selectGameVersion = Console.ReadLine();

if (string.IsNullOrEmpty(selectLiteLoaderVersion) || string.IsNullOrEmpty(selectGameVersion))
    return;

// install LiteLoader
var liteLoader =
    (LiteLoaderVersionMetadata)liteLoaderVersions.GetVersionMetadata(selectLiteLoaderVersion);
var startVersionName = liteLoader.Install(path, await versions.GetVersionAsync(selectGameVersion));

// update version list
await launcher.GetAllVersionsAsync();

// start
var process = await launcher.CreateProcessAsync(startVersionName, new MLaunchOption());

process.Start();
```