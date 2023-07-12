# Home

[GitHub](https://github.com/CmlLib/CmlLib.Core)

version: 3.3.7

CmlLib.Core is a .NET library for building your own **Custom Minecraft launcher**.

## Main Features

* Log in Minecraft to play online-mode multiplay servers (ex: Hypixel)
* Log in with Microsoft Xbox account
* Download and install vanilla Minecraft version
* Install appropriate Java runtime automatically
* Install mod loaders (Fabric, LiteLoader)
* Launch all game version (tested up to 1.19)
* Launch custom game version (ex: Forge, Fabric, LiteLoader, or any modified client)
* Launch with various options (direct server connecting, screen resolutions, etc)
* Crossplatform (Windows, Linux, macOS)
* Mojang APIs (player skin, changing player username, etc)
* Customize launch flow

## All Features

<details>

<summary>Index</summary>

[CMLauncher.md](getting-started/CMLauncher.md "mention")

* Basic usage
* **Please read this first!**

[Sample-Code.md](resources/Sample-Code.md "mention")

* CmlLibCoreSample: simple console program
* CmlLibWinFormSample: full features

[Common-Errors.md](resources/Common-Errors.md "mention")

* Java runtime errors
* macOS / Linux errors

[MinecraftPath.md](getting-started/MinecraftPath.md "mention")

* Get default minecraft directory
* Create new minecraft directory
* Make custom minecraft directory structure

[mojang-account.md](login-and-sessions/mojang-account.md "mention")

* Get game session from mojang auth server
* Create offline game session

[Microsoft-Xbox-Live-Login.md](login-and-sessions/Microsoft-Xbox-Live-Login.md "mention")

* Login with Xbox account

[Handling-Events.md](getting-started/Handling-Events.md "mention")

* Show progress of downloading files (percentage, file count)
* Show file info of currently downloading file (file name)

[MLaunchOption.md](getting-started/MLaunchOption.md "mention")

* Maximum memory size (-Xmx), Minimum memory size (-Xms)
* Direct server connecting
* Screen resolution, Fullscreen
* Java setting

[Downloader.md](more-apis/Downloader.md "mention")

* AsyncParallelDownloader (default)
* SequenceDownloader

[FileChecker.md](more-apis/FileChecker.md "mention")

* AssetChecker, ClientChecker, LibraryChecker
* Skip file hash checking
* Skip specific game file checking
* Use file mirror server (like BMCLAPI mirror service)
* Make custom file checker

[VersionLoader.md](more-apis/VersionLoader.md "mention")

* Get version metadata list from local directory
* Get version metadata list from mojang server
* Get version metadata list from FabricMC server
* Get version metadata information (version name, type, release date, etc)
* Make custom version loader

[Version.md](more-apis/Version.md "mention")

* Get version information (version name, type, arguments, library list, asset id, etc)

[Installer](Installer/ "mention")

* Install Forge
* Install LiteLoader
* Install FabricMC

[FAQ.md](resources/FAQ.md "mention")

* Launch custom version
* Get game output (logs)
* log4j2

[Get-Minecraft-Changelogs.md](utilities/Get-Minecraft-Changelogs.md "mention")

[Licenses-and-Dependencies.md](resources/Licenses-and-Dependencies.md "mention")

</details>
