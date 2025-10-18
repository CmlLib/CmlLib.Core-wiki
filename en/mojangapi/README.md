# Home

![Discord](https://img.shields.io/discord/795952027443527690?label=discord&logo=discord&style=for-the-badge)

[GitHub](https://github.com/CmlLib/MojangAPI)

.NET Library for [Mojang API](https://wiki.vg/Mojang_API), [Mojang Authentication](https://wiki.vg/Authentication) and [Microsoft Xbox Authentication](https://wiki.vg/Microsoft_Authentication_Scheme)

* Asynchronous API
* Getting Player Data
* Changing Player Name or Skin
* Mojang Authentication
* Microsoft Authentication
* Security Question-Answer
* Statistics

Support:

* netstandard 2.0

## Install

Use Nuget package [MojangAPI](https://www.nuget.org/packages/MojangAPI)

```
dotnet add package MojangAPI
```

## Usage

Include these namespaces :

```csharp
using MojangAPI;
using MojangAPI.Model;
```

Sample program: [MojangAPISample](https://github.com/CmlLib/MojangAPI/tree/master/MojangAPISample)

### [Mojang API](mojang-api.md)

Getting player profile, Changing name or skin, Statistics, Blocked Server, Checking Game Ownership

### [SecurityQuestion](securityquestion.md)

Security question-answer flow

### Authentication

For authentication, See [Login and Sessions](../cmllib.core/login-and-sessions/README.md) or use library [CmlLib.Core.Auth.Microsoft](../auth.microsoft/cmllib.core.auth.microsoft/README.md).
