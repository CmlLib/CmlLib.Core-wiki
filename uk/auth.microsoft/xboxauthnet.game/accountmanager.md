---
description: Управління кількома обліковими записами
---

# AccountManager

Описує процес управління кількома обліковими записами. Кожен обліковий запис ідентифікується унікальним значенням — `identifier`.

!!! info "Облікові записи Minecraft: Java Edition"
    Додаткові методи для облікових записів Minecraft: Java Edition дивіться у розділі [JELoginHandler](../cmllib.core.auth.microsoft/jeloginhandler.md).

## Отримання всіх облікових записів

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
foreach (var account in accounts)
{
    Console.WriteLine(account.Identifier);
}
```

## Отримання облікового запису за ідентифікатором

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var account = accounts.GetAccount("identifier");
```

## Отримання останнього використаного облікового запису

```csharp
var account = loginHandler.AccountManager.GetDefaultAccount();
```

## Створення нового порожнього облікового запису

```csharp
var account = loginHandler.AccountManager.NewAccount();
```

## Очищення всіх облікових записів

```csharp
loginHandler.AccountManager.ClearAccounts();
```

## Збереження

```csharp
loginHandler.AccountManager.SaveAccounts();
```

## Довідник API

- [JEGameAccount](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/CmlLib.Core.Auth.Microsoft.Sessions.JEGameAccount.html)
- [IXboxGameAccountManager](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/XboxAuthNet.Game.Accounts.IXboxGameAccountManager.html)
