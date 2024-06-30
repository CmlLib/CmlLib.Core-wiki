---
description: Set launch options
---

# Launch Options

## Example

```csharp
var launchOption = new MLaunchOption 
{
    Session = MSession.CreateOfflineSession("gamer123"),
    Features = new string[] { "feature_name" },

    JavaPath = "javaw.exe",
    MaximumRamMb = 4096,
    MinimumRamMb = 1024,
    DockName = "Minecraft",
    DockIcon = "/path/icon.icns",

    IsDemo = false,
    ScreenWidth = 1600,
    ScreenHeight = 900,
    FullScreen = false,
    QuickPlayPath = "/path/quickplay",
    QuickPlaySingleplayer = "world name",
    QuickPlayRealms = "realm id",
    ServerIp = "mc.hypixel.net",
    ServerPort = 25565,

    ClientId = "clientid",
    VersionType = "CmlLib",
    GameLauncherName = "CmlLib",
    GameLauncherVersion = "2",
    UserProperties = "{}",

    ArgumentDictionary = new Dictionary<string, string>
    {
        { "key", "value" },
        { "auth_xuid", "12345678" }
    },
    JvmArgumentOverrides = new MArgument[]
    {
        new MArgument("--key=value")
    },
    ExtraJvmArguments = new MArgument[]
    {
        new MArgument("--key=value")
    },
    ExtraGameArguments = new MArgument[]
    {
        new MArgument("--key=value"),
        new MArgument("--disableMultiplayer")
    }
};
```

### Session

**Type: MSession**

See [login-and-sessions](../login-and-sessions/ "mention") for how to log in Minecraft and get game session.

Game session (Username, UUID, AccessToken, etc...). If the value is null, the default session is used. (username `tester123`)

### Features

**Type: IEnumerable\<string>**

Enable features.

### JavaPath

**Type: string**

Java binary path. If the value is null, `ArgumentNullException` is thrown.

### MaximumRamMb

**Type: int**

`-Xmx` JVM parameter. It is used to set the maximum heap size of Minecraft.\
If the value is a negative value, `ArgumentOutOfRangeException` is thrown.\
The default value is 2048 (2GB) for X64, 1024 (1GB) for other platforms. _Note: You can't set this property to any number higher than 1024 when using 32bit Java._

### MinimumRamMb

**Type: int**

`-Xms` JVM parameter. It is used to set the minimum heap size of Minecraft. If the value is a negative value or greater than `MaximumRamMb`, `ArgumentOutOfRangeException` is thrown.

### DockName

**Type: string**

macOS dock name of Minecraft. In some macOS versions, you must set this option. [Common-Errors.md](../resources/Common-Errors.md "mention")

### DockIcon

**Type: string**

macOS dock icon of minecraft. It should be an absolute file path to an image that has the dimensions `256x256` and is of the `icns` format.

### IsDemo

**Type: bool**

Enable `is_demo_user` feature and launch a game in demo version.

### ScreenWidth / ScreenHeight

**Type: int**

Initial window size of Minecraft. It works if the value of the two options is greater than 0. If the value of both options is 0, let the game decide the window size. If one of these options is negative, `ArgumentOutOfRangeException` will be thrown. Not all versions of Minecraft support this option.

### FullScreen

**Type: bool**

Launch Minecraft as full screen. Not all versions of Minecraft support this option.

### QuickPlayPath

**Type: string**

Set `QuickPlayPath` argument. [QuickPlay](https://minecraft.wiki/w/Quick\_Play)

### QuickPlaySingleplayer

**Type: string**

Set `QuickPlaySingleplayer` argument. [QuickPlay](https://minecraft.wiki/w/Quick\_Play)

### QuickPlayRealms

**Type: string**

Set `QuickPlayRealms` argument. [QuickPlay](https://minecraft.wiki/w/Quick\_Play)

### ServerIp / ServerPort

**Type: string / int**

Connecting to a server directly when Minecraft is loading is done. The default value of `ServerPort` is 25565. If `ServerPort` is not a valid port number (0-65535), `ArgumentOutOfRangeException` is thrown. If the starting version supports [QuickPlay](https://minecraft.wiki/w/Quick\_Play), the launcher will enable QuickPlayMultiplayer feature, otherwise the launcher will append `--serverIp` and `--serverPort` arguments.

_note1: Not all versions of Minecraft support this option._

_note2: The game would not be able to resolve the address if you pass a domain with an SRV record._

### ClientId

**Type: string**

`${clientid}`

### VersionType

**Type: string**

`${version_type}`. If the value is null, the `Type` property of the starting version is used. VersionType is displayed in the lower left corner of the main screen. Not all versions of Minecraft support this.

### GameLauncherName

**Type: string**

`${launcher_name}`. The default value is `minecraft-launcher` , which is the same as the Mojang launcher.

### GameLauncherVersion

**Type: string**

`${launcher_version}`. The default value is `2`, which is the same as the Mojang launcher.

### UserProperties

**Type: string**

`${user_properties}`. for Twitch livestreaming

### ArgumentDictionary

**Type: IReadOnlyDictionary\<string, string>**

When building an argument in the launcher, `${variable_name}` will be replaced with the appropriate value. This option specifies `variable_name` as the key and the string to be replaced as the value.

### JVMArgumentOverrides

**Type: IEnumerable\<MArgument>**

Override all JVM arguments. When this option is not null, `ExtraJVMArguments` and `JVMArguments` are ignored.

### ExtraJVMArguments

**Type: IEnumerable\<MArgument>**

Set extra JVM arguments. Default arguments are:

```
-XX:+UnlockExperimentalVMOptions
-XX:+UseG1GC
-XX:G1NewSizePercent=20
-XX:G1ReservePercent=20
-XX:MaxGCPauseMillis=50
-XX:G1HeapRegionSize=16M
```

### ExtraGameArguments

**Type: IEnumerable\<MArgument>**

Set extra game arguments.
