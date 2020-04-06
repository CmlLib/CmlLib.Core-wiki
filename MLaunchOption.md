# MLaunchOption class

## Example

       var launchOption = new MLaunchOption()
       {
           // Required Settings
           MaximumRamMb = 4096,
           Session = MSession.GetOfflineSession("tester123"),

           // Optional Settings
           JavaPath = "javaw.exe",
           LauncherName = "CmlLauncher",
           ServerIp = "mc.hypixel.net",
           CustomJavaParameter = "",
           ScreenWidth = 1600,
           ScreenHeight = 900,

           // Only macOS
           DockName = "",
           DockIcon = "",
       };

## Properties

### MaximumRamMb

**Type: int**

Set -Xmx JVM parameter. It is used to set the maximum heap size of minecraft.  
_Note: You can't set this property exceeding 1024 in 32bit Java._

### Session

**Type: MSession**

Set username, uuid, access_token of player. It is used to connect online-mode server or realm server.
but if you use MSession.GetOfflineSession, you can't connect these servers.

### JavaPath

**Type: string**  _Optional_

Set java path. If this property was empty and call `Cml.CreateProcess`, `CreateProcess` method will set this property to `<Your Game Path>/runtime`, check java existence, and download java if it does not exists.

### LauncherName

**Type: string**  _Optional_

Show LauncherName bottom left of main menu in minecraft. Old minecraft version doesn't support this option.

### ServerIp

**Type: string**  _Optional_

Connect to server directly when minecraft loading is done. This option doesn't work in 1.15. It is bug of minecraft.

### CustomJavaParameter

**Type: string**  _Optional_

Set JVM parameter. If this property is empty, use default JVM parameter.  
Default JVM Parameter : 

    -XX:+UnlockExperimentalVMOptions 
    -XX:+UseG1GC 
    -XX:G1NewSizePercent=20 
    -XX:G1ReservePercent=20 
    -XX:MaxGCPauseMillis=50 
    -XX:G1HeapRegionSize=16M

### ScreenWidth / ScreenHeight

**Type: int**  _Optional_

Set the resolution of Minecraft. It works when value of two options is bigger than 0. If one of these option is negative, ArgumentException will be thrown. Old minecraft version doesn't support this option.

### DockName

**Type: string** _Optional_

Set dock name of minecraft. It works only in macOS. In some macOS version, you must set this option. [More Infomation](https://github.com/AlphaBs/CmlLib.Core/wiki/Common-Erros)

### DockIcon

**Type: string** _Optional_

Set dock icon of minecraft. It should be an absolute file path which of size is `256x256` and `icns` format.