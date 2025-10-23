# Login and Sessions

To connect to online-mode server, you should obtain player's session data. The game session data contains player's username, UUID, and accessToken.

There are some ways to obtain game session:

* [Microsoft Xbox Account](Microsoft-Xbox-Live-Login.md)
* [Offline Account](offline-account.md)

After obtaining a session data, you should set the `MLaunchOption.Session` property to an `MSession` instance. [Launch Options](../getting-started/MLaunchOption.md)

# API Reference

- [MSession](https://cmllib.github.io/CmlLib.Core.Commons/api/CmlLib.Core.Auth.MSession.html)