This is an experimental function.

# Changelogs class

![image](https://user-images.githubusercontent.com/17783561/82139750-20f0eb00-9865-11ea-8a41-c045ee123c09.png)

Get minecraft changelogs.

## Sample code

See [ChangeLog.cs](https://github.com/AlphaBs/CmlLib.Core/blob/master/CmlLibWinFormSample/ChangeLog.cs) in the CmlLibWinFormSample project.

## Example

```csharp
string[] versions = Changelogs.GetAvailableVersion(); // returns ["1.13", "1.14.2", etc...]
string changelogUrl = Changelogs.GetChangelogUrl("1.13"); // returns "https://feedback.minecraft.net/___"
string html = Changelogs.GetChangelogHtml("1.13"); // returns the HTML code of the 1.13 changelog
```

## Methods

### GetAvailableVersions()

**Returns: string[]**

Returns Minecraft versions which have a changelog.

### GetChangelogUrl(string version)

**Returns: string**

Returns the changelog url of `version`.

### GetChangelogHtml(string version)

**Returns: string**

Returns the HTML code of the changelog of `version`.  
The HTML code contains only the changelog; there is no header or footer.
You can display this HTML with the WebBrowser element if you'd like.
