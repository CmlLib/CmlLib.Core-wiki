---
description: 로그인, 로그아웃, 계정 관리
---

# JELoginHandler

로그인, 로그아웃, 계정 관리 기능을 제공합니다.

## loginHandler 인스턴스 만들기

```csharp
var loginHandler = JELoginHandlerBuilder.BuildDefault();
```

계정 저장 방식 지정, HttpClient 설정 등 더 자세한 설정 방법은 [jeloginhandlerbuilder.md](jeloginhandlerbuilder.md "mention") 문서를 참고하세요.

## 기본 로그인

```csharp
var session = await loginHandler.Authenticate();
// var session = await loginHandler.Authenticate(selectedAccount, cancellationToken);
```

이 메서드는 먼저 [#silent](jeloginhandler.md#silent "mention")을 시도하고, 만약 실패한다면 [#interactive](jeloginhandler.md#interactive "mention")을 시도합니다.

## 새로운 계정으로 로그인 <a href="#interactive" id="interactive"></a>

```csharp
var session = await loginHandler.AuthenticateInteractively();
// var session = await loginHandler.AuthenticateInteractively(selectedAccount, cancellationToken);
```

![](https://user-images.githubusercontent.com/17783561/154854388-38c473f1-7860-4a47-bdbe-622de37eef8b.png)

새로운 계정을 추가하여 로그인합니다. 사용자에게 Microsoft OAuth 페이지를 표시하여 마이크로소프트 계정을 입력하도록 합니다.

{% hint style="info" %}
이 메서드는 마이크로소프트 OAuth 로그인 페이지를 표시하기 위해서 [Microsoft WebView2](https://developer.microsoft.com/en-us/microsoft-edge/webview2/) 를 사용합니다. 이 내용을 반드시 숙지하고 있어야 합니다.

* **Microsoft WebView2 는 Windows 에서만 사용 가능합니다.** 다른 플랫폼에서 사용하기 위해서는 [xboxauthnet.game.msal](../xboxauthnet.game.msal/ "mention") 가 필요합니다.
* WebView2 를 사용하기 위해서는 유저들은 (개발자와 최종 사용자 포함) **반드시 WebView2 Runtime이 설치되어 있어야 합니다.** [이 문서](https://learn.microsoft.com/en-us/microsoft-edge/webview2/concepts/distribution)를 참고하여 런처를 WebView2와 함께 배포하는 방법을 알아보세요. (예를 들어 런타임 설치를 direct download link 로 자동화 할 수 있습니다: [https://go.microsoft.com/fwlink/p/?LinkId=2124703](https://go.microsoft.com/fwlink/p/?LinkId=2124703))

만약 WebView2 없이 로그인을 하고 싶다면 [xboxauthnet.game.msal](../xboxauthnet.game.msal/ "mention") 을 대신 사용할 수 있습니다.
{% endhint %}

## 가장 최근에 플레이한 계정으로 로그인 <a href="#silent" id="silent"></a>

```csharp
var session = await loginHandler.AuthenticateSilently();
// var session = await loginHandler.AuthenticateSilently(selectedAccount, cancellationToken);
```

가장 최근에 플레이한 계정 정보를 이용하여 로그인합니다.

* 만약 이미 유저가 로그인 된 상태라면, 로그인 정보를 즉시 반환합니다.
* 만약 로그인 정보가 만료된 상태라면, 세션 refresh 를 시도합니다. 이 과정은 유저와의 상호작용이나 웹뷰 없이 진행됩니다.
* 만약 유저의 로그인 정보가 저장되어 있지 않거나 세션 refresh 에 실패한다면 `MicrosoftOAuthException` 예외가 발생합니다. 이 경우 [#interactive](jeloginhandler.md#interactive "mention")같은 메서드를 통해 로그인을 다시 진행해야 합니다.

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

로그인에 성공한 계정은 자동으로 계정 정보가 파일에 저장됩니다. 위 코드는 저장되어 있는 모든 계정의 정보를 출력합니다.&#x20;

계정 정보를 파일에 저장하는 방식을 바꾸려면 [#withaccountmanager](jeloginhandlerbuilder.md#withaccountmanager "mention")를 참고하세요.

## 계정 선택

index 번호로 계정 선택하기:

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.ElementAt(1);
```

각 계정은 계정을 구분하기 위한 유일한 문자열 값(Identifier)을 가지고 있습니다. Identifier으로 계정을 선택하려면:

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.GetAccount("Identifier");
```

JE 계정의 유저네임으로 계정을 선택하려면:

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

{% hint style="info" %}
`Signout` 메서드는 WebView2 브라우저의 캐시를 지우지 않습니다. 브라우저 캐시도 같이 지우기 위해서는 `SignoutWithBrowser` 메서드를 이용하세요.
{% endhint %}

```csharp
await loginHandler.Signout();
// await loginHandler.SignoutWithBrowser();
```

## 선택한 계정 로그아웃

{% hint style="info" %}
`Signout` 메서드는 WebView2 브라우저의 캐시를 지우지 않습니다. 브라우저 캐시도 같이 지우기 위해서는 `SignoutWithBrowser` 메서드를 이용하세요.
{% endhint %}

```csharp
var accounts = loginHandler.AccountManager.GetAccounts();
var selectedAccount = accounts.ElementAt(1);
await loginHandler.Signout(selectedAccount);
// await loginHandler.SignoutWithBrowser();
```

계정 목록을 불러온 후 두번째 계정 (index number 1) 으로 로그아웃을 시도합니다.

## 더 많은 로그인 옵션

```csharp
using XboxAuthNet.Game;

// 1. Authenticator 생성
var authenticator = loginHandler.CreateAuthenticator(account, default);

// 2. OAuth
authenticator.AddMicrosoftOAuthForJE(oauth => oauth.Interactive());

// 3. XboxAuth
authenticator.AddXboxAuthForJE(xbox => xbox.Basic());

// 4. JEAuthenticator
authenticator.AddJEAuthenticator();

// authenticator 실행
var session = await authenticator.ExecuteForLauncherAsync();
```

로그인 과정은 크게 네 과정을 거칩니다. 각 과정에서 로그인 과정을 바꿀 수 있는 많은 메서드들이 있습니다. 각 과정 안에서 반드시 하나의 메서드를 선택해야 합니다.

### 1. Authenticator 생성

```csharp
var authenticator = loginHandler.CreateAuthenticator(account, default);
```

선택한 계정으로 로그인을 진행하는 `Authenticator` 를 초기화합니다. 다른 방법도 있습니다:

```csharp
var authenticator = loginHandler.CreateAuthenticatorWithNewAccount(default);
```

빈 계정을 새로 만들어 `Authenticator` 를 초기화합니다. [#interactive](jeloginhandler.md#interactive "mention")에서 사용합니다.

```csharp
var authenticator = loginHandler.CreateAuthenticatorWithDefaultAccount(default);
```

가장 최근에 로그인한 계정으로 `Authenticator` 를 초기화합니다. [#silent](jeloginhandler.md#silent "mention")에서 사용합니다.

`default` 대신 [CancellationToken](https://learn.microsoft.com/en-us/dotnet/api/system.threading.cancellationtoken?view=net-7.0) 를 넣어 쓸 수 있습니다.

### 2. OAuth

```csharp
authenticator.AddMicrosoftOAuthForJE(oauth => oauth.Interactive());

// 위 코드는 아래와 같습니다:
// authenticator.AddMicrosoftOAuth(JELoginHandler.DefaultMicrosoftOAuthClientInfo, oauth => oauth.Interactive());

// OAuth 다른 방법:
// 1) authenticator.AddForceMicrosoftOAuthForJE(oauth => oauth.Interactive());
// 2) authenticator.AddMicrosoftOAuthForJE(oauth => oauth.Silent());
```

Microsoft OAuth 모드를 설정합니다. `oauth => oauth.Interactive()` 대신 사용할 수 있는 많은 옵션들이 있습니다. [oauth.md](../xboxauthnet.game/oauth.md "mention") 참고.

`AddMicrosoftOAuthForJE` 와 `AddForceMicrosoftOAuthForJE` 메서드는 모장 마인크래프트 런처에서 사용하는 기본 `MicrosoftOAuthClientInfo` 를 자동으로 추가합니다.

`AddMicrosoftOAuth` 는 Windows 플랫폼에서만 작동합니다. 다른 플랫폼(Linux, macOS) 에서 사용하기 위해서는 [xboxauthnet.game.msal](../xboxauthnet.game.msal/ "mention") 을 사용하세요.

```csharp
// XboxAuthNet.Game.Msal 예시
authenticator.AddMsalOAuth(app, msal => msal.Interactive());
```

### 3. XboxAuth

```csharp
authenticator.AddXboxAuthForJE(xbox => xbox.Basic());

// 위 코드는 아래와 같습니다:
// authenticator.AddXboxAuth(xbox => xbox.WithRelyingParty(JELoginHandler.RelyingParty).Basic());

// 다른 xbox auth 방법:
// 1) authenticator.AddXboxAuthForJE(xbox => xbox.Full());
// 2) authenticator.AddXboxAuthForJE(xbox => xbox.Sisu("<CLIENT-ID>"));
```

Xbox 로그인 모드 설정. `xbox => xbox.Basic()` 대신 사용할 수 있는 많은 옵션들이 있습니다. [xboxauth.md](../xboxauthnet.game/xboxauth.md "mention") 참고.

`AddXboxAuthForJE` 와 `AddForceXboxAuthForJE` 메서드는 마인크래프트 자바 에디션에서 사용하는 기본 relying party 를 자동으로 설정합니다.

### 4. JEAuthenticator

Minecraft: JE 로그인 모드 설정. [jeauthenticator.md](jeauthenticator.md "mention") 참고.
