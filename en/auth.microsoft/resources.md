# Resources

{% hint style="warning" %}
**This document is outdated!** The latest documentation has moved to [here](https://cmllib.github.io/CmlLib.Core-wiki/en/).
{% endhint %}

## Logs

All libraries uses Microsoft.Extensions.Logging for logging. ([docs](https://learn.microsoft.com/en-us/dotnet/core/extensions/logging?tabs=command-line))

### Log Event Id

<table><thead><tr><th width="206">EventId</th><th>Meaning</th></tr></thead><tbody><tr><td>749xxx</td><td>Logs from <a data-mention href="xboxauthnet.game/">xboxauthnet.game</a>.</td></tr><tr><td>750xxx</td><td>Logs from <a data-mention href="xboxauthnet.game.msal/">xboxauthnet.game.msal</a>.</td></tr><tr><td>751xxx</td><td>Logs from <a data-mention href="cmllib.core.auth.microsoft/">cmllib.core.auth.microsoft</a>.</td></tr><tr><td>752xxx</td><td>Logs from <a data-mention href="cmllib.core.bedrock.auth.md">cmllib.core.bedrock.auth.md</a>.</td></tr><tr><td>xxx0xx</td><td>Trace</td></tr><tr><td>xxx1xx</td><td>Debug</td></tr><tr><td>xxx2xx</td><td>Information</td></tr><tr><td>xxx3xx</td><td>Warning</td></tr><tr><td>xxx4xx</td><td>Error</td></tr><tr><td>xxx5xx</td><td>Critical</td></tr></tbody></table>

## Known Issues

### System.ArgumentException with Costura.Fody

[issue 19](https://github.com/CmlLib/CmlLib.Core.Auth.Microsoft/issues/19)

There is a issue when you use WebView2 and Costura.Fody together.

### Age related issues (child, age verification, family account, etc)

1. Make sure your Xbox authentication flow uses Full() or Sisu(). [xboxauth.md](xboxauthnet.game/xboxauth.md "mention")
2. Make sure the account you're trying to sign in with is the one you purchased Minecraft with, as most users experiencing this error were trying to sign in with an account that didn't purchase Minecraft.
3. Try turning on the Mojang Launcher, logging out, and logging back in from the Mojang Launcher. If you need to do anything age-related, the Mojang Launcher will tell you how.
4. Try signing out of the [Xbox](https://www.xbox.com) and signing back in. If you need to take any age-related actions, you should see a page shortly after signing in.

You'll need a properly age verified account to log in to Minecraft. Age verification is usually done automatically by the Mojang Launcher, so accounts that can be logged in from the Mojang Launcher will not see this error.

Minors can log in from the Mojang Launcher if they go through both the age verification and family account registration process. However, if a parent has blocked them from playing the game, or if the account has been removed from the family, the error may occur again. Try logging in again from the Mojang Launcher and it will let you know what you need to do.
