---
description: Manage multiple accounts
---

# AccountManager

Describes how to manage multiple accounts. Each account is identified by a unique value called `identifier`.

!!! info "Minecraft: Java Edition Accounts"
    For more methods for Minecraft: Java Edition account, see [JELoginHandler](../cmllib.core.auth.microsoft/jeloginhandler.md).

## Get All Accounts

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
foreach (var account in accounts)
{
    Console.WriteLine(account.Identifier);
}
```

## Get Account by Identifier

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var account = accounts.GetAccount("identifier");
```

## Get the Most Recent Account

```csharp
var account = loginHandler.AccountManager.GetDefaultAccount();
```

## Create New Empty Account

```csharp
var account = loginHandler.AccountManager.NewAccount();
```

## Clear All Accounts

```csharp
loginHandler.AccountManager.ClearAccounts();
```

## Save

```csharp
loginHandler.AccountManager.SaveAccounts();
```
