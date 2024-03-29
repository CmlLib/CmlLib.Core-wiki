# 알려진 문제

### Offline session 사용 후 게임 크래쉬 (1.20\~)

Use below code to create offline session.

```csharp
public static MSession CreateFakeSession(string username)
{
    return new MSession
    {
        Username = username,
        UUID = "2749420bc7a54b05ab622b34e61b8a79", // fake UUID
        AccessToken = "accesstoken", // fake access token
        UserType = "Mojang"
    };
}

// usage:
// var session = CreateFakeSession("username123");
```

[ref](https://github.com/CmlLib/CmlLib.Core/issues/88)

### \`ServerIP\` 옵션과 함께 게임 실행 시 로딩 스크린에서 텍스쳐 깨짐

* [\[BUG\] When i provide server ip and port for auto connect to server on startup, the background does not load in 1.16.5 OptiFine](https://github.com/CmlLib/CmlLib.Core/issues/93)
* Game crashed with texture related error message in 'Connecting...' loading screen.

Unfortunately, These bugs are Minecraft's bug. We can't fix.

### 비활성화된 '멀티플레이'  버튼, Not authenticated with Minecraft.net

Your xbox account would block multiplay feature. Check your account settings. [More Informations](https://support.xbox.com/ko-KR/help/family-online-safety/online-safety/manage-a-members-safety-settings-to-access-minecraft-features)

### 1.16.4 와 1.16.5 에서 Offline session 사용시 비활성화된 '멀티플레이' 버튼

[https://github.com/CmlLib/CmlLib.Core/issues/85](https://github.com/CmlLib/CmlLib.Core/issues/85)

### Cannot find version \<version\_name>

Make sure that Mojang launcher can find your version and launch your version without any problem. CmlLib.Core will not able to find or launch the version which Mojang launcher can't.

If this exception throws even target version is in versions directory (default: `<Your Minecraft Path>/versions`), check version directory name, version json file file, and `id` property is all same.\
For example, assume you want to launch your own version named `myversion`. your version json file should be in `versions/myversion/myversion.json` and the `id` property of `myversion.json` should be `myversion`. so directory name `myversion` and the json file name `myversion.json` and the value of `id` property `myversion` is all same.

If the launcher still throw this exception, call `launcher.GetAllVersions()` method before `launcher.CreateProcess`.\
If you add new version into the version directory after the launcher is initialized, you should update version list through `GetAllVersions()` or `GetAllVersionsAsync()` method.

### Could not create Java Virtual Machine

In a 32-bit JVM, There is limit on `MaximumRamMb`.\
Recommended value of `MaximumRamMb` on 32-bit JVM is `1024`.\
[More information](https://stackoverflow.com/questions/1434779/maximum-java-heap-size-of-a-32-bit-jvm-on-a-64-bit-os/7019624#7019624)

### Error: could not open jvm.cfg

Reinstall Java.\
if your launcher uses `MJava` or `JavaChecker`, Remove the runtime directory (default: `<Your Minecraft Path>/runtime`) and install java again.

### SRV Record and `ServerIP`

Some version of Minecraft cannot connect to server which has a SRV record when you use direct server connection feature (MLaunchOption.ServerIP).

### Can't access the Minecraft window (macOS)

You have to set DockName and DockIcon in LaunchOption.\
If DockName is empty, you can't click or access the Minecraft window.

Example:

```csharp
var launchOption = new MLaunchOption
{
    MaximumRamMb = 1024,
    Session = session, 
    DockName = "Minecraft"
};
```

On macOS Catalina, Minecraft works normally without the above options. Old macOS versions don't work well.

### Java runtime error with OpenJDK 11 (macOS)

Old Minecraft versions don't support OpenJDK 11.

### Java runtime error with OpenJDK 11 (Linux)

Use Java 8. Old Minecraft versions don't support OpenJDK 11.

To install Java 8, type the following lines in terminal:

```
sudo apt-get update
sudo apt-get install openjdk-8-jre
```

To make sure it worked, type `java -version`. It should return `java version "1.8.0_~~~"`.
