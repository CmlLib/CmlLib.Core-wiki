---
description: Provides the foundation for Xbox game authenticating.
---

# XboxAuthNet.Game

It provides common functionality for Xbox game authentication, including Microsoft OAuth, Xbox authentication, and account management.

For example, the common functionality of CmlLib.Core.Auth.Microsoft for logging into Minecraft Java Edition and CmlLib.Core.Bedrock.Auth for logging into Badrock Edition are both provided by this library.

## Authenticator

### [oauth.md](oauth.md "mention")

Provides OAuth sign-in with a Microsoft account.

### [xboxauth.md](xboxauth.md "mention")

Provides for Xbox authentication with a Microsoft OAuth token.

### Extensions

Authentication are designed to be easily extensible: you can easily add new authenticator, and you can freely reorder them.

For example, there is extension library for Microsoft OAuth using MSAL library, [xboxauthnet.game.msal](../xboxauthnet.game.msal/ "mention").

## Account

### [accountmanager.md](accountmanager.md "mention")

Manage account list.

### [accounts.md](accounts.md "mention")

Manage each account.
