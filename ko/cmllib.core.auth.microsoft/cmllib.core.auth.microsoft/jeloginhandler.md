---
description: 로그인, 로그아웃, 계정 관리
---

# JELoginHandler

로그인, 로그아웃, 계정 관리 기능을 제공합니다.

## loginHandler 인스턴스 만들기

```csharp
var loginHandler = JELoginHandlerBuilder.BuildDefault();
```

계정 저장 방식 지정, HttpClient 설정 등 더 자세한 설정 방법은 JELoginHandlerBuilder 문서를 참고하세요.

## 기본 로그인

```csharp
var session = await loginHandler.Authenticate();
```

이 메서드는 먼저 [#undefined-2](jeloginhandler.md#undefined-2 "mention")을 시도하고, 만약 실패한다면 [#undefined-1](jeloginhandler.md#undefined-1 "mention")을 시도합니다.

## 새로운 계정으로 로그인

```csharp
var session = await loginHandler.AuthenticateInteractively();
```

![](https://user-images.githubusercontent.com/17783561/154854388-38c473f1-7860-4a47-bdbe-622de37eef8b.png)

새로운 계정을 추가하여 로그인합니다. 사용자에게 Microsoft OAuth 페이지를 표시하여 마이크로소프트 계정을 입력하도록 합니다.

## 가장 최근에 플레이한 계정으로 로그인

```csharp
var session = await loginHandler.AuthenticateSilently();
```

가장 최근에 플레이한 계정 정보를 이용하여 로그인합니다.&#x20;

* 만약 이미 유저가 로그인 된 상태라면, 로그인 정보를 즉시 반환합니다.&#x20;
* 만약 로그인 정보가 만료된 상태라면, 세션 refresh 를 시도합니다. 이 과정은 유저와의 상호작용이나 웹뷰 없이 진행됩니다.
* 만약 유저의 로그인 정보가 저장되어 있지 않거나 세션 refresh 에 실패한다면 `MicrosoftOAuthException` 예외가 발생합니다. 이 경우 [#undefined-1](jeloginhandler.md#undefined-1 "mention")같은 메서드를 통해 로그인을 다시 진행해야 합니다.&#x20;

## 계정 목록 나열하기

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
foreach (var account in accounts)
{
    if (account is not JEGameAccount jeAccount)
        continue;
    Console.WriteLine("Identifier: " + jeAccount.Identifier);
    Console.WriteLine("LastAccess: " + jeAccount.LastAccess);
    Console.WriteLine("Gamertag: " + jeAccount.XboxTokens?.XstsToken?.XuiClaims?.Gamertag);
    Console.WriteLine("Username: " + jeAccount.Profile?.Username);
    Console.WriteLine("UUID: " + jeAccount.Profile?.UUID);
}
```

로그인에 성공한 계정은 저장됩니다. 위 코드는 저장된 계정 목록을 출력합니다.

## 계정 선택

index 번호로 계정 선택하기:&#x20;

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.ElementAt(1);
```

모든 계정은 계정을 구분하기 위한 유일한 문자열 값(Identifier)을 가지고 있습니다. Identifier으로 계정 선택하기:

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.GetAccount("Identifier");
```

JE 계정의 유저네임으로 계정 선택하기:

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.GetJEAccountByUsername("username");
```

## 선택한 계정으로 로그인

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.ElementAt(1);
var session = await loginHandler.Authenticate(selectedAccount);
```

계정 목록을 불러온 후 두번째 계정 (index number 1) 으로 로그인을 시도합니다.

## 가장 최근에 로그인한 계정을 로그아웃

```csharp
await loginHandler.Signout();
```

## 선택한 계정 로그아웃

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.ElementAt(1);
await loginHandler.Signout(selectedAccount);
```

계정 목록을 불러온 후 두번째 계정 (index number 1) 으로 로그아웃을 시도합니다.

## 로그인 설정

로그인 과정을 자세하게 설정할 수 있습니다.

```csharp
using XboxAuthNet.Game;

var authenticator = loginHandler.CreateAuthenticator(account, default);
authenticator.AddMicrosoftOAuthForJE(oauth => oauth.Interactive()); // Microsoft OAuth
authenticator.AddXboxAuthForJE(xbox => xbox.Basic()); // XboxAuth
authenticator.AddJEAuthenticator(); // JEAuthenticator
var session = await authenticator.ExecuteForLauncherAsync();
```

로그인은 크게 네 과정을 거칩니다.

### 1. CreateAuthenticator

`Authenticator` 를 만듭니다.

#### CreateAuthenticator(XboxGameAccount account, CancellationToken cancellationToken)

설정한 `account` 로 `Authenticator` 를 만듭니다.

#### CreateAuthenticatorWithNewAccount(CancellationToken cancellationToken)

새로운 계정으로 로그인하기 위한 `Authenticator` 를 만듭니다.

#### CreateAuthenticatorWithDefaultAccount(CancellationToken cancellationToken)

가장 최근에 로그인한 계정으로 `Authenticator` 를 만듭니다.

### 2. Microsoft OAuth

기본 로그인 방식은 [oauth.md](../xboxauthnet.game/oauth.md "mention")을 참고하세요.

#### AddMicrosoftOAuthForJE(oauthBuilder)

`AddMicrosoftOAuth(JELoginHandler.DefaultMicrosoftOAuthClientInfo, oauthBuilder)` 와 같습니다.

#### AddForceMicrosoftOAuthForJE(oauthBuilder)

`AddForceMicrosoftOAuth(JELoginHandler.DefaultMicrosoftOAuthClientInfo, oauthBuilder)` 와 같습니다.

MSAL 로그인 방식은 [oauth.md](../xboxauthnet.game.msal/oauth.md "mention")를 참고하세요.

### 3. XboxAuth

[xboxauth.md](../xboxauthnet.game/xboxauth.md "mention") 를 참고하세요.

#### AddXboxAuthForJE(xboxBuilder)

JE 의 기본 RelyingParty 를 설정한 xboxBuilder 를 제공합니다.

### 4. JEAuthenticator

[jeauthenticator.md](jeauthenticator.md "mention") 를 참고하세요.
