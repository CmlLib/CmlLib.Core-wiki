---
description: JELoginHandler 초기화를 위한 빌더
---

# JELoginHandlerBuilder

```csharp
// 기본 옵션과 함께 JELoginHandler 초기화
var loginHandler = JELoginHandlerBuilder.BuildDefault();
```

```csharp
var loginHandler = new JELoginHandlerBuilder()
    .WithHttpClient(httpClient)
    .WithAccountManager("accounts.json")
    //.WithAccountManager(new InMemoryXboxGameAccountManager(JEGameAccount.FromSessionStorage))
    .Build();
var session = await loginHandler.Authenticate();
```

### WithHttpClient

HTTP 요청에 사용될 `HttpClient` 객체를 설정합니다. 모든 HTTP 요청은 여기서 설정한 `HttpClient` 를 통해 이루어집니다.

### WithAccountManager

`JELoginHandler` 에서 사용할 `IXboxGameAccountManager` 객체를 설정합니다. 기본값은 `<마인크래프트_폴더>/cml_accounts.json` 파일을 사용하는 `JsonXboxGameAccountManager` 객체입니다.

`string` 인수를 넘겨준 경우 `WithAccountManager(new JsonXboxGameAccountManager(filePath, JEGameAccount.FromSessionStorage))` 를 호출합니다.

### WithLogger

로그 기록을 위한 [ILogger](https://learn.microsoft.com/en-us/dotnet/api/microsoft.extensions.logging.ilogger?view=dotnet-plat-ext-7.0) 인스턴스를 설정합니다. 자세한 정보는 [자료](../resources.md#logs)확인

