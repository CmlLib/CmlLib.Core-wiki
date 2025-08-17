---
description: Microsoft OAuth
---

# OAuth

`ICompositeAuthenticator` 의 확장 메서드를 통해서 `Authenticator` 를 추가하세요.

## 예시

```csharp
using XboxAuthNet.Game;

var clientInfo = new MicrosoftOAuthClientInfo("<MICROSOFT_OAUTH_CLIENT_ID>", "<MICROSOFT_OAUTH_SCOPES>");
var authenticator = // create authenticator using login handlers

// example 1
authenticator.AddForceMicrosoftOAuth(clientInfo, oauth => oauth.Interactive());

// example 2
authenticator.AddMicrosoftOAuth(clientInfo, oauth => oauth.Silent());

// example 3 (with CmlLib.Core.Auth.Microsoft)
authenticator.AddMicrosoftOAuthForJE(oauth => oauth.Interactive());
```

## AddMicrosoftOAuth / AddForceMicrosoftOAuth

`AddMicrosoftOAuth` 는 먼저 캐시된 Microsoft OAuth 세션의 유효성을 검사하고 만약 세션이 유효하다면 인증을 진행하지 않고 다음 authenticator 로 넘어갑니다.

`AddForceMicrosoftOAuth` 는 유효성 검사 없이 무조건 인증을 진행합니다.

## OAuth 인증 방법

### Interactive

```csharp
authenticator.AddMicrosoftOAuth(clientInfo, oauth => oauth.Interactive());
```

```csharp
authenticator.AddMicrosoftOAuth(clientInfo, oauth => oauth.Interactive(new MicrosoftOAuthParameters
{
    // OAuth setting
    // example: set prompt mode
    Prompt = MicrosoftOAuthPromptModes.SelectAccount
}));
```

![](https://user-images.githubusercontent.com/17783561/154854388-38c473f1-7860-4a47-bdbe-622de37eef8b.png)

유저가 마이크로소프트 계정의 이메일과 비밀번호를 입력하도록 로그인 창을 띄웁니다.

!!! info "Microsoft WebView2"
    이 메서드는 마이크로소프트 OAuth 로그인 페이지를 표시하기 위해서 [Microsoft WebView2](https://developer.microsoft.com/en-us/microsoft-edge/webview2/) 를 사용합니다. 이 내용을 반드시 숙지하고 있어야 합니다.

    * **Microsoft WebView2 는 Windows 에서만 사용 가능합니다.** 다른 플랫폼에서 사용하기 위해서는 [XboxAuthNet.Game.Msal](../xboxauthnet.game.msal/README.md)가 필요합니다.
    * WebView2 를 사용하기 위해서는 유저들은 (개발자와 최종 사용자 포함) **반드시 WebView2 Runtime이 설치되어 있어야 합니다.** [이 문서](https://learn.microsoft.com/en-us/microsoft-edge/webview2/concepts/distribution)를 참고하여 런처를 WebView2와 함께 배포하는 방법을 알아보세요. (예를 들어 런타임 설치를 direct download link 로 자동화 할 수 있습니다: [https://go.microsoft.com/fwlink/p/?LinkId=2124703](https://go.microsoft.com/fwlink/p/?LinkId=2124703))

    만약 WebView2 없이 로그인을 하고 싶다면 [XboxAuthNet.Game.Msal](../xboxauthnet.game.msal/README.md) 을 대신 사용할 수 있습니다.

### Silent

```csharp
authenticator.AddMicrosoftOAuth(clientInfo, oauth => oauth.Silent());
```

유저에게 로그인 창을 띄우지 않고 로그인을 진행합니다. 만약 캐시된 세션이 만료되지 않았다면 캐시된 세션을 그대로 사용하고, 만료되었다면 세션 재발급을 시도합니다. 만약 재발급에 실패하였다면 `MicrosoftOAuthException` 예외가 발생합니다.

### 로그아웃

OAuth 세션을 지웁니다. 브라우저에는 유저의 로그인 정보가 남아있을 수 있습니다.

```csharp
authenticator.AddMicrosoftOAuthSignout(clientInfo);
```

### 브라우저 캐시와 함께 로그아웃

로그아웃 창을 띄워 브라우저의 로그인 정보도 같이 지웁니다.

```csharp
authenticator.AddMicrosoftOAuthBrowserSignout(clientInfo);
```

or, you can set browser options:

```csharp
authenticator.AddMicrosoftOAuthBrowserSignout(clientInfo, codeFlow =>
{
    // set more options like UI title, UI parents, etc... 
    codeFlow.WithUITitle("My Window");
}));
```
