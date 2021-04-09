# MLaunchOption class

## Example

```csharp
var launchOption = new MLaunchOption()
{
    // Required Settings
    StartVersion = myversion,
    Session = MSession.GetOfflineSession("tester123"),

    // Optional Settings
    Path = new MinecraftPath(),
    MaximumRamMb = 4096,
    JavaPath = "javaw.exe",
    JVMArguments = new string[] { },

    ServerIp = "mc.hypixel.net",
    ServerPort = 25565,

    ScreenWidth = 1600,
    ScreenHeight = 900,

    VersionType = "CmlLauncher",
    GameLauncherName = "CmlLauncher",
    GameLauncherVersion = "2",

    FullScreen = false,

    // Only macOS
    DockName = "",
    DockIcon = "",
};
```

## Properties

### StartVersion

**Type: MVersion**

The version you want to launch. If you launch the game using `CMLauncher`, you don't have to set this property. `CMLauncher` will automatically get the version and set this.

### Session

**Type: MSession**

Set the username, uuid, and access_token of the player. It is used to connect to an online-mode server or a realm.
However, if you use `MSession.GetOfflineSession`, you can't connect these servers.
If the value of this property is null, an `ArgumentException` will be thrown.

### Path

**Type: MinecraftPath** _Optional_

Set base directory for launching. You should not set this property if you use `CMLauncher`.

### JavaPath

**Type: string** _Optional_

Sets the java path. If this property is empty and you call `CMLauncher.CreateProcess`, the `CreateProcess` method will set this property to `<Your Game Path>/runtime`, makes sure Java is installed, and downloads Java if it doesn't exist.

### MaximumRamMb

**Type: int** _Optional_

Sets the `-Xmx` JVM parameter. It is used to set the maximum heap size of Minecraft.  
If the value of this property is less than 1, `ArgumentException` will be thrown.  
The default value is 1024. (1 GB)
_Note: You can't set this property to any number higher than 1024 when using 32bit Java._

### MinimumRamMb

**Type: int** _Optional_

Sets the `-Xms` JVM parameter. It is used to set the minimum heap size of Minecraft.  
If you set this property higher than `MaximumRamMb`, `ArgumentException` will be thrown.

### VersionType

**Type: string** _Optional_

Sets `${version_type}`. An empty value will set `${version_type}` to the `TypeStr` property of the `MVersion` class.  
VersionType will be shown bottom left of main menu in minecraft. Old minecraft version doesn't support this option.

### GameLauncherName

**Type: string** _Optional_

Sets `${launcher_name}`. An empty value will set `${launcher_name}` to `minecraft-launcher`, which is the same as the default value of the Mojang launcher.

### GameLauncherVersion

**Type: string** _Optional_

Sets `${launcher_version}`. An empty value will set `${launcher_name}` to `2`, which is the same as the default value of the Mojang launcher.

### ServerIp

**Type: string** _Optional_

Connecting to a server directly when Minecraft is loading is done.  
This option doesn't work in 1.15. It's a Minecraft bug.

### ServerPort

**Type: int** _Optional_

Sets the server port of the `ServerIp` property. The default value is 25565.
Valid range : `0-65535`

### JVMArguments

**Type: string[]** _Optional_

Sets the JVM parameters. If this property is `null`, the launcher uses the default JVM parameters.  
Default JVM parameters:

    -XX:+UnlockExperimentalVMOptions,
    -XX:+UseG1GC,
    -XX:G1NewSizePercent=20,
    -XX:G1ReservePercent=20,
    -XX:MaxGCPauseMillis=50,
    -XX:G1HeapRegionSize=16M

### ScreenWidth / ScreenHeight

**Type: int** _Optional_

Sets the resolution of Minecraft. It works when value of the two options is bigger than 0. Old Minecraft versions don't support these options.  
If value of the two options is 0, use default setting of minecraft.
If one of these options is negative, `ArgumentException` will be thrown.

### FullScreen

**Type: bool** _Optional_

If this property is true, Minecraft will be fullscreen (not permanently).  
Old Minecraft versions don't support this option.  
Some forge versions also don't support this option.

### DockName

**Type: string** _Optional_

Sets the macOS dock name of Minecraft. In some macOS versions, you must set this option. [More Infomation](https://github.com/CmlLib/CmlLib.Core/wiki/Common-Errors)

### DockIcon

**Type: string** _Optional_

Sets the macOS dock icon of minecraft. It should be an absolute file path to an image that has the dimensions `256x256` and is of the `icns` format.
