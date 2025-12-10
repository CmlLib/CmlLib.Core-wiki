# Home

{% hint style="warning" %}
**This document is outdated!** The latest documentation has moved to [here](https://cmllib.github.io/CmlLib.Core-wiki/en/).
{% endhint %}

![Discord](https://img.shields.io/discord/795952027443527690?label=discord\&logo=discord\&style=for-the-badge)

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

Use Nuget package [MojangAPI](https://www.nuget.org/packages/MojangAPI) or download dll from [release](https://github.com/CmlLib/MojangAPI/releases).

## Usage

Include these namespaces :

```csharp
using MojangAPI;
using MojangAPI.Model;
```

Sample program: [MojangAPISample](https://github.com/CmlLib/MojangAPI/tree/master/MojangAPISample)

### [mojang-api.md](mojang-api.md "mention")

Getting player profile, Changing name or skin, Statistics, Blocked Server, Checking Game Ownership

### [securityquestion.md](securityquestion.md "mention")

Security question-answer flow

### Authentication

For authentication, See [login-and-sessions](../cmllib.core/login-and-sessions/ "mention") or use library [cmllib.core.auth.microsoft](../auth.microsoft/cmllib.core.auth.microsoft/ "mention").
