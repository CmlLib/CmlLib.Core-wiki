# Supported Versions

{% hint style="warning" %}
**This document is outdated!** The latest documentation has moved to [here](https://cmllib.github.io/CmlLib.Core-wiki/en/).
{% endhint %}

This library aims to support installations of all versions of Forge since 1.7.10. Versions prior to 1.7.10 can be installed, but it needs some work. You can find instructions for this further down on this page. All versions after 1.7.10 should install and run normally. If it doesn't work, please open an issue.

## Summary

| Range                           | Summary                                |
| ------------------------------- | -------------------------------------- |
| 1.1 \~ 1.7.2                    | ⚠️Partially Support                    |
| 1.7.10 \~ 1.21.4                | ✅ SUPPORT, tested                      |
| after 1.21.4 \~ future versions | ✅ SUPPORT, not tested, but should work |

## All Test Results

The version name following the check icon means the version of Forge used in the test. The version of Forge used in the test is either the recommended version or the most recent version. A successfully tested version of Minecraft should be able to install and run with other Forge versions.

Versions not listed in this table are untested. Again, versions after 1.7.10 should be able to install and run even if they are not in this table.

| Version      | Test Result                                    |
| ------------ | ---------------------------------------------- |
| 1.21.4       | ✅ 1.21.4-forge-54.1.0                          |
| 1.20.6       | ✅ 1.20.6-forge-50.2.0                          |
| 1.20.1       | ✅ 1.20.1-forge-47.1.0                          |
| 1.20         | ✅ 1.20-forge-46.0.14                           |
| 1.19.4       | ✅ 1.19.4-forge-45.1.0                          |
| 1.19.3       | ✅ 1.19.3-forge-44.1.0                          |
| 1.19.2       | ✅ 1.19.2-forge-43.2.0                          |
| 1.19.1       | ✅ 1.19.1-forge-42.0.9                          |
| 1.19         | ✅ 1.19-forge-41.1.0                            |
| 1.18.2       | ✅ 1.18.2-forge-40.2.0                          |
| 1.18.1       | ✅ 1.18.1-forge-39.1.0                          |
| 1.18         | ✅ 1.18-forge-38.0.17                           |
| 1.17.1       | ✅ 1.17.1-forge-37.1.1                          |
| 1.16.5       | ✅ 1.16.5-forge-36.2.34                         |
| 1.16.4       | ✅ 1.16.4-forge-35.1.4                          |
| 1.16.3       | ✅ 1.16.3-forge-34.1.0                          |
| 1.16.2       | ✅ 1.16.2-forge-33.0.61                         |
| 1.16.1       | ✅ 1.16.1-forge-32.0.108                        |
| 1.15.2       | ✅ 1.15.2-forge-31.2.57                         |
| 1.15.1       | ✅ 1.15.1-forge-30.0.51                         |
| 1.15         | ✅ 1.15-forge-29.0.4                            |
| 1.14.4       | ✅ 1.14.4-forge-28.2.26                         |
| 1.14.3       | ✅ 1.14.3-forge-27.0.60                         |
| 1.14.2       | ✅ 1.14.2-forge-26.0.63                         |
| 1.13.2       | ✅ 1.13.2-forge-25.0.223                        |
| 1.12.2       | ✅ 1.12.2-forge-14.23.5.2859                    |
| 1.12.1       | ✅ 1.12.1-forge1.12.1-14.22.1.2478              |
| 1.12         | ✅ 1.12-forge1.12-14.21.1.2387                  |
| 1.11.2       | ✅ 1.11.2-forge1.11.2-13.20.1.2588              |
| 1.11         | ✅ 1.11-forge1.11-13.19.1.2189                  |
| 1.10.2       | ✅ 1.10.2-forge1.10.2-12.18.3.2511              |
| 1.10         | ✅ 1.10-forge1.10-12.18.0.2000-1.10.0           |
| 1.9.4        | ✅ 1.9.4-forge1.9.4-12.17.0.2317-1.9.4          |
| 1.9          | ✅ 1.9-forge1.9-12.16.1.1887                    |
| 1.8.9        | ✅ 1.8.9-forge1.8.9-11.15.1.2318-1.8.9          |
| 1.8.8        | ✅ 1.8.8-forge1.8.8-11.15.0.1655                |
| 1.7.10       | ✅ 1.7.10-Forge10.13.4.1614-1.7.10              |
| 1.7.10\_pre4 | ❌ cannot detect game version                   |
| 1.7.2        | ❌ game crash                                   |
| 1.6.4        | ⚠️ 1.6.4-Forge9.11.1.1345, requiring arguments |
| 1.6.3        | ⚠️ 1.6.3-Forge9.11.0.878, requiring arguments  |
| 1.6.2        | ⚠️ 1.6.2-Forge9.10.1.871, requiring arguments  |
| 1.6.1        | ⚠️ Forge8.9.0.775, requiring arguments         |
| 1.5.2        | ⚠️ 1.5.2-Forge7.8.1.738, requiring libraries   |
| 1.5.1        | ⚠️ 1.5.1-Forge7.7.2.682, requiring libraries   |
| 1.5          | ⚠️ 1.5-Forge7.7.0.598, requiring libraries     |
| 1.4.7        | ⚠️ 1.4.7-Forge6.6.2.534, requiring libraries   |
| 1.4.6        | ⚠️ 1.4.6-Forge6.5.0.489, requiring libraries   |
| 1.4.5        | ⚠️ 1.4.5-Forge6.4.2.448, requiring libraries   |
| 1.4.4        | ⚠️ 1.4.4-Forge6.3.0.378, requiring libraries   |
| 1.4.3        | ⚠️ 1.4.3-Forge6.2.1.358, requiring libraries   |
| 1.4.2        | ⚠️ 1.4.2-Forge6.0.1.355, requiring libraries   |
| 1.4.1        | ⚠️ 1.4.1-Forge6.0.0.329, requiring libraries   |
| 1.3.2        | ⚠️ 1.3.2-Forge4.3.5.318, requiring libraries   |
| 1.2.5        | ✅ 1.2.5-Forge3.4.9.171                         |
| 1.2.4        | ⚠️ 1.2.4-Forge2.0.0.68, requiring ModLoader    |
| 1.2.3        | ⚠️ 1.2.3-Forge1.4.1.64, requiring ModLoader    |
| 1.1          | ⚠️1.1-Forge1.3.4.29, requiring ModLoader       |

## For 1.1 \~ 1.2.4

Older versions of Forge were not standalone. These versions require [ModLoader](https://mcarchive.net/mods/modloader). You have to patch ModLoader after installing these Forge versions.

## For 1.3.2 \~ 1.5.2

| Game Version                      | File Name                      | SHA1 Checksum                            |
| --------------------------------- | ------------------------------ | ---------------------------------------- |
| 1.3.2, 1.4.1, 1.4.2, 1.4.3, 1.4.4 | asm-all-4.0.jar                | 2518725354c7a6a491a323249b9e86846b00df09 |
| 1.3.2, 1.4.1, 1.4.2, 1.4.3, 1.4.4 | guava-12.0.1.jar               | b8e78b9af7bf45900e14c6f958486b6ca682195f |
| 1.3.2, 1.4.1, 1.4.2, 1.4.3, 1.4.4 | argo-2.25.jar                  | bb672829fde76cb163004752b86b0484bd0a7f4b |
| 1.4.5, 1.4.6, 1.4.7               | asm-all-4.0.jar                | 2518725354c7a6a491a323249b9e86846b00df09 |
| 1.4.5, 1.4.6, 1.4.7               | guava-12.0.1.jar               | b8e78b9af7bf45900e14c6f958486b6ca682195f |
| 1.4.5, 1.4.6, 1.4.7               | argo-2.25.jar                  | bb672829fde76cb163004752b86b0484bd0a7f4b |
| 1.4.5, 1.4.6, 1.4.7               | bcprov-jdk15on-147.jar         | 2518725354c7a6a491a323249b9e86846b00df09 |
| 1.5                               | argo-small-3.2.jar             | bb672829fde76cb163004752b86b0484bd0a7f4b |
| 1.5                               | guava-14.0-rc3.jar             | 931ae21fa8014c3ce686aaa621eae565fefb1a6a |
| 1.5                               | asm-all-4.1.jar                | 054986e962b88d8660ae4566475658469595ef58 |
| 1.5                               | bcprov-jdk15on-1.48.jar        | 960dea7c9181ba0b17e8bab0c06a43f0a5f04e65 |
| 1.5                               | deobfuscation\_data\_1.5.zip   | 22e221a0d89516c1f721d6cab056a7e37471d0a6 |
| 1.5                               | scala-library.jar              | 458D046151AD179C85429ED7420FFB1EAF6DDF85 |
| 1.5.1                             | argo-small-3.2.jar             | bb672829fde76cb163004752b86b0484bd0a7f4b |
| 1.5.1                             | guava-14.0-rc3.jar             | 931ae21fa8014c3ce686aaa621eae565fefb1a6a |
| 1.5.1                             | asm-all-4.1.jar                | 054986e962b88d8660ae4566475658469595ef58 |
| 1.5.1                             | bcprov-jdk15on-1.48.jar        | 960dea7c9181ba0b17e8bab0c06a43f0a5f04e65 |
| 1.5.1                             | deobfuscation\_data\_1.5.1.zip | 446e55cd986582c70fcf12cb27bc00114c5adfd9 |
| 1.5.1                             | scala-library.jar              | 458D046151AD179C85429ED7420FFB1EAF6DDF85 |
| 1.5.2                             | deobfuscation\_data\_1.5.2.zip | 5f7c142d53776f16304c0bbe10542014abad6af8 |

Locate these files in `<game_directory>/lib` .

## For 1.6.1 \~ 1.6.4

Requires an additional JVM argument: `-Dfml.ignoreInvalidMinecraftCertificates=true`

For example:

```csharp
var process = await _launcher.InstallAndBuildProcessAsync("1.6.4-Forge9.11.1.1345", new MLaunchOption
{
    Session = MSession.CreateOfflineSession("tester123"),
    ExtraJvmArguments = new[]
    {
        new MArgument("-Dfml.ignoreInvalidMinecraftCertificates=true"),
    }
});
process.Start();
```
