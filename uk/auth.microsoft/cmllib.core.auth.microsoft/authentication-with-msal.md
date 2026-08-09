# Автентифікація за допомогою MSAL

`JELoginHandler` за замовчуванням працює лише на Windows. Щоб використовувати його на інших платформах, необхідно задіяти [XboxAuthNet.Game.Msal](../xboxauthnet.game.msal/README.md).

Існує два способи використання `CmlLib.Core.Auth.Microsoft` разом із `XboxAuthNet.Game.Msal`:

* Зареєструвати `OAuthProvider` під час ініціалізації `JELoginHandler`.
* Створити `IAuthenticator` та додати до нього автентифікатор MSAL.

### Реєстрація OAuthProvider

Зареєструйте `OAuthProvider` під час ініціалізації `JELoginHandler`, щоб усі наступні викликані вами методи виконували вхід через MSAL.

```csharp
var app = await MsalClientHelper.BuildApplicationWithCache("CLIENT-ID");
var loginHandler = new JELoginHandlerBuilder()
    .WithOAuthProvider(new MsalCodeFlowProvider(app))
    .Build();
    
// вхід
var session = await loginHandler.Authenticate();

// додання нового облікового запису
var session = await loginHandler.AuthenticateInteractively();

// вхід за допомогою останнього використаного облікового запису
var session = await loginHandler.AuthenticateSilently();

// очищення локальної сесії
await loginHandler.Signout();

// вихід з облікового запису через браузер
await loginHandler.SignoutWithBrowser();
```

Для отримання детальнішої інформації про `loginHandler` дивіться [JELoginHandler](jeloginhandler.md).

### Використання AddMsalOAuth

Автентифікація з новим обліковим записом:

```csharp
var app = await MsalClientHelper.BuildApplicationWithCache("CLIENT-ID");
var loginHandler = new JELoginHandlerBuilder()
    .Build();

// створення автентифікатора для нового облікового запису
var authenticator = loginHandler.CreateAuthenticatorWithNewAccount();
authenticator.AddMsalOAuth(app, msal => msal.Interactive());
authenticator.AddXboxAuthForJE(xbox => xbox.Basic());
authenticator.AddForceJEAuthenticator();
var session = await authenticator.ExecuteForLauncherAsync();
```

Автентифікація з останнім використаним обліковим записом:

```csharp
var app = await MsalClientHelper.BuildApplicationWithCache("CLIENT-ID");
var loginHandler = new JELoginHandlerBuilder()
    .Build();

// створення автентифікатора для останнього використаного облікового запису
var authent
