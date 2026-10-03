# MArgument

Різні параметри, налаштовані в лаунчері (інформація про користувача, шлях до директорії гри, адреса сервера тощо), передаються як список аргументів під час запуску процесу гри. Операційна система передає цей список процесу, розділяючи елементи пробілами.

Кожен рядок аргументу може мати такі особливості:

* Він може мати ключ і значення, розділені знаком `=`, наприклад `-key=value`, або лише одне значення, наприклад `value`.
* Він може містити формат `${template}`, який лаунчер замінить відповідними значеннями, наприклад `--key=${template}`.
* Якщо `value` містить пробіли, воно береться в лапки (наприклад, `--key="hello world"`, `"this value"`).

!!! info "Розділення аргументів"
    Аргументи зазвичай розділяються пробілами, але пробіли всередині лапок не розділяють аргументи.

    * `--username ${auth_player_name}`: це **два аргументи**: `--username` та `${auth_player_name}`.
    * `-Dminecraft.launcher.brand="hello world"`: це **один аргумент**, хоча він і містить пробіли, оскільки береться в лапки.

`MArgument` — це тип, який керує списком таких аргументів. Під час ініціалізації `MArgument` кожен елемент повинен містити **лише один аргумент**.

```csharp
// MArgument приймає кілька окремих аргументів для створення списку
var arguments = new MArgument(["--username", "${auth_player_name}", "-Dminecraft.launcher.brand=${launcher_name}"]);

var result = arguments.InterpolateValues(new Dictionary<string, string?>
{
    ["auth_player_name"] = "hello1234",
    ["launcher_name"] = "my launcher",
});
// result: "--username", "hello1234", "-Dminecraft.launcher.brand=\"my launcher\""
```

**Підстановка шаблонів**

CmlLib автоматично замінює частини `${template}` актуальними значеннями шляхом виклику методу `InterpolateValues`. Якщо підставлене значення містить пробіли, він автоматично додає лапки, тому додаткова обробка не потрібна.

За замовчуванням надаються такі шаблони. Щоб зареєструвати більше шаблонів, встановіть `ArgumentDictionary` у параметрах запуску. Дивіться [MLaunchOption.md](../getting-started/MLaunchOption.md)

| Ключ шаблону | Опис |
| --- | --- |
| `library_directory` | `launchOption.Path.Library` |
| `natives_directory` | `launchOption.NativesDirectory` |
| `launcher_name` | `launchOption.GameLauncherName` |
| `launcher_version` | `launchOption.GameLauncherVersion` |
| `classpath_separator` | Роздільник шляхів (наприклад, `;` або `:`) |
| `classpath` | `-cp` |
| `auth_player_name` | Ім'я користувача (`launchOption.Session.Username`) |
| `version_name` | Назва версії, що запускається |
| `game_directory` | Шлях до директорії гри (`launchOption.Path.BasePath`) |
| `assets_root` | Шлях до директорії асетів (`launchOption.Path.Assets`) |
| `assets_index_name` | Назва версії асетів |
| `auth_uuid` | UUID користувача (`launchOption.Session.UUID`) |
| `auth_access_token` | Токен доступу користувача (`launchOption.Session.AccessToken`) |
| `user_properties` | `launchOption.UserProperties` |
| `auth_xuid` | XUID користувача (`launchOption.Session.Xuid`) |
| `clientid` | `launchOption.ClientId` |
| `user_type` | Тип користувача, `Mojang` для облікових записів Mojang (до міграції), `msa` для облікових записів Microsoft (після міграції) (`launchOption.Session.UserType`) |
| `game_assets` | Шлях до застарілої директорії асетів (`launchOption.Path.GetAssetLegacyPath`) |
| `auth_session` | Токен доступу користувача (`launchOption.Session.AccessToken`) |
| `version_type` | `launchOption.VersionType` |
| `resolution_width` | `launchOption.ScreenWidth` |
| `resolution_height` | `launchOption.ScreenHeight` |
| `quickPlayPath` | `launchOption.QuickPlayPath` |
| `quickPlaySingleplayer` | `launchOption.QuickPlaySingleplayer` |
| `quickPlayMultiplayer` | `launchOption.ServerIp, launchOption.ServerPort` |
| `quickPlayRealms` | `launchOption.QuickPlayRealms` |

**Умовні аргументи (Rules)**

`MArgument` може мати правила (`Rules`) для активації аргументів лише у певних середовищах. Наприклад, аргумент `-XstartOnFirstThread` має налаштовані `Rules`, щоб додаватися лише на macOS.

**Парсинг списку аргументів з одного рядка**

`MArgument` повинен містити лише один аргумент. Якщо ввести кілька аргументів одночасно, це працюватиме некоректно.

```csharp
// Неправильне використання!
var arguments = new MArgument("--username ${auth_player_name} -Dminecraft.launcher.brand=${launcher_name}");
```

Просте розділення рядка за допомогою пробілів (`string.Split(' ')`) не може належним чином обробити пробіли в лапках.

```csharp
// Неправильний метод: використання Split
var argumentsStr = "-Dos.name=\"Windows 10\" -version 1.0";
var splitArgs = argumentsStr.Split(' ');
// Неправильний результат: "-Dos.name=\"Windows", "10\"", "-version", "1.0"
```

У таких випадках слід використовувати метод `FromCommandLine`. Цей метод розбирає рядки відповідно до правил командного рядка та створює об'єкт `MArgument`.

```csharp
// Правильний метод: використання FromCommandLine
var argumentsStr = "-Dos.name=\"Windows 10\" --username \"hello 1234\"";
var arguments = MArgument.FromCommandLine(argumentsStr);
// Правильний результат: "-Dos.name=\"Windows 10\"", "--username", "hello 1234"
```
