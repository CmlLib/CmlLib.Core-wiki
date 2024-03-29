---
description: JE 인증 시 옵션을 지정
---

# JEAuthenticator

## AddJEAuthenticator

```csharp
authenticator.AddJEAuthenticator();
```

캐시된 JE 세션의 유효성을 먼저 검사하고, 세션이 만료되었거나 유효하지 않은 경우 엑스박스 세션으로 JE 로그인을 시도합니다.

## AddForceJEAuthenticator

```csharp
authenticator.AddForceJEAuthenticator();
```

캐시된 JE 세션의 유효성을 검사하지 않고 무조건 엑스박스 세션으로 JE 로그인을 진행합니다.

## WithGameOwnershipChecker(bool value)

```csharp
authenticator.AddJEAuthenticator(je => je
    .WithGameOwnershipChecker(false)
    .Build());
```

게임을 구매하여 소유하고 있는 지 검사하는 여부를 설정합니다. 기본 값: `false`

{% hint style="warning" %}
이 메서드는 공식 사이트에서 게임을 구매했는지만 검사할 수 있습니다. 엑스박스 게임패스로 정품 계정을 가지고 있는 유저를 이 메서드로 검사하면 계정을 가지고 있지 않는 것으로 판단하기 때문에 기본값 `false` 를 바꾸지 않는 것을 추천합니다.
{% endhint %}

## JEAuthException

마인크래프트 JE 로그인 도중 문제가 발생한 경우 이 예외가 발생합니다. `ErrorType`, `Error`, `ErrorMessage` 속성으로 자세한 에러 내용을 확인할 수 있습니다.

### 403: FORBIDDEN

만약 OAuth 토큰을 써드파티의 클라이언트 아이디로부터 발급받는 경우라면, 클라이언트 아이디를 등록해야 합니다. [clientid.md](../xboxauthnet.game.msal/clientid.md "mention") 의 마지막 부분을 참고하세요.

### 404: NOT\_FOUND

유저가 게임을 가지고 있지 않은 경우. (데모 버전)
