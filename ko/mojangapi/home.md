# 홈

![Discord](https://img.shields.io/discord/795952027443527690?label=discord&logo=discord&style=for-the-badge)

[GitHub](https://github.com/CmlLib/MojangAPI)

[Mojang API](https://wiki.vg/Mojang_API)를 위한 .NET 라이브러리, [Mojang Authentication](https://wiki.vg/Authentication) 와 [Microsoft Xbox Authentication](https://wiki.vg/Microsoft_Authentication_Scheme).

* Asynchronous API
* Getting Player Data
* Changing Player Name or Skin
* Mojang Authentication
* Microsoft Authentication
* Security Question-Answer
* Statistics

Support:

* netstandard 2.0

## 설치

Use Nuget package [MojangAPI](https://www.nuget.org/packages/MojangAPI) or download dll from [release](https://github.com/CmlLib/MojangAPI/releases).

## 사용법

Include these namespaces :

```csharp
using MojangAPI;
using MojangAPI.Model;
```

Sample program: [MojangAPISample](https://github.com/CmlLib/MojangAPI/tree/master/MojangAPISample)

### [Mojang API](mojang-api.md)

플레이어 프로필 가저오기, 이름이나 스킨 바꾸기, 통계 확인, 차단된 서버 확인, 게임 소유 확인 등등

### [SecurityQuestion](securityquestion.md)

Security question-answer flow

### Authentication

로그인을 위해서 [로그인과 세션](../cmllib.core/login-and-sessions/README.md) 를 확인하거나 [CmlLib.Core.Auth.Microsoft](../auth.microsoft/cmllib.core.auth.microsoft/README.md) 라이브러리를 사용하세요.
