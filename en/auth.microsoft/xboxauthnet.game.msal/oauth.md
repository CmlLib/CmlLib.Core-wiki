# OAuth

Describes a way to proceed with Microsoft OAuth via MSAL.

You MUST initialize an [IPublicClientApplication](msalclienthelper.md) via [YOUR CLIENT ID](clientid.md) before to use this!

## Example

[jeloginhandler.md](../cmllib.core.auth.microsoft/jeloginhandler.md "mention") with MSAL OAuth.

```csharp
using XboxAuthNet.Game.Msal;

var app = await MsalClientHelper.BuildApplicationWithCache("<CLIENT-ID>");
var loginHandler = JELoginHandlerBuilder.BuildDefault();

var authenticator = loginHandler.CreateAuthenticatorWithNewAccount(default);
authenticator.AddMsalOAuth(app, msal => msal.Interactive());
authenticator.AddXboxAuth(xbox => xbox.Basic());
authenticator.AddJEAuthenticator();
var session = await authenticator.ExecuteForLauncherAsync();
```

## Interactive

```csharp
authenticator.AddMsalOAuth(app, msal => msal.Interactive());
```

Requests users to enter their Microsoft account. How the sign-in page is displayed is determined by the MSAL.&#x20;

## EmbeddedWebView

```csharp
authenticator.AddMsalOAuth(app, msal => msal.EmbeddedWebView());
```

![](https://user-images.githubusercontent.com/17783561/154946636-960d3673-bb51-4f3a-ae92-f36940b8e3ad.png)

Prompts the user to enter their Microsoft account. Use WebView2 to display the login page.

## SystemBrowser

```csharp
authenticator.AddMsalOAuth(app, msal => msal.SystemBrowser());
```

![](https://user-images.githubusercontent.com/17783561/154945056-2f0d961b-f69b-4cea-a08a-9c3b050995f6.png)

Prompts the user to enter their Microsoft account. Open the system's default browser to display the sign-in page.

## Silent

```csharp
authenticator.AddMsalOAuth(app, msal => msal.Silent());
```

Attempts to sign in using the account information cached in the MSAL.

## DeviceCode

```csharp

authenticator.AddMsalOAuth(app, msal => msal.DeviceCode(deviceCode =>
{
    Console.WriteLine(deviceCode.Message);
    return Task.CompletedTask;
}));
```

Attempt to sign in using the DeviceCode method. This method doesn't require a web browser or UI on the client, but it does allow the client to log in from a different device.

If you're building a launcher that only works on the console or no GUI environment, use this method for login. The login can be done on a completely different device than the one running your launcher. For example, a user can log in from their mobile phone.

The example code outputs the following message to the console:

```
To sign in, use a web browser to open the page https://www.microsoft.com/link and enter the code XXXXXXXX to authenticate.
```

## FromResult

```csharp
var result = await app.AcquireTokenInteractive(MsalClientHelper.XboxScopes).ExecuteAsync();
authenticator.AddMsalOAuth(app, msal => msal.FromResult(result));
```

Use MSAL authentication result.
