# Офлайн обліковий запис

## Офлайн-вхід

Цю сесію не можна використовувати на серверах у режимі онлайн (online-mode) або в Realms.

```csharp
using CmlLib.Core.Auth;

MSession session = MSession.CreateOfflineSession("username");
```

## Створення власних даних сесії

```csharp
using CmlLib.Core.Auth;

MSession session = new MSession("username", "accesstoken", "uuid");
```
