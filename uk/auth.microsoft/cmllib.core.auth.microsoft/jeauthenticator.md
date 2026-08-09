---
description: Налаштування параметрів автентифікації JE (Java Edition)
---

# JEAuthenticator

## AddJEAuthenticator

```csharp
authenticator.AddJEAuthenticator();
```

Спочатку перевіряється кешована сесія JE. Якщо сесія застаріла або недійсна, виконується спроба автентифікації JE за допомогою сесії Xbox.

## AddForceJEAuthenticator

```csharp
authenticator.AddForceJEAuthenticator();
```

Виконує вхід у JE через сесію Xbox без попередньої перевірки кешованої сесії JE.

## WithGameOwnershipChecker(bool value)

```csharp
authenticator.AddJEAuthenticator(je => je
    .WithGameOwnershipChecker(false)
    .Build());
```

Встановлює, чи потрібно перевіряти, чи придбана гра та чи належить вона обліковому запису. За замовчуванням: `false`

!!! info "Game Ownership Checker (Перевірка володіння грою)"
    `GameOwnershipChecker` може перевіряти лише ті покупки, які були здійснені на офіційному сайті Mojang. Рекомендується **НЕ змінювати значення за замовчуванням** (`false`), оскільки користувачі Xbox Game Pass визначатимуться як такі, що не мають гри, навіть за наявності діючої ліцензії.

## JEAuthException

Цей виняток викидається, якщо під час входу в Minecraft JE виникла помилка. Властивості `ErrorType`, `Error` та `ErrorMessage` надають детальну інформацію про помилку.

### 403: FORBIDDEN

Якщо OAuth-токен отримано через сторонній client ID, вам необхідно зареєструвати цей client ID. Дивіться останній розділ у [ClientID](../xboxauthnet.game.msal/clientid.md).

### 404: NOT_FOUND

У користувача немає придбаної гри (демо-версія).

## Довідник API

- [Extensions](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/CmlLib.Core.Auth.Microsoft.Extensions.html)
- [JEAuthenticatorBuilder](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/CmlLib.Core.Auth.Microsoft.Authenticators.JEAuthenticatorBuilder.html)
