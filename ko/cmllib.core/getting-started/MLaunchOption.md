---
description: MLaunchOption 클래스
---

# 실행 옵션 설정

## 예제

```csharp
var launchOption = new MLaunchOption()
{
    StartVersion = myversion,
    Session = MSession.GetOfflineSession("tester123"),

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

실행하려는 버전. `CMLauncher` 를 통해 게임을 실행하려는 경우 이 속성을 설정할 필요가 없습니다. `CMLauncher` 에서 자동으로 설정합니다.

### Session

**Type: MSession** _선택_

[login-and-sessions](../login-and-sessions/ "mention") 에서 마인크래프트에 로그인하고 세션을 가져오는 방법을 확인하세요.

플레이어의 유저이름, UUID, 엑세스토큰을 설정합니다. 렐름 서버나 정품 서버에 접속하기 위해서 사용됩니다. `MSession.GetOfflineSession` 으로 만든 세션은 정품 서버에 접속할 수 없습니다. `null` 을 설정한 경우 `ArgumentException` 예외가 발생합니다.

### Path

**Type: MinecraftPath** _선택_

실행할 폴더. `CMLauncher` 를 사용하는 경우 이 속성을 설정하지 않아도 됩니다.

### JavaVersion

**Type: string** _선택_

자바 버전. 설정이 없으면 [FileChecker.md](../more-apis/FileChecker.md "mention") 가 자동으로 결정합니다.

### JavaPath

**Type: string** _선택_

자바 경로. 설정이 없으면 [FileChecker.md](../more-apis/FileChecker.md "mention") 가 자동으로 결정합니다.

### MaximumRamMb

**Type: int** _선택_

`-Xmx` 파라미터. 게임에서 사용하는 최대 힙 사이즈를 제한.\
만약 이 속성의 값이 1보다 작다면 `ArgumentException` 예외가 발생합니다.\
기본값은 1024. (1 GB)\
_Note: 32bit 자바에서는 이 속성은 1024보다 높게 설정할 수 없습니다._

### MinimumRamMb

**Type: int** _선택_

`-Xms` 파라미터. 게임에서 사용하는 최소 힙 사이즈를 제한.\
만약 이 속성을 `MaximumRamMb` 보다 크게 설정하면 `ArgumentException` 예외가 발생합니다.

### VersionType

**Type: string** _선택_

`${version_type}` 설정. 이 속성을 설정하지 않으면 `${version_type}` 는 실행할 `MVersion` 의 `TypeStr` 속성으로 설정됩니다.\
이 속성을 설정할 경우 마인크래프트 메인 화면의 왼쪽 아래에 속성의 값이 표시됩니다. 모든 마인크래프트 버전이 이 옵션을 지원하지는 않습니다.

### GameLauncherName

**Type: string** _선택_

`${launcher_name}` 설정. 기본값은 `minecraft-launcher` 이며 이 값은 모장 런처가 사용하는 값과 동일합니다.

### GameLauncherVersion

**Type: string** _선택_

`${launcher_version}` 설정. 기본값은 `2` 입니다.

### ServerIp

**Type: string** _선택_

마인크래프트 로딩이 끝나면 설정한 서버 주소로 즉시 접속합니다.\
SRV 레코드를 사용할 경우 접속이 되지 않을 수 있습니다.

### ServerPort

**Type: int** _선택_

`ServerIp` 속성을 설정하는 경우 접속할 포트를 선택합니다. 기본값은 25565 입니다.\
값 범위 : `0-65535`

### JVMArguments

**Type: string\[]** _선택_

JVM 파라미터. 이 속성이 `null` 일 경우 기본 JVM 파라미터를 선택합니다.\
기본 JVM 파라미터:

```
-XX:+UnlockExperimentalVMOptions,
-XX:+UseG1GC,
-XX:G1NewSizePercent=20,
-XX:G1ReservePercent=20,
-XX:MaxGCPauseMillis=50,
-XX:G1HeapRegionSize=16M
```

### ScreenWidth / ScreenHeight

**Type: int** _선택_

마인크래프트 창의 해상도를 설정합니다. 창 해상도 설정은 두 속성이 모두 0보다 커야 작동합니다. 옛날 버전의 경우 작동하지 않습니다.\
두 값이 모두 0일 경우, 마인크래프트가 스스로 창 크기를 결정하도록 합니다.\
두 속성 중 하나라도 음수일 경우, `ArgumentException` 이 발생합니다.

### FullScreen

**Type: bool** _선택_

이 속성이 `true` 인 경우, 마인크래프트가 전체 화면으로 실행됩니다. 옛날 버전과 일부 포지 버전의 경우 이 옵션을 지원하지 않습니다.

### DockName

**Type: string** _선택_

macOS 의 dock name 을 설정합니다. 일부 macOS 버전의 경우, 반드시 이 옵션을 설정해야 합니다. [Common-Errors.md](../resources/Common-Errors.md "mention")

### DockIcon

**Type: string** _선택_

macOS 의 dock icon 을 설정합니다. 이 속성의 값은 `icns` 포맷의 `256x256` 사이즈를 가진 이미지 파일의 절대 경로로 설정해야 합니다.
