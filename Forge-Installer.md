# Forge Installer

## Note
Forge installation feature in this library would not work. `MForge` has not been updated for a long time, and I will not update this anymore unless someone make pull requests. Forge installation is complex and require a lot of effort to maintain. Futhermore, Forge development team does not want anyone to make automation installation tool.

The message in forge intsaller: 
```
Please do not automate the download and installation of Forge.
Our efforts are supported by ads from the download page.
If you MUST automate this, please consider supporting the project through https://www.patreon.com/LexManos
```

## Forge installation

The recommend way is to download forge installer from official forge website and install it manually.  

If you need forge installation feature in your launcher:
1. Extract forge files.
2. Upload extracted forge files into your file server or bundle it into your launcher.
3. Write codes that copy extracted forge files into game directory.

## Extracting forge files

1. Delete `.minecraft` directory
2. Launch vanilla version of forge that you want to extract using official mojang launcher. (not thrid party launcher including CmlLib.Core launcher)
3. Install forge using official forge installer.
4. In `.minecraft` directory, copy `libraries` directory and `versions/<forge-version-name>` directory. These two directory is extracted forge files.

Example:
```
<root>
 |- libraries
 |  |- org
 |  |- net
 |  |- (many other directories)
 |
 |- versions
    |- <forge-version-name>
        |- <forge-version-name>.json
        |- <forge-version-name>.jar
```

*NOTE: some forge version does not have \<forge-version-name\>.jar file. it's okay*

## Launching forge

After installing forge, you can get version name of installed forge using `launcher.GetAllVersions()` or `await launcher.GetAllVersionsAsync()`. ([reference](https://github.com/CmlLib/CmlLib.Core/wiki/CMLauncher)).  

Launch game using forge version name.  
```csharp
var process = await launcher.CreateProcess("forge-version-name", options);
process.Start();
```

Example `1.12.2-forge-14.23.5.2855`:
```csharp
var process = await launcher.CreateProcess("1.12.2-forge-14.23.5.2855", new MLaunchOption
{
    Session = MSession.GetOfflineSession("hello"),
    MaximumRamMb = 4096
});
process.Start();
```

## MForge

Legacy class to install forge.

Using `CMLauncher`: 
```csharp
var process = launcher.CreateProcess("<vanilla-version>", "<forge-version>", launchOptions);
process.Start();
```

Example: 
```csharp
var process = launcher.CreateProcess("1.12.2", "14.23.5.2768", new MLaunchOption());
process.Start();
```