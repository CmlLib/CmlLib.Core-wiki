---
description: 'Вхід, вихід та управління обліковими записами в Minecraft: Java Edition'
---

# CmlLib.Core.Auth.Microsoft

## Встановлення

Встановіть NuGet-пакет [CmlLib.Core.Auth.Microsoft](https://www.nuget.org/packages/CmlLib.Core.Auth.Microsoft)

```bash
dotnet add package CmlLib.Core.Auth.Microsoft
```

## Початок роботи

```csharp
using CmlLib.Core.Auth.Microsoft;

var loginHandler = JELoginHandlerBuilder.BuildDefault();
var session = await loginHandler.Authenticate();
```

Встановіть властивість `Session` у [Параметрах запуску](../../cmllib.core/getting-started/MLaunchOption.md).

## Приклади

[CmlLib-Minecraft-Launcher](https://github.com/CmlLib/CmlLib-Minecraft-Launcher): Приклад лаунчера на базі CmlLib.Core та CmlLib.Core.Auth.Microsoft.

[WinFormTest](https://github.com/CmlLib/CmlLib.Core.Auth.Microsoft/blob/dev/examples/WinFormTest)

[ConsoleTest](https://github.com/CmlLib/CmlLib.Core.Auth.Microsoft/blob/dev/examples/ConsoleTest/Program.cs)

## Використання

### [JELoginHandler](jeloginhandler.md)

Вхід, вихід та управління обліковими записами.

### [JELoginHandlerBuilder](jeloginhandlerbuilder.md)

Будівельник (builder) для ініціалізації екземпляра `JELoginHandler`.

### [AccountManager](../xboxauthnet.game/accountmanager.md)

Управління списком облікових записів.
