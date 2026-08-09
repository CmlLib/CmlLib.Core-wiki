---
description: Автентифікація Xbox
---

# XboxAuth

## Приклад

```csharp
var authenticator = // створення автентифікатора з використанням login handlers
authenticator.AddXboxAuthForJE(xbox => xbox.Basic());
//authenticator.AddXboxAuth(xbox => xbox.Basic(XboxAuthConstants.XboxLiveRelyingParty)); // той самий код
```

## Basic

```csharp
authenticator.AddXboxAuthForJE(xbox => xbox.Basic());
//authenticator.AddXboxAuth(xbox => xbox.Basic("relyingParty"));
```

Це найпростіший (базовий) метод. Він отримує лише мінімальну інформацію (UserToken, XstsToken), необхідну для входу.

Облікові записи, які не пройшли перевірку віку, а також акаунти користувачів віком до 18 років можуть стикатися з проблемами під час входу цим способом (коди помилок `8015dc0c`, `8015dc0d`, `8015dc0e`).  
Ви можете обійти це за допомогою методу [#full](xboxauth.md#full) або методу [#sisu](xboxauth.md#sisu).

## Full

```csharp
authenticator.AddXboxAuthForJE(xbox => xbox.Full());
//authenticator.AddXboxAuth(xbox => xbox.Full("relyingParty"));
```

Отримує UserToken, DeviceToken та XstsToken.

## Sisu

```csharp
authenticator.AddXboxAuthForJE(xbox => xbox.Sisu(XboxGameTitles.MinecraftJava));
//authenticator.AddXboxAuth(xbox => xbox.Sisu("relyingParty", "<CLIENT-ID>"));
```

Використовує метод входу SISU. Отримує всі токени: UserToken, DeviceToken, TitleToken, XstsToken. Більшість проблем, пов'язаних із віковими обмеженнями, можна вирішити цим способом.

Це працює лише у випадку, якщо `<CLIENT-ID>` пов'язаний з грою Xbox (наприклад, CLIENT-ID, який використовується офіційним лаунчером Minecraft).

Ви не можете використовувати особисто створений Azure ID, тобто цей метод не можна використовувати разом із MSAL.

## Параметри пристрою (Device Options)

```csharp
authenticator.AddXboxAuth(xbox => xbox
    .WithDeviceType(XboxDeviceTypes.Win32)
    .WithDeviceVersion("0.0.0")
    .Full("relyingParty"));
```

Під час використання методу автентифікації, який отримує DeviceToken, ви можете застосувати налаштування пристрою. Викличте `.WithDeviceType()` та `.WithDeviceVersion()` перед викликом методу автентифікації.

## Обробка помилок (Handling errors)

Під час автентифікації в Xbox можуть виникати різні сценарії помилок. Якщо під час автентифікації виникає помилка, викидається виняток `XboxAuthException`, із якого ви можете отримати `ErrorCode` та `ErrorMessage`.

Усі коди помилок (ErrorCodes) можна знайти у розділі [XboxAuthException](xboxauthexception.md).

## Довідник API

- [XboxAuthBuilder](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/XboxAuthNet.Game.XboxAuth.XboxAuthBuilder.html)
