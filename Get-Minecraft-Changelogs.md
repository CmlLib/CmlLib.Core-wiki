This is experimental function.

# Changelogs class

![image](https://user-images.githubusercontent.com/17783561/82139750-20f0eb00-9865-11ea-8a41-c045ee123c09.png)

Get minecraft changelogs.

## Sample codes

See [ChangeLog.cs](https://github.com/AlphaBs/CmlLib.Core/blob/master/CmlLibWinFormSample/ChangeLog.cs) in CmlLibWinFormSample project.

## Example

    string[] versions = Changelogs.GetAvailableVersion(); // return ["1.13", "1.14.2", etc...]
    string changelogUrl = Changelogs.GetChangelogUrl("1.13"); // return "https://feedback.minecraft.~~~"
    string html = Changelogs.GetChangelogHtml("1.13"); // return html code of 1.13 changelog

## Methods

### GetAvailableVersions()

**Return: string[]**

Return minecraft versions which have changelog.

### GetChangelogUrl(string version)

**Return string**

Return the changelog url of `version`

### GetChangelogHtml(string version)

**Return string**

Return HTML code of changelog of `version`  
HTML code contains only the changelog, except header or footer of entire html document.  
You can display this HTML in WebBrowser
