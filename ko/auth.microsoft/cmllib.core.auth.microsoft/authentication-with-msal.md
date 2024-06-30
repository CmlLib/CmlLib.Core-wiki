# Authentication with MSAL

JELoginHandler 는 기본적으로 Windows 에서만 작동합니다. 다른 플랫폼에서도 작동하기 위해서는 반드시 [xboxauthnet.game.msal](../xboxauthnet.game.msal/ "mention")와 함께 사용해야 합니다.

MSAL 을 CmlLib.Core.Auth.Microsoft 와 함께 사용하기 위해서는 두 가지 방법이 있습니다.

* `JELoginHandler` 초기화 할 때 `OAuthProvider` 등록하기
* `IAuthenticator` 만들고 MSAL OAuth 추가하기

### OAuthProvider 등록하기

`JELoginHandler` 초기화 할 때 `OAuthProvider` 를 등록하면 이후 호출하는 모든 메서드가 MSAL 을 사용하여 로그인을 처리합니다.&#x20;

```csharp
var app = await MsalClientHelper.BuildApplicationWithCache("CLIENT-ID");
var loginHandler = new JELoginHandlerBuilder()
    .WithOAuthProvider(new MsalCodeFlowProvider(app))
    .Build();
    
// 로그인
var session = await loginHandler.Authenticate();

// 새로운 계정 추가
var session = await loginHandler.AuthenticateInteractively();

// 가장 최근에 로그인한 계정으로 로그인 시도 
var session = await loginHandler.AuthenticateSilently();

// 계정 정보 삭제
await loginHandler.Signout();

// 로그아웃
await loginHandler.SignoutWithBrowser();
```

loginHandler 에 대한 더 자세한 정보는 [jeloginhandler.md](jeloginhandler.md "mention")를 참고하세요.

### AddMsalOAuth 메서드 사용하기

새로운 계정으로 로그인:

```csharp
var app = await MsalClientHelper.BuildApplicationWithCache("CLIENT-ID");
var loginHandler = new JELoginHandlerBuilder()
    .Build();

// 새로운 계정으로 authenticator 만들기
var authenticator = loginHandler.CreateAuthenticatorWithNewAccount();
authenticator.AddMsalOAuth(app, msal => msal.Interactive());
authenticator.AddXboxAuthForJE(xbox => xbox.Basic());
authenticator.AddForceJEAuthenticator();
var session = await authenticator.ExecuteForLauncherAsync();
```

기존 계정으로 로그인:

```csharp
var app = await MsalClientHelper.BuildApplicationWithCache("CLIENT-ID");
var loginHandler = new JELoginHandlerBuilder()
    .Build();

// 가장 최근에 로그인한 계정으로 authenticator 만들기
var authenticator = loginHandler.CreateAuthenticatorWithDefaultAccount();
authenticator.AddMsalOAuth(app, msal => msal.Silent());
authenticator.AddXboxAuthForJE(xbox => xbox.Basic());
authenticator.AddJEAuthenticator();
var session = await authenticator.ExecuteForLauncherAsync();
```

로그아웃:

```csharp
var app = await MsalClientHelper.BuildApplicationWithCache("CLIENT-ID");
var loginHandler = new JELoginHandlerBuilder()
    .Build();
    
var authenticator = loginHandler.CreateAuthenticatorWithDefaultAccount();
authenticator.AddMsalOAuth(app, msal => msal.ClearSession());
authenticator.AddXboxAuthForJE(xbox => xbox.Basic());
authenticator.AddForceJEAuthenticator();
var session = await authenticator.ExecuteForLauncherAsync();
```

`msal.Interactive()`, `msal.Silent()` 등등 msal 의 더 많은 메서드들은 [oauth.md](../xboxauthnet.game.msal/oauth.md "mention")를 참고하세요.

`authenticator` 의 더 자세한 사용 방법은 [#undefined-6](jeloginhandler.md#undefined-6 "mention")을 참고하세요.
