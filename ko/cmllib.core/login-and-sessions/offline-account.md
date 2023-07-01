# 오프라인 계정

## 오프라인 로그인

이 세션은 online-mode 서버나 렐름에 접속할 수 없습니다.

```csharp
MSession session = MSession.GetOfflineSession("username");
```

## Creating your own session data

```csharp
MSession session = new MSession("username", "accesstoken", "uuid");
```
