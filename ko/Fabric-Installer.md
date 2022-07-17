# Fabric Installer

Fabric 버전 설치

## Example

```csharp
 var path = new MinecraftPath();
 var launcher = new CMLauncher(path);
 launcher.FileChanged += Downloader_ChangeFile;
 launcher.ProgressChanged += Downloader_ChangeProgress;

 // initialize fabric version loader
 var fabricVersionLoader = new FabricVersionLoader();
 var fabricVersions = await fabricVersionLoader.GetVersionMetadatasAsync();

 // fabric 버전 출력
 foreach (var v in fabricVersions)
 {
     Console.WriteLine(v.Name);
 }

Console.WriteLine("버전을 선택하세요: ");
var fabricVersionName = Console.ReadLine();

if (string.IsNullOrEmpty(fabricVersionName))
    return;

// 설치
var fabric = fabricVersions.GetVersionMetadata(fabricVersionName);
await fabric.SaveAsync(path);

// 버전 리스트 업데이트
await launcher.GetAllVersionsAsync();

var process = await launcher.CreateProcessAsync(fabricVersionName, new MLaunchOption());
process.Start();
```

