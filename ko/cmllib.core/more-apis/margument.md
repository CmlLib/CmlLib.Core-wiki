# MArgument

런처에서 설정한 여러 파라미터(유저 정보, 게임 디렉토리 경로, 서버 주소 등)는 게임 프로세스 실행 시 argument 목록으로 전달됩니다. 운영체제는 이 목록을 공백으로 구분하여 프로세스에 넘겨줍니다.

각 argument 문자열은 다음과 같은 특징을 가질 수 있습니다.

* `-key=value` 와 같이 `=`를 구분으로 key와 value를 가지거나, `value` 처럼 단일 값을 가질 수 있습니다.
* `--key=${template}` 와 같이, 런처가 적절한 값으로 대체할 `${template}` 형식을 포함할 수 있습니다.
* `value`에 공백이 포함될 경우, 큰따옴표로 묶습니다. (예: `--key="hello world"`, `"this value"`)

!!! info
    argument는 기본적으로 공백으로 구분되지만, 큰따옴표로 묶인 공백은 argument를 구분하지 않습니다.

    * `--username ${auth_player_name}`: 이것은 `--username`과 `${auth_player_name}` 이라는 **두 개의 argument** 입니다.
    * `-Dminecraft.launcher.brand="hello world"`: 이것은 큰따옴표로 묶여있어 공백을 포함하지만 **하나의 argument** 입니다.

`MArgument`는 이러한 argument들의 목록을 관리하는 타입입니다. `MArgument`를 초기화할 때는 반드시 각 원소에 **하나의 argument**만 포함해야 합니다.

```csharp
// MArgument는 여러 개의 개별 argument를 받아 목록을 생성합니다.
var arguments = new MArgument(["--username", "${auth_player_name}", "-Dminecraft.launcher.brand=${launcher_name}"]);

var result = arguments.InterpolateValues(new Dictionary<string, string?>
{
    ["auth_player_name"] = "hello1234",
    ["launcher_name"] = "my launcher",
});
// result: "--username", "hello1234", "-Dminecraft.launcher.brand=\"my launcher\""
```

**템플릿 치환**

CmlLib는 `InterpolateValues` 메서드를 호출하여 `${template}` 부분을 실제 값으로 자동 치환합니다. 치환된 값에 공백이 포함될 경우, 자동으로 큰따옴표를 추가해주므로 별도의 처리가 필요 없습니다.

기본적으로 제공하는 템플릿은 다음과 같습니다. 더 많은 템플릿을 등록하려면, 실행 옵션의 `ArgumentDictionary`를 설정하세요. [실행 옵션 설정](../getting-started/MLaunchOption.md)

| Template Key            | 설명                                                                                                      |
| ----------------------- | ------------------------------------------------------------------------------------------------------- |
| `library_directory`     | `launchOption.Path.Library`                                                                             |
| `natives_directory`     | `launchOption.NativesDirectory`                                                                         |
| `launcher_name`         | `launchOption.GameLauncherName`                                                                         |
| `launcher_version`      | `launchOption.GameLauncherVersion`                                                                      |
| `classpath_separator`   | 경로 구분자 (e.g., `;` 또는 `:`)                                                                               |
| `classpath`             | `-cp`                                                                                                   |
| `auth_player_name`      | 유저 이름 (`launchOption.Session.Username)`                                                                 |
| `version_name`          | 실행하는 버전의 이름                                                                                             |
| `game_directory`        | 게임 디렉토리 경로 (`launchOption.Path.BasePath`)                                                               |
| `assets_root`           | assets 디렉토리 경로 (`launchOption.Path.Assets`)                                                             |
| `assets_index_name`     | 에셋 버전 이름                                                                                                |
| `auth_uuid`             | 유저 UUID (`launchOption.Session.UUID`)                                                                   |
| `auth_access_token`     | 유저 엑세스토큰 (`launchOption.Session.AccessToken`)                                                           |
| `user_properties`       | `launchOption.UserProperties`                                                                           |
| `auth_xuid`             | 유저 XUID (`launchOption.Session.Xuid`)                                                                   |
| `clientid`              | `launchOption.ClientId`                                                                                 |
| `user_type`             | 유저 유형, 마이그레이션 이전 모장 계정일 경우 `Mojang` , 마이그레이션 이후 마이크로소프트 계정일 경우 `msa`  (`launchOption.Session.UserType`) |
| `game_assets`           | 레거시에셋 디렉토리 경로 (`launchOption.Path.GetAssetLegacyPath`)                                                  |
| `auth_session`          | 유저 엑세스토큰 (`launchOption.Session.AccessToken`)                                                           |
| `version_type`          | `launchOption.VersionType`                                                                              |
| `resolution_width`      | `launchOption.ScreenWidth`                                                                              |
| `resolution_height`     | `launchOption.ScreenHeight`                                                                             |
| `quickPlayPath`         | `launchOption.QuickPlayPath`                                                                            |
| `quickPlaySingleplayer` | `launchOption.QuickPlaySingleplayer`                                                                    |
| `quickPlayMultiplayer`  | `launchOption.ServerIp, launchOption.ServerPort`                                                        |
| `quickPlayRealms`       | `launchOption.QuickPlayRealms`                                                                          |

**조건부 Arguments (Rules)**

`MArgument`는 `Rules`를 가질 수 있어, 특정 환경에서만 argument를 활성화할 수 있습니다. 예를 들어 `-XstartOnFirstThread` argument는 macOS에서만 추가되도록 `Rules`가 설정되어 있습니다.

**단일 문자열에서 Argument 목록 파싱하기**

`MArgument` 는 단일 argument 를 가져야 합니다. 여러 argument 를 한번에 입력하면 정상적으로 작동하지 않습니다.

```csharp
// 잘못된 사용!
var arguments = new MArgument("--username ${auth_player_name} -Dminecraft.launcher.brand=${launcher_name}");
```

단일 문자열을 분리하기 위해 단순히 공백 문자로 문자열을 나누면(`string.Split(' ')`) 따옴표로 묶인 공백을 제대로 처리할 수 없습니다.

```csharp
// 잘못된 방법: Split 사용
var argumentsStr = "-Dos.name=\"Windows 10\" -version 1.0";
var splitArgs = argumentsStr.Split(' ');
// 잘못된결과: "-Dos.name=\"Windows", "10\"", "-version", "1.0"
```

이런 상황에서는 `FromCommandLine` 메서드를 사용해야 합니다. 이 메서드는 명령줄 규칙에 따라 문자열을 정확하게 파싱하여 `MArgument` 객체를 생성합니다.

```csharp
// 올바른 방법: FromCommandLine 사용
var argumentsStr = "-Dos.name=\"Windows 10\" --username \"hello 1234\"";
var arguments = MArgument.FromCommandLine(argumentsStr);
// 올바른결과: "-Dos.name=\"Windows 10\"", "--username", "hello 1234"
```
