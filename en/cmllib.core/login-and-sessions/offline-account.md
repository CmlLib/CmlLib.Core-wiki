# Offline Account

## Offline Login

This session cannot be used in online-mode server or realm.

```csharp
using CmlLib.Core.Auth;

MSession session = MSession.CreateOfflineSession("username");
```

## Creating your own session data

```csharp
using CmlLib.Core.Auth;

MSession session = new MSession("username", "accesstoken", "uuid");
```
