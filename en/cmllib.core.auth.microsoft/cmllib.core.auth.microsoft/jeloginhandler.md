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
```

This method tries [#authenticating-with-the-most-recent-account](jeloginhandler.md#authenticating-with-the-most-recent-account "mention") first and if it fails, try [#authenticating-with-new-account](jeloginhandler.md#authenticating-with-new-account "mention").

## Authenticating with New Account

```csharp
var session = await loginHandler.AuthenticateInteractively();
```

![](https://user-images.githubusercontent.com/17783561/154854388-38c473f1-7860-4a47-bdbe-622de37eef8b.png)

Add a new account to sign in. Show the user the Microsoft OAuth page to enter their Microsoft account.

## Authenticating with the Most Recent Account

```csharp
var session = await loginHandler.AuthenticateSilently();
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

```csharp
await loginHandler.Signout();
```

## Signing out from Selected Account

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.ElementAt(1);
await loginHandler.Signout(selectedAccount);
```

Load account list and sign out from second account (index number 1).

## Authenticating with More Options

```csharp
using XboxAuthNet.Game;

var authenticator = loginHandler.CreateAuthenticator(account, default);
authenticator.AddMicrosoftOAuthForJE(oauth => oauth.Interactive()); // Microsoft OAuth
authenticator.AddXboxAuthForJE(xbox => xbox.Basic()); // XboxAuth
authenticator.AddJEAuthenticator(); // JEAuthenticator
var session = await authenticator.ExecuteForLauncherAsync();
```

There are four main steps in authentication.

### 1. CreateAuthenticator

Initialize `Authenticator` instance.

#### CreateAuthenticator(XboxGameAccount account, CancellationToken cancellationToken)

Initialize `Authenticator` with specified `account`.

#### CreateAuthenticatorWithNewAccount(CancellationToken cancellationToken)

Initialize `Authenticator` with new empty account.

#### CreateAuthenticatorWithDefaultAccount(CancellationToken cancellationToken)

Initialize `Authenticator` with the most recent account.

### 2. Microsoft OAuth

See [oauth.md](../xboxauthnet.game/oauth.md "mention").

#### AddMicrosoftOAuthForJE(oauthBuilder)

Same as `AddMicrosoftOAuth(JELoginHandler.DefaultMicrosoftOAuthClientInfo, oauthBuilder)`

#### AddForceMicrosoftOAuthForJE(oauthBuilder)

Same as `AddForceMicrosoftOAuth(JELoginHandler.DefaultMicrosoftOAuthClientInfo, oauthBuilder)`

To authenticate with MSAL, see [oauth.md](../xboxauthnet.game.msal/oauth.md "mention")

### 3. XboxAuth

See [xboxauth.md](../xboxauthnet.game/xboxauth.md "mention").

#### AddXboxAuthForJE(xboxBuilder)

Provides preset `xboxBuilder` with the relyingParty as Minecraft: JE's relyingParty.

### 4. JEAuthenticator

See [jeauthenticator.md](jeauthenticator.md "mention").
