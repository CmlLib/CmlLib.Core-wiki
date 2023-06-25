# Offline Account

## Offline Login

This session cannot be used in online-mode server or realm.

```csharp
MSession session = MSession.GetOfflineSession("username");
```

## Creating your own session data

```csharp
MSession session = new MSession("username", "accesstoken", "uuid");
```
