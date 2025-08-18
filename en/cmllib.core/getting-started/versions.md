# Versions

### Example: Print all versions

The `GetAllVersionsAsync` method returns all vanilla and locally installed versions of Minecraft.

```csharp
var launcher = new MinecraftLauncher();
var versions = await launcher.GetAllVersionsAsync();
foreach (var version in versions)
{
    Console.WriteLine("Name: " + version.Name);
    Console.WriteLine("Type: " + version.GetVersionType());
    Console.WriteLine("ReleaseTime: " + version.ReleaseTime);
}
```

### Example: Get specific version

`GetVersionAsync` method load and parse version json file.

```csharp
var launcher = new MinecraftLauncher();
var version = await launcher.GetVersionAsync("1.20.4");
// version.Id
// version.Jar
// version.Libraries
// etc...
```

### Example: Manipulate version

`IVersion` is designed to be an immutable type. With `.ToMutableVersion(),` you can convert any version to a mutable version, so that you can change the version data.

In version 1.16.5, the Multiplayer button is disabled when launch the game with an offline session. This can be fixed by using a modified `authlib` library. ([#85](https://github.com/CmlLib/CmlLib.Core/issues/85))

```csharp
var launcher = new MinecraftLauncher();
var version = (await launcher.GetVersionAsync("1.16.5")).ToMutableVersion();

// remove existing authlib
version.LibraryList.RemoveAt(version.LibraryList.FindIndex(lib => lib.Name == "com.mojang:authlib:2.1.28"));

// add modified authlib
// download authlib-2.1.28-workaround.jar file and place it in <game_directory>/libraries/com/mojang/authlib/2.1.28/authlib-2.1.28-workaround.jar
version.LibraryList.Add(new MLibrary("com.mojang:authlib:2.1.28")
{
    Artifact = new CmlLib.Core.Files.MFileMetadata
    {
        Path = "com/mojang/authlib/2.1.28/authlib-2.1.28-workaround.jar",
        Sha1 = "", // (optional) SHA1 checksum of the library
        Url = "" // (optional) URL to download library if file does not exist or checksum is not equal
    }
});

await launcher.InstallAsync(version);
var process = launcher.BuildProcess(version, new MLaunchOption
{
    Session = MSession.CreateOfflineSession("tester123")
});
process.Start(); 
```
