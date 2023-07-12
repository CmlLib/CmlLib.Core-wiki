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
