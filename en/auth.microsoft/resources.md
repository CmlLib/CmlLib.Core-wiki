# Resources

## Logs

All libraries uses Microsoft.Extensions.Logging for logging. ([docs](https://learn.microsoft.com/en-us/dotnet/core/extensions/logging?tabs=command-line))

### Log Event Id

| EventId | Meaning |
|---------|---------|
| 749xxx | Logs from xboxauthnet.game. |
| 750xxx | Logs from xboxauthnet.game.msal. |
| 751xxx | Logs from cmllib.core.auth.microsoft. |
| 752xxx | Logs from cmllib.core.bedrock.auth.md. |
| xxx0xx | Trace |
| xxx1xx | Debug |
| xxx2xx | Information |
| xxx3xx | Warning |
| xxx4xx | Error |
| xxx5xx | Critical |

## Known Issues

### System.ArgumentException with Costura.Fody

[issue 19](https://github.com/CmlLib/CmlLib.Core.Auth.Microsoft/issues/19)

There is a issue when you use WebView2 and Costura.Fody together.

### Age related issues (child, age verification, family account, etc)

1. Make sure your Xbox authentication flow uses Full() or Sisu(). [XboxAuth](xboxauthnet.game/xboxauth.md)
2. Make sure the account you're trying to sign in with is the one you purchased Minecraft with, as most users experiencing this error were trying to sign in with an account that didn't purchase Minecraft.
3. Try turning on the Mojang Launcher, logging out, and logging back in from the Mojang Launcher. If you need to do anything age-related, the Mojang Launcher will tell you how.  
4. Try signing out of the [Xbox](https://www.xbox.com) and signing back in. If you need to take any age-related actions, you should see a page shortly after signing in.

You'll need a properly age verified account to log in to Minecraft. Age verification is usually done automatically by the Mojang Launcher, so accounts that can be logged in from the Mojang Launcher will not see this error.  

Minors can log in from the Mojang Launcher if they go through both the age verification and family account registration process. However, if a parent has blocked them from playing the game, or if the account has been removed from the family, the error may occur again. Try logging in again from the Mojang Launcher and it will let you know what you need to do.
