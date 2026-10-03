---
description: Будівельник (builder) для ініціалізації JELoginHandler
---

# JELoginHandlerBuilder

```csharp
// Створення зі стандартними параметрами
var loginHandler = JELoginHandlerBuilder.BuildDefault();
```

```csharp
// Створення з налаштованими параметрами
var loginHandler = new JELoginHandlerBuilder()
    .WithHttpClient(httpClient)
    .WithAccountManager("accounts.json")
    //.WithAccountManager(new InMemoryXboxGameAccountManager(JEGameAccount.FromSessionStorage))
    .Build();
var session = await loginHandler.Authenticate();
```

### WithHttpClient

Встановлює `HttpClient`. Усі HTTP-запити будуть оброблятися через нього.

### WithAccountManager

Встановлює `IXboxGameAccountManager`, який використовуватиме `JELoginHandler`. За замовчуванням використовується `JsonXboxGameAccountManager` із файлом `<ШЛЯХ-ДО-MINECRAFT>/cml_accounts.json`.

Якщо ви передаєте строковий тип (шлях до файлу), цей метод викличе `WithAccountManager(new JsonXboxGameAccountManager(filePath, JEGameAccount.FromSessionStorage))`.

### WithLogger

Встановлює [ILogger](https://learn.microsoft.com/en-us/dotnet/api/microsoft.extensions.logging.ilogger?view=dotnet-plat-ext-7.0) для логування. Ця бібліотека використовує [Microsoft.Extensions.Logging](https://learn.microsoft.com/en-us/dotnet/core/extensions/logging?tabs=command-line) для запису логів.

## Довідник API

- [JELoginHandler](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/CmlLib.Core.Auth.Microsoft.JELoginHandler.html)
- [JELoginHandlerBuilder](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/CmlLib.Core.Auth.Microsoft.JELoginHandlerBuilder.html)
- [IXboxGameAccountManager](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/XboxAuthNet.Game.Accounts.IXboxGameAccountManager.html)
