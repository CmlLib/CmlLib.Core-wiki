# Fabric Installer

Install Fabric versions.

## Example

```csharp
 var path = new MinecraftPath();
 var launcher = new CMLauncher(path);
 launcher.FileChanged += Downloader_ChangeFile;
 launcher.ProgressChanged += Downloader_ChangeProgress;

 // initialize fabric version loader
 var fabricVersionLoader = new FabricVersionLoader();
 var fabricVersions = await fabricVersionLoader.GetVersionMetadatasAsync();

 // print fabric versions
 foreach (var v in fabricVersions)
 {
     Console.WriteLine(v.Name);
 }

Console.WriteLine("select version: ");
var fabricVersionName = Console.ReadLine();

if (string.IsNullOrEmpty(fabricVersionName))
    return;

// install
var fabric = fabricVersions.GetVersionMetadata(fabricVersionName);
await fabric.SaveAsync(path);

// update version list
await launcher.GetAllVersionsAsync();

var process = await launcher.CreateProcessAsync(fabricVersionName, new MLaunchOption());
process.Start();
```

