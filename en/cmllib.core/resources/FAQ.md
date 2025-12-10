# FAQ

{% hint style="warning" %}
**This document is outdated!** The latest documentation has moved to [here](https://cmllib.github.io/CmlLib.Core-wiki/en/).
{% endhint %}

## Get game outputs (logs)

You can read standard output of game process.\
As `CreateProcess` method returns `Process` instance, you can use all APIs of `Process`. ([reference](https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.process?view=net-6.0))

```csharp
process.StartInfo.CreateNoWindow = false;
process.StartInfo.UseShellExecute = false;
process.StartInfo.RedirectStandardError = true;
process.StartInfo.RedirectStandardOutput = true;
process.EnableRaisingEvents = true;
process.ErrorDataReceived += (s, e) => Console.WriteLine(e.Data);
process.OutputDataReceived += (s, e) => Console.WriteLine(e.Data);

process.Start();
process.BeginErrorReadLine();
process.BeginOutputReadLine();
```

Above code write all game outputs to console. You can check game logs in console.

## Launch custom game client

You need two file: `<version_name>.jar`, `<version_name>.json`.\
Put these files into `<game_directory>/versions/<version_name>` directory.

Example)

```
<game_directory>
 | - versions
 |    | - myversion
 |    |    | - myversion.jar
 |    |    | - myversion.json
```

Make sure that version directory name, jar file name, json file name, and `id` property in version json file is all same.

If you copy version json file from vanilla version json file, you should remove `downloads` property in version json file to prevent launcher overwrites your custom version jar file with vanilla version file.

(Example for 1.12.2.json)

```
1.12.2.json <-> 1.12.2-modified.json

 | {
 |     "assetIndex": {
 |         "id": "1.12",
 |         "sha1": "1584b57c1a0b5e593fad1f5b8f78536ca640547b",
 |         "size": 143138,
 |         "totalSize": 129336389,
 |         "url": "https://launchermeta.mojang.com/v1/packages/1584b57c1a0b5e593fad1f5b8f78536ca640547b/1.12.json"
 |     },
 |     "assets": "1.12",
 |     "complianceLevel": 0,
-|      "downloads": {            <===== REMOVE this property
-|         "client": {
-|             "sha1": "0f275bc1547d01fa5f56ba34bdc87d981ee12daf",
-|             "size": 10180113,
-|             "url": "https://launcher.mojang.com/v1/objects/0f275bc1547d01fa5f56ba34bdc87d981ee12daf/client.jar"
-|         },
-|         "server": {
-|             "sha1": "886945bfb2b978778c3a0288fd7fab09d315b25f",
-|             "size": 30222121,
-|             "url": "https://launcher.mojang.com/v1/objects/886945bfb2b978778c3a0288fd7fab09d315b25f/server.jar"
-|         }
-|    },
*|     "id": "1.12.2-modified", <== make sure id is same as version name
 |     "javaVersion": {
 |         "component": "jre-legacy",
 |         "majorVersion": 8
 |     },

```

All version which Mojang launcher can launch also can be launched by CmlLib.Core. Make sure that your custom version works well in Mojang launcher before using CmlLib.Core. CmlLib.Core wouldn't able to launch your version if Mojang launcher can't.

## [log4j2 vulnerability (CVE-2021-44228)](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44228)

Minecraft launched by `CmlLib 0.0.1` \~ `CmlLib.Core 3.3.3` may have log4j2 vulnerability. It is safe after `CmlLib.Core 3.3.4` version.
