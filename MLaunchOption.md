# MLaunchOption class

## Example

       var launchOption = new MLaunchOption()
       {
           // Required Settings
           StartVersion = myversion,
           Session = MSession.GetOfflineSession("tester123"),

           // Optional Settings
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

## Properties

### StartVersion

**Type: MVersion**

The version you want to launch. If you launch game using CMLauncher, you don't have to set this property. CMLauncher will automatically get version and set this.

### MaximumRamMb

**Type: int**

Set -Xmx JVM parameter. It is used to set the maximum heap size of minecraft.  
If the value of this property is less than 1, `ArgumentException` will be thrown.  
_Note: You can't set this property exceeding 1024 in 32bit Java._

### Session

**Type: MSession**

Set username, uuid, access_token of player. It is used to connect to online-mode server or realm server.
but if you use MSession.GetOfflineSession, you can't connect these servers.
If the value of this property is null, `ArgumentException` will be thrown. 

### JavaPath

**Type: string**  _Optional_

Set java path. If this property was empty and call `Cml.CreateProcess`, `CreateProcess` method will set this property to `<Your Game Path>/runtime`, check java existence, and download java if it does not exist.

### VersionType

**Type: string**  _Optional_

Set ${version_type}. Empty value will set ${version_type} to `TypeStr` property of `MProfile` class.       
VersionType will be shown bottom left of main menu in minecraft. Old minecraft version doesn't support this option.

### GameLauncherName

**Type: string**  _Optional_

Set ${launcher_name}. Empty value will set ${launcher_name} to `minecraft-launcher`, same as default value of mojang launcher.

### GameLauncherVersion

**Type: string**  _Optional_

Set ${launcher_version}. Empty value will set ${launcher_name} to `2`, same as default value of mojang launcher.

### ServerIp

**Type: string**  _Optional_

Connect to server directly when minecraft loading is done.   
This option doesn't work in 1.15. It is bug of minecraft.

### ServerPort

**Type: int**  _Optional_

Set server port of `ServerIp` property. default value is 25565.

### JVMArguments

**Type: string[]**  _Optional_

Set JVM parameter. If this property is `null`, use default JVM parameter.  
Default JVM Parameter : 

    -XX:+UnlockExperimentalVMOptions, 
    -XX:+UseG1GC, 
    -XX:G1NewSizePercent=20, 
    -XX:G1ReservePercent=20, 
    -XX:MaxGCPauseMillis=50, 
    -XX:G1HeapRegionSize=16M

### ScreenWidth / ScreenHeight

**Type: int**  _Optional_

Set the resolution of Minecraft. It works when value of two options is bigger than 0. Old minecraft version doesn't support this option.  
If one of these option is negative, `ArgumentException` will be thrown. 

### FullScreen

**Type: bool** _Optional_

If this property is true, minecraft will turn on FullScreen option. (not permanently) Old minecraft version doesn't support this option.  

### DockName

**Type: string** _Optional_

Set dock name of minecraft. It works only in macOS. In some macOS version, you must set this option. [More Infomation](https://github.com/AlphaBs/CmlLib.Core/wiki/Common-Erros)

### DockIcon

**Type: string** _Optional_

Set dock icon of minecraft. It should be an absolute file path which of size is `256x256` and `icns` format.