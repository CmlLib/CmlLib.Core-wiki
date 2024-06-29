# Versions

1

### Example: Print all versions

```csharp
var launcher = new MinecraftLauncher();
var versions = await launcher.GetAllVersionsAsync();
foreach (var version in versions)
{
    Console.WriteLine("Name: " + version.Name);
    Console.WriteLine("Type: " + version.Type);
    Console.WriteLine("ReleaseTime: " + version.ReleaseTime);
}
```

2

### Example: Get specific version

```csharp
var launcher = new MinecraftLauncher();
var version = await launcher.GetVersionAsync("1.20.4");
// version.Id
// version.Jar
// version.Libraries
// etc...
```

3

### Example: Manipulate version

```csharp
var launcher = new MinecraftLauncher();
var version = (await launcher.GetVersionAsync("1.20.4").ToMutableVersion();
version.LibraryList.Remove(version.LibraryList.First(lib => lib.Name == "authlib"));
version.LibraryList.Add(new MLibrary("authlib")
{
    Artifact = new CmlLib.Core.Files.MFileMetadata
    {
        Path = "com/authlib",
        Sha1 = "0123456789ABCDEF",
        Url = "https://server/com/authlib"
    }
});
```
