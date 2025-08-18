---
description: Get Minecraft changelogs
---

# Minecraft Changelogs

![image](https://user-images.githubusercontent.com/17783561/82139750-20f0eb00-9865-11ea-8a41-c045ee123c09.png)

## Sample code

See [ChangeLog.cs](https://github.com/CmlLib/CmlLib.Core/blob/master/examples/winform/ChangeLog.cs) in the CmlLibWinFormSample project.

## Example

```csharp
Changelogs changelogs = await Changelogs.GetChangelogs(); // get changelog informations
string[] versions = changelogs.GetAvailableVersions(); // get all available versions
string changelogHtml = await changelogs.GetChangelogHtml("1.16.5"); // get html of 1.16.5 changelog
```

## Methods

### static GetChangelogs()

_Returns: `Task<Changelogs>`_

Get changelog informations from mojang server.

### GetAvailableVersions()

_Returns: `string[]`_

Returns Minecraft versions which have a changelog.

### GetChangelogHtml(string version)

_Returns: `Task<string>`_

Returns the HTML code of the changelog of `version`.\
The HTML code contains only the changelog; there is no header or footer. You can display this HTML with the WebBrowser element if you'd like.
