---
description: Manage multiple accounts
---

# AccountManager

{% hint style="warning" %}
**This document is outdated!** The latest documentation has moved to [here](https://cmllib.github.io/CmlLib.Core-wiki/en/).
{% endhint %}

Describes how to manage multiple accounts. Each account is identified by a unique value called `identifier`.

{% hint style="info" %}
For more methods for Minecraft: Java Edition account, see [jeloginhandler.md](../cmllib.core.auth.microsoft/jeloginhandler.md "mention").
{% endhint %}

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
