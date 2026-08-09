---
description: Вхід, вихід, управління обліковими записами.
---

# JELoginHandler

## Створення екземпляра JELoginHandler

```csharp
var loginHandler = JELoginHandlerBuilder.BuildDefault();
```

Для детальнішого налаштування ініціалізації, що включає вказування способу збереження облікових записів, налаштування `HttpClient` тощо, зверніться до [JELoginHandlerBuilder](jeloginhandlerbuilder.md).

## Базова автентифікація

```csharp
var session = await loginHandler.Authenticate();
// var session = await loginHandler.Authenticate(selectedAccount, cancellationToken);
```

Цей метод спочатку намагається виконати [автентифікацію з останнім використаним обліковим записом](jeloginhandler.md#authenticating-with-the-most-recent-account), а у разі невдачі — [автентифікацію з новим обліковим записом](jeloginhandler.md#authenticating-with-new-account).

## Автентифікація з новим обліковим записом

```csharp
var session = await loginHandler.AuthenticateInteractively();
// var session = await loginHandler.AuthenticateInteractively(selectedAccount, cancellationToken);
```

![](https://user-images.githubusercontent.com/17783561/154854388-38c473f1-7860-4a47-bdbe-622de37eef8b.png)

Додає новий обліковий запис для входу. Відображає користувачеві сторінку Microsoft OAuth для введення даних облікового запису Microsoft.

!!! info "Вимоги до Microsoft WebView2"
    Цей метод використовує [Microsoft WebView2](https://developer.microsoft.com/en-us/microsoft-edge/webview2/) для відображення сторінки входу Microsoft OAuth. Зверніть увагу:

    * **Microsoft WebView2 доступний лише на Windows.** Для інших платформ дивіться [Автентифікація за допомогою MSAL](authentication-with-msal.md).
    * Для роботи WebView2 у користувачів (як розробників, так і кінцевих користувачів) **має бути встановлений WebView2 Runtime**. Дивіться [цей документ](https://learn.microsoft.com/en-us/microsoft-edge/webview2/concepts/distribution) для розповсюдження вашого лаунчера разом із WebView2. (Наприклад, ви можете автоматизувати встановлення середовища виконання за допомогою прямого посилання на завантаження: https://go.microsoft.com/fwlink/p/?LinkId=2124703.

    Якщо ви не бажаєте використовувати WebView2, дивіться [Автентифікація за допомогою MSAL](authentication-with-msal.md).

## Автентифікація з останнім використаним обліковим записом

```csharp
var session = await loginHandler.AuthenticateSilently();
// var session = await loginHandler.AuthenticateSilently(selectedAccount, cancellationToken);
```

Виконує вхід за допомогою збережених даних останнього використаного облікового запису.

* Якщо користувач уже увійшов, метод одразу повертає інформацію про сесію.
* Якщо термін дії даних входу закінчився, виконується спроба їх оновити. Під час цього процесу не потрібно ані взаємодії з користувачем, ані відображення webview.
* Якщо збережені дані входу відсутні або оновлення не вдалося, буде викинуто виняток `MicrosoftOAuthException`. У такому разі слід повторно виконати вхід через методи для нового облікового запису, такі як [автентифікація з новим обліковим записом](jeloginhandler.md#authenticating-with-new-account).

## Список облікових записів

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
foreach (var account in accounts)
{
    if (account is not JEGameAccount jeAccount)
        continue;
    Console.WriteLine("Identifier: " + jeAccount.Identifier);
    Console.WriteLine("LastAccess: " + jeAccount.LastAccess);
    Console.WriteLine("Gamertag: " + jeAccount.XboxTokens?.XstsToken?.XuiClaims?.Gamertag);
    Console.WriteLine("Username: " + jeAccount.Profile?.Username);
    Console.WriteLine("UUID: " + jeAccount.Profile?.UUID);
}
```

Після успішного входу обліковий запис зберігається. Наведений вище код виводить список усіх збережених облікових записів.

## Вибір облікового запису

Вибір облікового запису за порядковим номером (індексом):

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.ElementAt(1);
```

Усі облікові записи мають **унікальний рядок** для ідентифікації. Вибір облікового запису за ідентифікатором:

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.GetAccount("Identifier");
```

Вибір облікового запису за нікнеймом JE:

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.GetJEAccountByUsername("username");
```

## Автентифікація з вибраним обліковим записом

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.ElementAt(1);
var session = await loginHandler.Authenticate(selectedAccount);
```

Завантажує список облікових записів та виконує вхід з другим акаунтом (індекс 1).

## Вихід з останнього використаного облікового запису

!!! info "Кеш браузера"
    Метод `Signout` не очищує кеш браузера WebView2. Для його очищення використовуйте метод `SignoutWithBrowser`.

```csharp
await loginHandler.Signout();
// await loginHandler.SignoutWithBrowser();
```

## Вихід з вибраного облікового запису

!!! info "Кеш браузера"
    Метод `Signout` не очищує кеш браузера WebView2. Для його очищення використовуйте метод `SignoutWithBrowser`.

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.ElementAt(1);
await loginHandler.Signout(selectedAccount);
// await loginHandler.SignoutWithBrowser();
```

Завантажує список облікових записів та виконує вихід з другого акаунта (індекс 1).

## Автентифікація з додатковими параметрами

```csharp
using XboxAuthNet.Game;

// 1. Створення автентифікатора 
var authenticator = loginHandler.CreateAuthenticator(account, default);

// 2. OAuth
authenticator.AddMicrosoftOAuthForJE(oauth => oauth.Interactive());

// 3. XboxAuth
authenticator.AddXboxAuthForJE(xbox => xbox.Basic());

// 4. JEAuthenticator
authenticator.AddJEAuthenticator();

// Виконання автентифікації
var session = await authenticator.ExecuteForLauncherAsync();
```

Процес входу складається з чотирьох основних кроків. Існує багато методів для налаштування процесу автентифікації на кожному з них. Для кожного кроку необхідно обрати лише один метод.

### 1. Створення автентифікатора (Create Authenticator)

```csharp
var authenticator = loginHandler.CreateAuthenticator(account, default);
```

Ініціалізує екземпляр `Authenticator` для конкретного облікового запису. Інші способи ініціалізації:

```csharp
var authenticator = loginHandler.CreateAuthenticatorWithNewAccount(default);
```

Ініціалізує `Authenticator` для нового порожнього облікового запису.

```csharp
var authenticator = loginHandler.CreateAuthenticatorWithDefaultAccount(default);
```

Ініціалізує `Authenticator` для останнього використаного облікового запису.

Замість `default` можна передати [CancellationToken](https://learn.microsoft.com/en-us/dotnet/api/system.threading.cancellationtoken?view=net-7.0).

### 2. OAuth

```csharp
authenticator.AddMicrosoftOAuthForJE(oauth => oauth.Interactive());

// аналогічно до:
// authenticator.AddMicrosoftOAuth(JELoginHandler.DefaultMicrosoftOAuthClientInfo, oauth => oauth.Interactive());

// іншими методами OAuth могут бути:
// 1) authenticator.AddForceMicrosoftOAuthForJE(oauth => oauth.Interactive());
// 2) authenticator.AddMicrosoftOAuthForJE(oauth => oauth.Silent());
// ...
```

Встановлює режим Microsoft OAuth. Замість `oauth => oauth.Interactive()` можна обрати інші варіанти. Дивіться [OAuth](../xboxauthnet.game/oauth.md).

Методи `AddMicrosoftOAuthForJE` та `AddForceMicrosoftOAuthForJE` додають стандартну інформацію клієнта `MicrosoftOAuthClientInfo`, яку використовує офіційний лаунчер Mojang Minecraft, тому її не потрібно передавати щоразу.

Зверніть увагу, що стандартний Microsoft OAuth доступний лише на платформі Windows. Для інших платформ (Linux, macOS) потрібен [xboxauthnet.game.msal](../xboxauthnet.game.msal/README.md).

```csharp
// приклад для XboxAuthNet.Game.Msal
authenticator.AddMsalOAuth(app, msal => msal.Interactive());
```

### 3. XboxAuth

```csharp
authenticator.AddXboxAuthForJE(xbox => xbox.Basic());

// аналогічно до:
// authenticator.AddXboxAuth(xbox => xbox.WithRelyingParty(JELoginHandler.RelyingParty).Basic());

// іншими методами автентифікації Xbox можуть бути:
// 1) authenticator.AddXboxAuthForJE(xbox => xbox.Full());
// 2) authenticator.AddXboxAuthForJE(xbox => xbox.Sisu("<CLIENT-ID>"));
// ...
```

Встановлює режим автентифікації Xbox. Замість `xbox => xbox.Basic()` можна обрати інші варіанти. Дивіться [XboxAuth](../xboxauthnet.game/xboxauth.md).

Методи `AddXboxAuthForJE` та `AddForceXboxAuthForJE` додають стандартну довірену сторону (relying party) автентифікації Xbox, що використовується для Minecraft: JE, тому її не потрібно передавати щоразу.

### 4. JEAuthenticator

Встановлює режим автентифікації Minecraft: JE. Дивіться [JEAuthenticator](jeauthenticator.md).

## Довідник API

- [JELoginHandler](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/CmlLib.Core.Auth.Microsoft.JELoginHandler.html)
- [Extensions](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/CmlLib.Core.Auth.Microsoft.Extensions.html)
- [JEAuthenticatorBuilder](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/CmlLib.Core.Auth.Microsoft.Authenticators.JEAuthenticatorBuilder.html)
- [JEGameAccount](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/CmlLib.Core.Auth.Microsoft.Sessions.JEGameAccount.html)
- [IXboxGameAccountManager](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/XboxAuthNet.Game.Accounts.IXboxGameAccountManager.html)
