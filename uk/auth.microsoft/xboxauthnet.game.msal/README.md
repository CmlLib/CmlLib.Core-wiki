---
description: Розширення для MSAL OAuth
---

# XboxAuthNet.Game.Msal

Надає методи розширення для виконання Microsoft OAuth за допомогою MSAL.

Завдяки MSAL ви можете виконувати вхід на будь-якій платформі, включаючи Linux та macOS, а не лише на Windows.

## Встановлення

NuGet-пакет [XboxAuthNet.Game.Msal](https://www.nuget.org/packages/XboxAuthNet.Game.Msal)

Щоб використовувати цей пакет, необхідно правильно ініціалізувати `IPublicClientApplication`.

```bash
dotnet add package XboxAuthNet.Game.Msal
```

## [ClientID](clientid.md)

Описує процес реєстрації застосунку в Azure для `IPublicClientApplication`.

## [MsalClientHelper](msalclienthelper.md)

Описує, як ініціалізувати `IPublicClientApplication` для ігор Xbox.

## [OAuth](oauth.md)

Описує спосіб виконання Microsoft OAuth за допомогою MSAL.
