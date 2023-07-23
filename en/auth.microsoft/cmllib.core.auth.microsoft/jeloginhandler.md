---
description: Login, logout, account managements.
---

# JELoginHandler

## Creating JELoginHandler instance

```csharp
var loginHandler = JELoginHandlerBuilder.BuildDefault();
```

For more detailed initialization, which includes specifying how accounts are stored, setting up HttpClient, and more, please refer to [jeloginhandlerbuilder.md](jeloginhandlerbuilder.md "mention").

## Basic Authentication

```csharp
var session = await loginHandler.Authenticate();
// var session = await loginHandler.Authenticate(selectedAccount, cancellationToken);
```

This method tries [#authenticating-with-the-most-recent-account](jeloginhandler.md#authenticating-with-the-most-recent-account "mention") first and if it fails, tries [#authenticating-with-new-account](jeloginhandler.md#authenticating-with-new-account "mention").

## Authenticating with New Account

```csharp
var session = await loginHandler.AuthenticateInteractively();
// var session = await loginHandler.AuthenticateInteractively(selectedAccount, cancellationToken);
```

![](https://user-images.githubusercontent.com/17783561/154854388-38c473f1-7860-4a47-bdbe-622de37eef8b.png)

Add a new account to sign in. Show the user the Microsoft OAuth page to enter their Microsoft account.&#x20;

{% hint style="info" %}
This method uses [Microsoft WebView2](https://developer.microsoft.com/en-us/microsoft-edge/webview2/) for displaying Microsoft OAuth login page. You must know that:

* **Microsoft WebView2 is only available on Windows.** For another platform, you need [xboxauthnet.game.msal](../xboxauthnet.game.msal/ "mention").
* To run WebView2, The users (including developer and end user) **must have the WebView2 Runtime installed**. See [this document](https://learn.microsoft.com/en-us/microsoft-edge/webview2/concepts/distribution) to distribute your launcher with WebView2. (For example, you can automate runtime installation with direct download link: [https://go.microsoft.com/fwlink/p/?LinkId=2124703](https://go.microsoft.com/fwlink/p/?LinkId=2124703))

If you don't want to use WebView2, you can use [xboxauthnet.game.msal](../xboxauthnet.game.msal/ "mention") instead.
{% endhint %}

## Authenticating with the Most Recent Account

```csharp
var session = await loginHandler.AuthenticateSilently();
// var session = await loginHandler.AuthenticateSilently(selectedAccount, cancellationToken);
```

Using the saved account information of the most account, log in.&#x20;

* If the user is already logged in, this method returns the logged in information immediately.
* If the user's login information has expired, try to refresh it. No user interaction nor webview is required during this process.&#x20;
* If there is no saved login information or if refresh failed, an `MicrosoftOAuthException` will be thrown. In this case you should authenticate again using new account methods like [#authenticating-with-new-account](jeloginhandler.md#authenticating-with-new-account "mention").

## List Accounts

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

After a successful login, the account is saved. Above code list all saved account lists.

## Select Account

Select account by index number:

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.ElementAt(1);
```

All account has **unique string** to identifiy them. Select account by identifier:

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.GetAccount("Identifier");
```

Select account by JE username:

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.GetJEAccountByUsername("username");
```

## Authenticating with the Selected Account

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.ElementAt(1);
var session = await loginHandler.Authenticate(selectedAccount);
```

Load account list and authenticate with second account (index number 1).

## Signing out from the most Recent Account

{% hint style="info" %}
`Signout` method does not clear WebView2 browser cache. For clearing it, call `SignoutWithBrowser` instead.
{% endhint %}

```csharp
await loginHandler.Signout();
// await loginHandler.SignoutWithBrowser();
```

## Signing out from the Selected Account

{% hint style="info" %}
`Signout` method does not clear WebView2 browser cache. For clearing it, call `SignoutWithBrowser` instead.
{% endhint %}

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.ElementAt(1);
await loginHandler.Signout(selectedAccount);
// await loginHandler.SignoutWithBrowser();
```

Load account list and sign out from second account (index number 1).

## Authenticating with More Options

```csharp
using XboxAuthNet.Game;

// 1. Create Authenticator 
var authenticator = loginHandler.CreateAuthenticator(account, default);

// 2. OAuth
authenticator.AddMicrosoftOAuthForJE(oauth => oauth.Interactive());

// 3. XboxAuth
authenticator.AddXboxAuthForJE(xbox => xbox.Basic());

// 4. JEAuthenticator
authenticator.AddJEAuthenticator();

// Execute authenticator
var session = await authenticator.ExecuteForLauncherAsync();
```

The login process has four main steps. There are many methods to customize authentication flow in each main step. You must select only one method for each step.&#x20;

### 1. Create Authenticator

```csharp
var authenticator = loginHandler.CreateAuthenticator(account, default);
```

Initialize `Authenticator` instance with the specific account to login. Another ways to initialize this:

```csharp
var authenticator = loginHandler.CreateAuthenticatorWithNewAccount(default);
```

Initialize `Authenticator` with new empty account.

```csharp
var authenticator = loginHandler.CreateAuthenticatorWithDefaultAccount(default);
```

Initialize `Authenticator` with the most recent account.

You can pass [CancellationToken](https://learn.microsoft.com/en-us/dotnet/api/system.threading.cancellationtoken?view=net-7.0) instead of `default`.

### 2. OAuth

```csharp
authenticator.AddMicrosoftOAuthForJE(oauth => oauth.Interactive());

// above code is same as
// authenticator.AddMicrosoftOAuth(JELoginHandler.DefaultMicrosoftOAuthClientInfo, oauth => oauth.Interactive());

// another OAuth method can be:
// 1) authenticator.AddForceMicrosoftOAuthForJE(oauth => oauth.Interactive());
// 2) authenticator.AddMicrosoftOAuthForJE(oauth => oauth.Silent());
// ...
```

Set Microsoft OAuth mode. Instead of `oauth => oauth.Interactive()`, there are many options you can replace with. See [oauth.md](../xboxauthnet.game/oauth.md "mention").

`AddMicrosoftOAuthForJE` and `AddForceMicrosoftOAuthForJE` methods add default `MicrosoftOAuthClientInfo` which Mojang Minecraft launcher uses so that you don't need to pass it everytime you use.

Note that the default Microsoft OAuth is only available on Windows platform. For another platform (Linux, macOS) you need [xboxauthnet.game.msal](../xboxauthnet.game.msal/ "mention").&#x20;

```csharp
// example for XboxAuthNet.Game.Msal
authenticator.AddMsalOAuth(app, msal => msal.Interactive());
```

### 3. XboxAuth

```csharp
authenticator.AddXboxAuthForJE(xbox => xbox.Basic());

// above code is same as
// authenticator.AddXboxAuth(xbox => xbox.WithRelyingParty(JELoginHandler.RelyingParty).Basic());

// another xbox auth method can be:
// 1) authenticator.AddXboxAuthForJE(xbox => xbox.Full());
// 2) authenticator.AddXboxAuthForJE(xbox => xbox.Sisu("<CLIENT-ID>"));
// ...
```

Set Xbox authentication mode. Instead of `xbox => xbox.Basic()`, there are many options you can replace with. See [xboxauth.md](../xboxauthnet.game/xboxauth.md "mention").

`AddXboxAuthForJE` and `AddForceXboxAuthForJE` methods add default xbox authentication relying party which is used for Minecraft: JE authentication so that you don't need to pass it everytime you use.

### 4. JEAuthenticator

Set Minecraft: JE authentication mode. See [jeauthenticator.md](jeauthenticator.md "mention").
