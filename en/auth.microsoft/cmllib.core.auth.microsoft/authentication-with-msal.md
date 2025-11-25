# Authentication with MSAL

`JELoginHandler` only works on Windows. To use it on another platform, you must use it with [XboxAuthNet.Game.Msal](../xboxauthnet.game.msal/README.md).

There are two ways to use `CmlLib.Core.Auth.Microsoft` with `XboxAuthNet.Game.Msal`.

* Register an `OAuthProvider` when initializing `JELoginHandler`.
* Create an `IAuthenticator` and add a MSAL authenticator.

### Register an OAuthProvider

Register the `OAuthProvider` when initializing the `JELoginHandler` so that all subsequent methods you call will handle the login with the MSAL.

```csharp
var app = await MsalClientHelper.BuildApplicationWithCache("CLIENT-ID");
var loginHandler = new JELoginHandlerBuilder()
    .WithOAuthProvider(new MsalCodeFlowProvider(app))
    .Build();
    
// login
var session = await loginHandler.Authenticate();

// add new account
var session = await loginHandler.AuthenticateInteractively();

// login with most recently logged in account
var session = await loginHandler.AuthenticateSilently();

// clear
await loginHandler.Signout();

// signout
await loginHandler.SignoutWithBrowser();
```

For more information about `loginHandler`, see [JELoginHandler](jeloginhandler.md).

### Using AddMsalOAuth

Authenticating with new account:

```csharp
var app = await MsalClientHelper.BuildApplicationWithCache("CLIENT-ID");
var loginHandler = new JELoginHandlerBuilder()
    .Build();

// create authenticator with new account
var authenticator = loginHandler.CreateAuthenticatorWithNewAccount();
authenticator.AddMsalOAuth(app, msal => msal.Interactive());
authenticator.AddXboxAuthForJE(xbox => xbox.Basic());
authenticator.AddForceJEAuthenticator();
var session = await authenticator.ExecuteForLauncherAsync();
```

Authenticating with the most recent account:

```csharp
var app = await MsalClientHelper.BuildApplicationWithCache("CLIENT-ID");
var loginHandler = new JELoginHandlerBuilder()
    .Build();

// create authenticator with the most recent account
var authenticator = loginHandler.CreateAuthenticatorWithDefaultAccount();
authenticator.AddMsalOAuth(app, msal => msal.Silent());
authenticator.AddXboxAuthForJE(xbox => xbox.Basic());
authenticator.AddJEAuthenticator();
var session = await authenticator.ExecuteForLauncherAsync();
```

Signout:

```csharp
var app = await MsalClientHelper.BuildApplicationWithCache("CLIENT-ID");
var loginHandler = new JELoginHandlerBuilder()
    .Build();
    
var authenticator = loginHandler.CreateAuthenticatorWithDefaultAccount();
authenticator.AddMsalOAuth(app, msal => msal.ClearSession());
authenticator.AddXboxAuthSignout();
authenticator.AddJESignout();
var session = await authenticator.ExecuteForLauncherAsync();
```

For more methods in MSAL, such as `msal.Interactive()`, `msal.Silent()`, and more, see [OAuth](../xboxauthnet.game.msal/oauth.md).

## API Reference

- [JELoginHandler](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/CmlLib.Core.Auth.Microsoft.JELoginHandler.html)
- [MsalClientHelper](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/XboxAuthNet.Game.Msal.MsalClientHelper.html)
- [MsalCodeFlowProvider](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/XboxAuthNet.Game.Msal.OAuth.MsalCodeFlowProvider.html)
- [MsalDeviceCodeProvider](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/XboxAuthNet.Game.Msal.OAuth.MsalDeviceCodeProvider.html)
- [MsalOAuthBuilder](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/XboxAuthNet.Game.Msal.MsalOAuthBuilder.html)