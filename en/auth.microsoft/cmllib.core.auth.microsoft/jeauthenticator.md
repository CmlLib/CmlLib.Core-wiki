---
description: Set the options for JE authentication
---

# JEAuthenticator

## AddJEAuthenticator

```csharp
authenticator.AddJEAuthenticator();
```

The cached JE session is validated first, and if the session is expired or invalid, the JE authentication is attempted with the Xbox session.

## AddForceJEAuthenticator

```csharp
authenticator.AddForceJEAuthenticator();
```

Proceeds with the JE sign-in to the Xbox session, without validating the cached JE session.

## WithGameOwnershipChecker(bool value)

```csharp
authenticator.AddJEAuthenticator(je => je
    .WithGameOwnershipChecker(false)
    .Build());
```

Sets whether to check if the game is purchased and owned. default: `false`

!!! info "Game Ownership Checker"
    GameOwnershipChecker can only check if the game was purchased from the official Mojang site. It is recommended that you **DO NOT change the default value** of false because Xbox GamePass user will be determined that they do not have an account even they have valid game license.

## JEAuthException

This exception is thrown if something went wrong while logging into Minecraft JE. The `ErrorType`, `Error`, and `ErrorMessage` properties provide detailed error information.

### 403: FORBIDDEN

If the OAuth token is from third-party client id, you should register the client ID. See the last part of [ClientID](../xboxauthnet.game.msal/clientid.md).

### 404: NOT_FOUND

The user doesn't have the game. (Demo version)

## API Reference

- [Extensions](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/CmlLib.Core.Auth.Microsoft.Extensions.html)
- [JEAuthenticatorBuilder](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/CmlLib.Core.Auth.Microsoft.Authenticators.JEAuthenticatorBuilder.html)