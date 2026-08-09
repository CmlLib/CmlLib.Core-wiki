---
description: Налаштування параметрів запуску
---

# Параметри запуску

## Приклад

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
    QuickPlaySingleplayer = "назва світу",
    QuickPlayRealms = "id realm",
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
        MArgument.FromCommandLine("-Dminecraft.api.env=custom -Dminecraft.api.auth.host=[https://invalid.invalid](https://invalid.invalid) -Dminecraft.api.account.host=[https://invalid.invalid](https://invalid.invalid) -Dminecraft.api.session.host=[https://invalid.invalid](https://invalid.invalid) -Dminecraft.api.services.host=[https://invalid.invalid](https://invalid.invalid)"),
    },
    ExtraGameArguments = new MArgument[]
    {
        new MArgument("--key=value"),
        new MArgument(["--key1", "--key2", "value2"]),
    }
};
```

### Session

**Тип: MSession**

Дивіться [Вхід та сесії](../login-and-sessions/README.md), щоб дізнатися, як увійти в Minecraft та отримати ігрову сесію.

Дані ігрової сесії (ім'я користувача, UUID, AccessToken тощо). Якщо значення дорівнює null, використовується стандартна сесія з ім'ям користувача `tester123`.

### Features

**Тип: `IEnumerable<string>`**

Увімкнення додаткових функцій (features).

### JavaPath

**Тип: string**

Шлях до виконуваного файлу Java. Якщо значення дорівнює null, буде викинуто виключення `ArgumentNullException`.

### MaximumRamMb

**Тип: int**

Параметр JVM `-Xmx`. Використовується для встановлення максимального розміру купи (heap) Minecraft.
Якщо значення від'ємне, буде викинуто `ArgumentOutOfRangeException`.
Значення за замовчуванням — 2048 (2 ГБ) для x64, 1024 (1 ГБ) для інших платформ. _Примітка: Ви не можете встановити значення більше ніж 1024 при використанні 32-бітної Java._

### MinimumRamMb

**Тип: int**

Параметр JVM `-Xms`. Використовується для встановлення мінімального розміру купи (heap) Minecraft. Якщо значення від'ємне або більше за `MaximumRamMb`, буде викинуто `ArgumentOutOfRangeException`.

### DockName

**Тип: string**

Назва Minecraft у Dock на macOS. У деяких версіях macOS обов'язково потрібно задавати цей параметр. [Відомі проблеми](../resources/Common-Errors.md)

### DockIcon

**Тип: string**

Іконка Minecraft у Dock на macOS. Це має бути абсолютний шлях до файлу зображення у форматі `icns` з роздільною здатністю `256x256`.

### IsDemo

**Тип: bool**

Увімкнення функції `is_demo_user` та запуск гри у демо-режимі.

### ScreenWidth / ScreenHeight

**Тип: int**

Початковий розмір вікна Minecraft. Працює, якщо значення обох параметрів більше за 0. Якщо значення обох параметрів дорівнює 0, розмір вікна визначає сама гра. Якщо один із цих параметрів від'ємний, буде викинуто `ArgumentOutOfRangeException`. Не всі версії Minecraft підтримують цей параметр.

### FullScreen

**Тип: bool**

Запуск Minecraft у повноекранному режимі. Не всі версії Minecraft підтримують цей параметр.

### QuickPlayPath

**Тип: string**

Встановлює аргумент `QuickPlayPath`. [QuickPlay](https://minecraft.wiki/w/Quick_Play)

### QuickPlaySingleplayer

**Тип: string**

Встановлює аргумент `QuickPlaySingleplayer`. [QuickPlay](https://minecraft.wiki/w/Quick_Play)

### QuickPlayRealms

**Тип: string**

Встановлює аргумент `QuickPlayRealms`. [QuickPlay](https://minecraft.wiki/w/Quick_Play)

### ServerIp / ServerPort

**Тип: string / int**

Пряме підключення до сервера одразу після завершення завантаження Minecraft. Значення за замовчуванням для `ServerPort` — 25565. Якщо `ServerPort` не є коректним номером порту (0-65535), буде викинуто `ArgumentOutOfRangeException`. Якщо версія, що запускається, підтримує [QuickPlay](https://minecraft.wiki/w/Quick_Play), лаунчер увімкне функцію QuickPlayMultiplayer, інакше додасть аргументи `--serverIp` та `--serverPort`.

_примітка 1: Не всі версії Minecraft підтримують цей параметр._

_примітка 2: Якщо ви вкажете домен із записом SRV, з'єднання може не вдатися. Вказуйте безпосередньо реальну адресу та порт, на які вказує запис SRV._

### ClientId

**Тип: string**

`${clientid}`

### VersionType

**Тип: string**

`${version_type}`. Якщо значення дорівнює null, використовується властивість `Type` версії, що запускається. VersionType відображається у лівому нижньому кутку головного екрана. Не всі версії Minecraft підтримують це.

### GameLauncherName

**Тип: string**

`${launcher_name}`. Значення за замовчуванням — `minecraft-launcher`, що відповідає офіційному лаунчеру Mojang.

### GameLauncherVersion

**Тип: string**

`${launcher_version}`. Значення за замовчуванням — `2`, що відповідає офіційному лаунчеру Mojang.

### UserProperties

**Тип: string**

`${user_properties}`. Використовується для стрімінгу на Twitch.

### ArgumentDictionary

**Тип: `IReadOnlyDictionary<string, string>`**

Під час формування аргументів у лаунчері `${variable_name}` буде замінено на відповідне значення. Цей параметр визначає `variable_name` як ключ, а рядок для заміни — як значення.

### JVMArgumentOverrides

**Тип: `IEnumerable<MArgument>`**

Перевизначення всіх аргументів JVM. Якщо цей параметр не дорівнює null, `ExtraJVMArguments` та `JVMArguments` ігноруються.

Дивіться [MArgument](../more-apis/margument.md)

### ExtraJVMArguments

**Тип: `IEnumerable<MArgument>`**

Встановлення додаткових аргументів JVM. Дивіться [MArgument](../more-apis/margument.md)

Стандартні аргументи:

```
-XX:+UnlockExperimentalVMOptions
-XX:+UseG1GC
-XX:G1NewSizePercent=20
-XX:G1ReservePercent=20
-XX:MaxGCPauseMillis=50
-XX:G1HeapRegionSize=16M
```

### ExtraGameArguments

**Тип: `IEnumerable<MArgument>`**

Встановлення додаткових аргументів гри. Дивіться [MArgument](../more-apis/margument.md)

## Довідник API

- [MLaunchOption](https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.ProcessBuilder.MLaunchOption.html)
