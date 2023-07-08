# MForge

`MForge` is wrapper of Forge installer.&#x20;

```csharp
var forge = new MForge(launcher);

// add event handlers
forge.FileChanged += fileChanged;
forge.ProgressChanged += progressChanged;
forge.InstallerOutput += (s, e) => Console.WriteLine(e);

// install the best forge version
await forge.Install("1.20.1");

// install the specific forge version
await forge.Install("1.20.1", "47.1.0");

// install without checking
await forge.Install("1.20.1", forceUpdate: true);
await forge.Install("1.20.1", "47.1.0", forceUpdate: true);
```

## Event Handlers

For `FileChanged` and `ProgressChanged`, see [Handling-Events.md](../cmllib.core/getting-started/Handling-Events.md "mention").

With `InstallerOutput`, you can get logs from the forge installer. For example:&#x20;

```
Forge installer 
```

## Install Methods

### Install(string mcVersion, bool forceUpdate = false)

Install the best Forge version for the given `mcVersion`. The best Forge version is determined by following rule:

1. Recommended version
2. Latest version
3. First version

### Install(string mcVersion, string forgeVersion, bool forceUpdate = false)

Install the specific Forge version.

### forceUpdate: true

Installer checks if the Forge version is already installed and skip installation if exists. However with `forceUpdate: true` option, The installer does not skip installation and always install and overwrite existing version.

## AD

`MForge` will show the ad page after a successful installation. Official Forge installer has below message:

```
Please do not automate the download and installation of Forge.
Our efforts are supported by ads from the download page.
If you MUST automate this, please consider supporting the project through https://www.patreon.com/LexManos
```

If you don't want this, Modify [MForge source code](https://github.com/CmlLib/CmlLib.Core.Installer.Forge/blob/main/CmlLib.Core.Installer.Forge/MForge.cs) by yourself.&#x20;
