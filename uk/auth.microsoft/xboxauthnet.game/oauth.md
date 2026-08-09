---
description: Microsoft OAuth
---

# OAuth

## Приклад

Додайте `Authenticator` за допомогою методів розширення `ICompositeAuthenticator`.

```csharp
using XboxAuthNet.Game;

var clientInfo = new MicrosoftOAuthClientInfo("<MICROSOFT_OAUTH_CLIENT_ID>", "<MICROSOFT_OAUTH_SCOPES>");
var authenticator = // створення автентифікатора з використанням login handlers

// приклад 1
authenticator.AddForceMicrosoftOAuth(clientInfo, oauth => oauth.Interactive());

// приклад 2
authenticator.AddMicrosoftOAuth(clientInfo, oauth => oauth.Silent());
```

## AddMicrosoftOAuth / AddForceMicrosoftOAuth

`AddMicrosoftOAuth` перевіряє кешовану сесію Microsoft OAuth і, якщо сесія є дійсною, не продовжує процес автентифікації та переходить до наступного автентифікатора.

Метод `Force` не перевіряє сесію Microsoft OAuth та виконує автентифікацію безумовно.

## Налаштування режиму OAuth

### Interactive

```csharp
authenticator.AddMicrosoftOAuth(clientInfo, oauth => oauth.Interactive());
```

```csharp
authenticator.AddMicrosoftOAuth(clientInfo, oauth => oauth.Interactive(new MicrosoftOAuthParameters
{
    // налаштування OAuth
    // приклад: встановлення режиму запиту (prompt)
    Prompt = MicrosoftOAuthPromptModes.SelectAccount
}));
```

![](https://user-images.githubusercontent.com/17783561/154854388-38c473f1-7860-4a47-bdbe-622de37eef8b.png)

З'явиться вікно із запитом до користувача ввести електронну пошту та пароль від облікового запису Microsoft для продовження входу.

!!! info "Вимоги до Microsoft WebView2"
    Цей метод використовує [Microsoft WebView2](https://developer.microsoft.com/en-us/microsoft-edge/webview2/) для відображення сторінки входу Microsoft OAuth. Зверніть увагу:

    * **Microsoft WebView2 доступний лише на Windows.** Для інших платформ дивіться [Автентифікація за допомогою MSAL](../cmllib.core.auth.microsoft/authentication-with-msal.md).
    * Для роботи WebView2 у користувачів (як розробників, так і кінцевих користувачів) **має бути встановлений WebView2 Runtime**. Дивіться [цей документ](https://learn.microsoft.com/en-us/microsoft-edge/webview2/concepts/distribution) для розповсюдження вашого лаунчера разом із WebView2. (Наприклад, ви можете автоматизувати встановлення середовища виконання за допомогою прямого посилання на завантаження: [https://go.microsoft.com/fwlink/p/?LinkId=2124703](https://go.microsoft.com/fwlink/p/?LinkId=2124703)).

    Якщо ви не бажаєте використовувати WebView2, дивіться [Автентифікація за допомогою MSAL](../cmllib.core.auth.microsoft/authentication-with-msal.md).

### Silent

```csharp
authenticator.AddMicrosoftOAuth(clientInfo, oauth => oauth.Silent());
```

Виконує вхід без відображення вікна запиту користувачеві. Якщо кешована сесія ще не закінчилася, буде використано наявний токен; якщо термін дії закінчився, буде здійснено спробу його оновити. Якщо оновлення не вдалося, буде викинуто виняток `MicrosoftOAuthException`.

### Signout

Очищує лише кешовані сесії OAuth. Браузер користувача все ще може містити дані входу.

```csharp
authenticator.AddMicrosoftOAuthSignout(clientInfo);
```

### Signout з очищенням кешу браузера (Signout with Clearing Browser Cache)

Відображає сторінку виходу з OAuth та очищує сесію.

```csharp
authenticator.AddMicrosoftOAuthBrowserSignout(clientInfo);
```

або ви можете налаштувати параметри браузера:

```csharp
authenticator.AddMicrosoftOAuthBrowserSignout(clientInfo, codeFlow =>
{
    // додаткові налаштування, такі як заголовок вікна (UI title), батьківські елементи тощо... 
    codeFlow.WithUITitle("My Window");
});
```

## Довідник API

- [MicrosoftOAuthBuilder](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/XboxAuthNet.Game.OAuth.MicrosoftOAuthBuilder.html)
