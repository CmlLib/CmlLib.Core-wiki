# OAuth

Описує спосіб виконання Microsoft OAuth через MSAL.

Перед використанням ви **ОБОВ'ЯЗКОВО** повинні ініціалізувати [IPublicClientApplication](msalclienthelper.md) за допомогою [ВАШОГО CLIENT ID](clientid.md)!

## Приклад

[JELoginHandler](../cmllib.core.auth.microsoft/jeloginhandler.md) з MSAL OAuth.

```csharp
using XboxAuthNet.Game.Msal;

var app = await MsalClientHelper.BuildApplicationWithCache("<CLIENT-ID>");
var loginHandler = JELoginHandlerBuilder.BuildDefault();

var authenticator = loginHandler.CreateAuthenticatorWithNewAccount(default);
authenticator.AddMsalOAuth(app, msal => msal.Interactive());
authenticator.AddXboxAuthForJE(xbox => xbox.Basic());
authenticator.AddJEAuthenticator();
var session = await authenticator.ExecuteForLauncherAsync();
```

## Interactive

```csharp
authenticator.AddMsalOAuth(app, msal => msal.Interactive());
```

Запитує в користувачів введення даних облікового запису Microsoft. Спосіб відображення сторінки входу визначається за допомогою MSAL.

## EmbeddedWebView

```csharp
authenticator.AddMsalOAuth(app, msal => msal.EmbeddedWebView());
```

![](https://user-images.githubusercontent.com/17783561/154946636-960d3673-bb51-4f3a-ae92-f36940b8e3ad.png)

Пропонує користувачеві увійти в обліковий запис Microsoft. Використовує WebView2 для відображення сторінки входу.

## SystemBrowser

```csharp
authenticator.AddMsalOAuth(app, msal => msal.SystemBrowser());
```

![](https://user-images.githubusercontent.com/17783561/154945056-2f0d961b-f69b-4cea-a08a-9c3b050995f6.png)

Пропонує користувачеві увійти в обліковий запис Microsoft. Відкриває системний браузер за замовчуванням для відображення сторінки входу.

## Silent

```csharp
authenticator.AddMsalOAuth(app, msal => msal.Silent());
```

Намагається виконати вхід за допомогою даних облікового запису, збережених у кеші MSAL.

## DeviceCode

```csharp
authenticator.AddMsalOAuth(app, msal => msal.DeviceCode(deviceCode =>
{
    Console.WriteLine(deviceCode.Message);
    return Task.CompletedTask;
}));
```

Спроба виконати вхід за допомогою методу DeviceCode (код пристрою). Цей метод не вимагає наявності веббраузера або графічного інтерфейсу (UI) на клієнтському пристрої, але дозволяє увійти з іншого пристрою.

Якщо ви створюєте лаунчер, який працює лише в консольному середовищі або без графічного інтерфейсу, використовуйте цей метод для входу. Вхід можна виконати з абсолютно іншого пристрою, ніж той, на якому запущено ваш лаунчер (наприклад, з мобільного телефону).

Приклад коду виводить у консоль наступне повідомлення:

```text
To sign in, use a web browser to open the page https://www.microsoft.com/link and enter the code XXXXXXXX to authenticate.
```

## FromResult

```csharp
var result = await app.AcquireTokenInteractive(MsalClientHelper.XboxScopes).ExecuteAsync();
authenticator.AddMsalOAuth(app, msal => msal.FromResult(result));
```

Використовує готовий результат автентифікації MSAL.

## Довідник API

- [MsalOAuthBuilder](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/XboxAuthNet.Game.Msal.MsalOAuthBuilder.html)
