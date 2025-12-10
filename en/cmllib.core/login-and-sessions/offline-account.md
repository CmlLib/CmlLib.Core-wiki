# Offline Account

{% hint style="warning" %}
**This document is outdated!** The latest documentation has moved to [here](https://cmllib.github.io/CmlLib.Core-wiki/en/).
{% endhint %}

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
