---
description: Надає допоміжні методи для ініціалізації IPublicClientApplication.
---

# MsalClientHelper

## Приклад

```csharp
using XboxAuthNet.Game.Msal;

IPublicClientApplication app = await MsalClientHelper.BuildApplicationWithCache("<CLIENT-ID>");
```

Укажіть ваш Azure App ID замість `<CLIENT-ID>`. Для отримання додаткової інформації дивіться [ClientID](clientid.md).

## CreateDefaultApplicationBuilder(string cid)

Ініціалізує екземпляр `PublicClientApplicationBuilder`, налаштований для автентифікації Xbox.

## RegisterCache(IPublicClientApplication app, MsalCacheSettings cacheSettings)

Застосовує об'єкт налаштувань кешу `cacheSettings` до `app`.

## RegisterCache(IPublicClientApplication app, StorageCreationProperties storageProperties)

Застосовує об'єкт налаштувань кешу `storageProperties` до `app`.

## BuildApplication(string cid)

Ініціалізує `IPublicClientApplication`, налаштований для автентифікації Xbox.

## BuildApplicationWithCache(string cid)

Ініціалізує `IPublicClientApplication`, налаштований для автентифікації Xbox, та повертає його із застосованими стандартними налаштуваннями кешу облікових записів.

## BuildApplicationWithCache(string cid, MsalCacheSettings cacheSettings)

Ініціалізує `IPublicClientApplication`, налаштований для автентифікації Xbox, застосовує налаштування кешу `cacheSettings` та повертає його.

## BuildApplicationWithCache(string cid, StorageCreationProperties storageProperties)

Створює `IPublicClientApplication`, налаштований для автентифікації Xbox, та повертає його з налаштуваннями кешу `storageProperties`.

## ToMicrosoftOAuthResponse(AuthenticationResult result)

Конвертує результат входу MSAL (`AuthenticationResult`) в об'єкт `MicrosoftOAuthResponse`, який використовується в `XboxAuthNet`.

## Довідник API

- [MsalClientHelper](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/XboxAuthNet.Game.Msal.MsalClientHelper.html)
