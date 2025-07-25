---
description: MLaunchOption 클래스
---

# 실행 옵션 설정

## 예제

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
        new MArgument("--key=value"),
        MArgument.FromCommandLine("-Dminecraft.api.env=custom -Dminecraft.api.auth.host=https://invalid.invalid -Dminecraft.api.account.host=https://invalid.invalid -Dminecraft.api.session.host=https://invalid.invalid -Dminecraft.api.services.host=https://invalid.invalid"),
    },
    ExtraGameArguments = new MArgument[]
    {
        new MArgument("--key=value"),
        new MArgument(["--key1", "--key2", "value2"]),
    }
};
```

### Session <a href="#session" id="session"></a>

**Type: MSession**

[login-and-sessions](../login-and-sessions/ "mention")을 참고하여 마인크래프트에 로그인하는 방법과 게임 세션을 가져오는 방법을 확인하세요.

게임 세션 (Username, UUID, AccessToken, 등등). null 이 설정될 경우, 기본값으로 유저네임 `tester123` 이 설정됩니다.

### Features <a href="#features" id="features"></a>

**Type: IEnumerable\<string>**

Enable features.

### JavaPath <a href="#javapath" id="javapath"></a>

**Type: string**

자바 바이너리 경로. null 이 설정될 경우 `ArgumentNullException` 이 발생합니다.

### MaximumRamMb <a href="#maximumrammb" id="maximumrammb"></a>

**Type: int**

`-Xmx` JVM 파라미터. 마인크래프트의 최대 힙 사이즈를 지정합니다. 만약 음수가 설정되면 `ArgumentOutOfRangeException` 이 발생합니다. 기본값은 X64 에서 2048 (2GB), X86 에서 1024 (1GB) 입니다.

참고: 32bit 자바를 사용할 경우 이 값을 1024 보다 크게 설정할 수 없습니다.

### MinimumRamMb <a href="#minimumrammb" id="minimumrammb"></a>

**Type: int**

`-Xms` JVM 파라미터. 마인크래프트의 최소 힙 사이즈를 지정합니다. 만약 음수가 설정되거나 `MaximumRamMb` 보다 큰 값이 설정되면 `ArgumentOutOfRangeException` 이 발생합니다.

### DockName <a href="#dockname" id="dockname"></a>

**Type: string**

macOS 에서의 Minecraft dock name. 일부 macOS 버전에서는 이 옵션을 반드시 설정해야 합니다. [Common-Errors.md](../resources/Common-Errors.md "mention")

### DockIcon <a href="#dockicon" id="dockicon"></a>

**Type: string**

macOS 에서의 Minecraft dock icon. `256x256` 크기와 `icns` 포멧을 가진 이미지 파일의 절대 경로를 나타냅니다.

### IsDemo <a href="#isdemo" id="isdemo"></a>

**Type: bool**

`is_demo_user` 기능을 활성화하고 게임을 데모 버전으로 실행합니다.

모든 버전이 이 옵션을 지원하지는 않습니다.

### ScreenWidth / ScreenHeight <a href="#screenwidth-screenheight" id="screenwidth-screenheight"></a>

**Type: int**

Minecraft 창 크기 설정. 두 옵션 모두 0보다 큰 값으로 설정될 경우 활성화됩니다. 만약 두 옵션 모두 0이라면게임에서 창 크기를 직접 정합니다. 만약 두 옵션의 값에 음수가 있을 경우 `ArgumentOutOfRangeException` 이 발생합니다.&#x20;

모든 버전이 이 옵션을 지원하지는 않습니다.

### FullScreen <a href="#fullscreen" id="fullscreen"></a>

**Type: bool**

Minecraft 를 전체 화면으로 실행합니다.&#x20;

모든 버전이 이 옵션을 지원하지는 않습니다.

### QuickPlayPath <a href="#quickplaypath" id="quickplaypath"></a>

**Type: string**

`QuickPlayPath` 인수설정. [QuickPlay](https://minecraft.wiki/w/Quick_Play)&#x20;

모든 버전이 이 옵션을 지원하지는 않습니다.

### QuickPlaySingleplayer <a href="#quickplaysingleplayer" id="quickplaysingleplayer"></a>

**Type: string**

`QuickPlaySingleplayer` 인수 설정. [QuickPlay](https://minecraft.wiki/w/Quick_Play)

모든 버전이 이 옵션을 지원하지는 않습니다.

### QuickPlayRealms <a href="#quickplayrealms" id="quickplayrealms"></a>

**Type: string**

`QuickPlayRealms` 인수  설정. [QuickPlay](https://minecraft.wiki/w/Quick_Play)

모든 버전이 이 옵션을 지원하지는 않습니다.

### ServerIp / ServerPort <a href="#serverip-serverport" id="serverip-serverport"></a>

**Type: string / int**

게임 로딩이 끝나면 지정한 서버로 즉시 접속합니다. `ServerPort` 의 기본값은 25565 입니다. 만약 `ServerPort` 의 값이 올바른 포트 번호 (0-65535) 가 아니라면, `ArgumentOutOfRangeException` 예외가 발생합니다. 만약 실행할 버전이 [QuickPlay](https://minecraft.wiki/w/Quick_Play) 를 지원한다면, `QuickPlayMultiplayer` 기능을 활성화하고, 지원하지 않는 버전이라면 `--serverIp` 와 `--serverPort` 파라미터를 추가합니다.

참고1: 모든 버전이 이 옵션을 지원하지는 않습니다.

참고2: SRV 레코드를 가진 도메인을 설정할 경우 접속에 실패할 수 있습니다. SRV 레코드가 가리키는 실제 주소와 포트를 직접 설정하세요.

### ClientId <a href="#clientid" id="clientid"></a>

**Type: string**

`${clientid}`

### VersionType <a href="#versiontype" id="versiontype"></a>

**Type: string**

`${version_type}`. null 이 설정된 경우 실행할 버전의 `Type` 속성이 사용됩니다. 설정한 `VersionType` 은 게임 메인화면의 좌측 하단에 표시됩니다.

모든 버전이 이 옵션을 지원하지는 않습니다.

### GameLauncherName <a href="#gamelaunchername" id="gamelaunchername"></a>

**Type: string**

`${launcher_name}`. 기본값은 모장 런처와 같은`minecraft-launcher` 입니다.

### GameLauncherVersion <a href="#gamelauncherversion" id="gamelauncherversion"></a>

**Type: string**

`${launcher_version}`. 기본값은 모장 런처와 같은 `2` 입니다.

### UserProperties <a href="#userproperties" id="userproperties"></a>

**Type: string**

`${user_properties}`. 트위치 라이브스트리밍 기능

### ArgumentDictionary <a href="#argumentdictionary" id="argumentdictionary"></a>

**Type: IReadOnlyDictionary\<string, string>**

런처에서 실행 인수를 만드는 과정에서 `${variable_name}` 템플릿은 다른 문자열로 치환됩니다. 이 옵션은 `variable_name` 을 키로, 치환될 문자열을 값으로 하는 키-값 컬렉션을 지정합니다.&#x20;

### JVMArgumentOverrides <a href="#jvmargumentoverrides" id="jvmargumentoverrides"></a>

**Type: IEnumerable\<MArgument>**

모든 JVM argument 를 이 옵션의 값으로 덮어씌웁니다. 이 옵션이 설정된 경우 `ExtraJVMArguments` 와 `JVMArguments` 의 값은 무시됩니다.

[margument.md](../more-apis/margument.md "mention") 참고

### ExtraJVMArguments <a href="#extrajvmarguments" id="extrajvmarguments"></a>

**Type: IEnumerable\<MArgument>**

추가 JVM argument 를 지정합니다. [margument.md](../more-apis/margument.md "mention") 참고

기본값은 다음과 같습니다:

```
-XX:+UnlockExperimentalVMOptions
-XX:+UseG1GC
-XX:G1NewSizePercent=20
-XX:G1ReservePercent=20
-XX:MaxGCPauseMillis=50
-XX:G1HeapRegionSize=16M
```

### ExtraGameArguments <a href="#extragamearguments" id="extragamearguments"></a>

**Type: IEnumerable\<MArgument>**

추가 game argument 를 지정합니다. [margument.md](../more-apis/margument.md "mention") 참고
