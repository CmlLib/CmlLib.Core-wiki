---
description: 여러 계정 관리
---

# AccountManager

여러 계정을 관리하는 방법을 설명합니다. 각 계정은 `identifier` 이라는 고유한 값으로 식별됩니다.

{% hint style="info" %}
마인크래프트: 자바 에디션 계정에 대한 정보는 [jeloginhandler.md](../cmllib.core.auth.microsoft/jeloginhandler.md "mention")에 더 자세히 설명되어 있습니다.
{% endhint %}

## 모든 계정 불러오기

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
foreach (var account in accounts)
{
    Console.WriteLine(account.Identifier);
}
```

## Identifier 으로 계정 불러오기

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var account = accounts.GetAccount("identifier");
```

## 가장 최근에 플레이한 계정 가져오기

```csharp
var account = loginHandler.AccountManager.GetDefaultAccount();
```

## 새로운 계정 만들기

```csharp
var account = loginHandler.AccountManager.NewAccount();
```

## 모든 계정 정보 삭제

```csharp
loginHandler.AccountManager.ClearAccounts();
```

## 계정 정보 저장

```csharp
loginHandler.AccountManager.SaveAccounts();
```
