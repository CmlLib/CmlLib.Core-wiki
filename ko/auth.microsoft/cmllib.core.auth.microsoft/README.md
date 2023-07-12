---
description: '마인크래프트: 자바 에디션의 로그인, 로그아웃, 계정 관리'
---

# CmlLib.Core.Auth.Microsoft

## 설치

nuget package [CmlLib.Core.Auth.Microsoft](https://www.nuget.org/packages/CmlLib.Core.Auth.Microsoft)

## 간단한 사용 방법

```csharp
using CmlLib.Core.Auth.Microsoft;

var loginHandler = JELoginHandlerBuilder.BuildDefault();
var session = await loginHandler.Authenticate();
```

`Session` [MLaunchOption.md](../../cmllib.core/getting-started/MLaunchOption.md "mention")을 여기서 얻은 session 변수로 설정하세요.

## 예제

[CmlLib-Minecraft-Launcher](https://github.com/CmlLib/CmlLib-Minecraft-Launcher): CmlLib.Core and CmlLib.Core.Auth.Microsoft sample launcher.

[WinFormTest](https://github.com/CmlLib/CmlLib.Core.Auth.Microsoft/blob/dev/examples/WinFormTest)

[ConsoleTest](https://github.com/CmlLib/CmlLib.Core.Auth.Microsoft/blob/dev/examples/ConsoleTest/Program.cs)

## 사용 방법

### [jeloginhandlerbuilder.md](jeloginhandlerbuilder.md "mention")

JELoginHandler 의 인스턴스를 만들어 주는 객체입니다.

### [jeloginhandler.md](jeloginhandler.md "mention")

로그인, 로그아웃 기능과 계정 관리 기능을 제공합니다.

### [accountmanager.md](../xboxauthnet.game/accountmanager.md "mention")

여러 계정을 저장하고 불러올 수 있습니다.
