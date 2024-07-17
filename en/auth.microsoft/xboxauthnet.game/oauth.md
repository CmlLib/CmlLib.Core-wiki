---
description: Microsoft OAuth
---

# OAuth

## Example

Add `Authenticator` through the extension methods of `ICompositeAuthenticator`.

```csharp
using XboxAuthNet.Game;

var clientInfo = new MicrosoftOAuthClientInfo("<MICROSOFT_OAUTH_CLIENT_ID>", "<MICROSOFT_OAUTH_SCOPES>");
var authenticator = // create authenticator using login handlers

// example 1
authenticator.AddForceMicrosoftOAuth(clientInfo, oauth => oauth.Interactive());

// example 2
authenticator.AddMicrosoftOAuth(clientInfo, oauth => oauth.Silent());
```

## AddMicrosoftOAuth / AddForceMicrosoftOAuth

`AddMicrosoftOAuth` validates the cached Microsoft OAuth session and, if the session is valid, doesn't proceed authentication and moves on to the next authenticator.

The Force method does not validate the Microsoft OAuth session and proceeds authentication unconditionally.

## Setting OAuth Mode

### Interactive

```csharp
authenticator.AddMicrosoftOAuth(clientInfo, oauth => oauth.Interactive());
```

```csharp
authenticator.AddMicrosoftOAuth(clientInfo, oauth => oauth.Interactive(new MicrosoftOAuthParameters
{
    // OAuth setting
    // example: set prompt mode
    Prompt = MicrosoftOAuthPromptModes.SelectAccount
}));
```

![](https://user-images.githubusercontent.com/17783561/154854388-38c473f1-7860-4a47-bdbe-622de37eef8b.png)

A window will pop up prompting the user to enter the email and password for their Microsoft account and proceed to sign in.

{% hint style="info" %}
This method uses [Microsoft WebView2](https://developer.microsoft.com/en-us/microsoft-edge/webview2/) for displaying Microsoft OAuth login page. You must know that:

* **Microsoft WebView2 is only available on Windows.** For another platform, see [Authentication with MSAL](../cmllib.core.auth.microsoft/authentication-with-msal.md).
* To run WebView2, The users (including developer and end user) **must have the WebView2 Runtime installed**. See [this document](https://learn.microsoft.com/en-us/microsoft-edge/webview2/concepts/distribution) to distribute your launcher with WebView2. (For example, you can automate runtime installation with direct download link: [https://go.microsoft.com/fwlink/p/?LinkId=2124703](https://go.microsoft.com/fwlink/p/?LinkId=2124703))

If you don't want to use WebView2, see [Authentication with MSAL](../cmllib.core.auth.microsoft/authentication-with-msal.md).
{% endhint %}

### Silent

```csharp
authenticator.AddMicrosoftOAuth(clientInfo, oauth => oauth.Silent());
```

Proceed with the login without prompting the user for a login. If the cached session hasn't expired, the token will be used; if it has, it will attempt to refresh it. If the refresh fails, a `MicrosoftOAuthException` exception is thrown.

### Signout

Clears only cached OAuth sessions. The browser on user may still have user's login information.

```csharp
authenticator.AddMicrosoftOAuthSignout(clientInfo);
```

### Signout with Clearing Browser Cache

Displays the OAuth sign out page and clears the session.

```csharp
authenticator.AddMicrosoftOAuthBrowserSignout(clientInfo);
```

or, you can set browser options:

```csharp
authenticator.AddMicrosoftOAuthBrowserSignout(clientInfo, codeFlow =>
{
    // set more options like UI title, UI parents, etc... 
    codeFlow.WithUITitle("My Window");
}));
```
