---
description: '마인크래프트: 자바 에디션의 로그인, 로그아웃, 계정 관리'
---

# CmlLib.Core.Auth.Microsoft

## 설치

nuget package [CmlLib.Core.Auth.Microsoft](https://www.nuget.org/packages/CmlLib.Core.Auth.Microsoft)

```
dotnet add package CmlLib.Core.Auth.Microsoft
```

## 시작하기

```csharp
using CmlLib.Core.Auth.Microsoft;

var loginHandler = JELoginHandlerBuilder.BuildDefault();
var session = await loginHandler.Authenticate();
```

[실행 옵션](../../cmllib.core/getting-started/MLaunchOption.md)의 `Session` 속성으로 설정하세요.

## 예제

[CmlLib-Minecraft-Launcher](https://github.com/CmlLib/CmlLib-Minecraft-Launcher): CmlLib.Core and CmlLib.Core.Auth.Microsoft sample launcher.

[WinFormTest](https://github.com/CmlLib/CmlLib.Core.Auth.Microsoft/blob/dev/examples/WinFormTest)

[ConsoleTest](https://github.com/CmlLib/CmlLib.Core.Auth.Microsoft/blob/dev/examples/ConsoleTest/Program.cs)

## 사용 방법

### [JELoginHandler](jeloginhandler.md)

로그인, 로그아웃 기능과 계정 관리 기능을 제공합니다.

### [JELoginHandlerBuilder](jeloginhandlerbuilder.md)

JELoginHandler 의 인스턴스를 만들어 주는 객체입니다.

### [AccountManager](../xboxauthnet.game/accountmanager.md)

여러 계정을 저장하고 불러올 수 있습니다.
