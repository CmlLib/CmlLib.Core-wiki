---
description: Xbox Authentication
---

# XboxAuth

{% hint style="warning" %}
**This document is outdated!** The latest documentation has moved to [here](https://cmllib.github.io/CmlLib.Core-wiki/en/).
{% endhint %}

## Example

```csharp
var authenticator = // create authenticator using login handlers
authenticator.AddXboxAuthForJE(xbox => xbox.Basic());
//authenticator.AddXboxAuth(xbox => xbox.Basic(XboxAuthConstants.XboxLiveRelyingParty)); // same code
```

## Basic

```csharp
authenticator.AddXboxAuthForJE(xbox => xbox.Basic());
//authenticator.AddXboxAuth(xbox => xbox.Basic("relyingParty"));
```

This is the most basic method. It only gets the minimum information (UserToken, XstsToken) needed to log in.

Accounts that are not age-verified, and accounts that are under the age of 18 may experience issues when logging in this way (error codes `8015dc0c`, `8015dc0d`, `8015dc0e`).\
You can work around this by using the [#full](xboxauth.md#full "mention") method or the [#sisu](xboxauth.md#sisu "mention") method.

## Full

```csharp
authenticator.AddXboxAuthForJE(xbox => xbox.Full());
//authenticator.AddXboxAuth(xbox => xbox.Full("relyingParty"));
```

Gets the UserToken, DeviceToken, and XstsToken.

## Sisu

```csharp
authenticator.AddXboxAuthForJE(xbox => xbox.Sisu(XboxGameTitles.MinecraftJava));
//authenticator.AddXboxAuth(xbox => xbox.Sisu("relyingParty",  "<CLIENT-ID>"));
```

Use the SISU login method. Get all tokens: UserToken, DeviceToken, TitleToken, XstsToken. Most age-related issues can be resolved this way.

This only works if `<CLIENT-ID>` is related to an Xbox game (for example, the CLIENT-ID used by the Minecraft launcher).

You can't use a personally issued Azure ID, i.e. you can't use it with MSAL.

## Device Options

```csharp
authenticator.AddXboxAuth(xbox => xbox
    .WithDeviceType(XboxDeviceTypes.Win32)
    .WithDeviceVersion("0.0.0")
    .Full("relyingParty"));
```

When using a authentication method that gets a DeviceToken, you can apply the Device settings. Call `.WithDeviceType()` and `.WithDeviceVersion()` before calling the authentication method.

## Handling errors

There are various error scenarios when authenticating with Xbox. If an error occurs during authentication, an `XboxAuthException` is thrown and you can get an ErrorCode and ErrorMessage.

All ErrorCodes can be found [xboxauthexception.md](xboxauthexception.md "mention").
