---
description: Install Forge mod loader
---

# Forge Installer

## [Installer.Forge](../../installer.forge/ "mention")

Use this library to install Forge mod loader automatically.

## Install Forge without installer

1. Extract forge files
2. Upload extracted forge files into your file server or bundle it into your launcher
3. Write codes that copy extracted forge files into game directory

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

_NOTE: some forge version does not have \<forge-version-name>.jar file. it's okay_

## Launching forge

After installing forge, you can get version name of installed forge using `launcher.GetAllVersions()` or `await launcher.GetAllVersionsAsync()`. [CMLauncher.md](../getting-started/CMLauncher.md "mention")

Launch game using forge version name.

```csharp
var process = await launcher.CreateProcessAsync("forge-version-name", options);
process.Start();
```

Example `1.12.2-forge-14.23.5.2855`:

```csharp
var process = await launcher.CreateProcessAsync("1.12.2-forge-14.23.5.2855", new MLaunchOption
{
    Session = MSession.GetOfflineSession("hello"),
    MaximumRamMb = 4096
});
process.Start();
```
