---
description: Xbox Authentication
---

# XboxAuth

## Basic

```csharp
authenticator.AddXboxAuth(xbox => xbox.Basic("relyingParty"));
```

This is the most basic approach. It only gets the minimum information (UserToken, XstsToken) needed to log in.

Accounts that are not age-verified, and accounts that are under the age of 18 may experience issues when logging in this way (error codes `8015dc0c`, `8015dc0d`, `8015dc0e`).\
You can work around this by using the Full method or the Sisu method.

## Full

```csharp
authenticator.AddXboxAuth(xbox => xbox.Full("relyingParty"));
```

Gets the UserToken, DeviceToken, and XstsToken.

## Sisu

```csharp
authenticator.AddXboxAuth(xbox => xbox.Sisu("relyingParty",  "<CLIENT-ID>"));
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