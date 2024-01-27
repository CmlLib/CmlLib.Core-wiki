# Resources

## Logs

All libraries uses Microsoft.Extensions.Logging for logging. ([docs](https://learn.microsoft.com/en-us/dotnet/core/extensions/logging?tabs=command-line))

### Log Event Id

<table><thead><tr><th width="206">EventId</th><th>Meaning</th></tr></thead><tbody><tr><td>749xxx</td><td>Logs from <a data-mention href="xboxauthnet.game/">xboxauthnet.game</a>.</td></tr><tr><td>750xxx</td><td>Logs from <a data-mention href="xboxauthnet.game.msal/">xboxauthnet.game.msal</a>.</td></tr><tr><td>751xxx</td><td>Logs from <a data-mention href="cmllib.core.auth.microsoft/">cmllib.core.auth.microsoft</a>.</td></tr><tr><td>752xxx</td><td>Logs from <a data-mention href="cmllib.core.bedrock.auth.md">cmllib.core.bedrock.auth.md</a>.</td></tr><tr><td>xxx0xx</td><td>Trace</td></tr><tr><td>xxx1xx</td><td>Debug</td></tr><tr><td>xxx2xx</td><td>Information</td></tr><tr><td>xxx3xx</td><td>Warning</td></tr><tr><td>xxx4xx</td><td>Error</td></tr><tr><td>xxx5xx</td><td>Critical</td></tr></tbody></table>

## 알려진  문제

### Costura.Fody 사용 시 System.ArgumentException

[issue 19](https://github.com/CmlLib/CmlLib.Core.Auth.Microsoft/issues/19)

WebView2 와 Costura.Fody 를 함께 사용하면 문제가 발생합니다.&#x20;

### 나이 관련 오류 (미성년자, 나이 인증, 부모 자녀인증 등등)

1. Xbox 로그인 방식이 Full 혹은 Sisu  으로 설정되어 있는지 확인해 보세요. [xboxauth.md](xboxauthnet.game/xboxauth.md "mention")
2. 로그인하려는 계정이 마인크래프트를 구매한 계정이 맞는지 확인해 보세요. 이 오류를 겪는 대부분의 유저들이 마인크래프트를 구매하지 않은 계정으로 로그인을 시도했었습니다.
3. Mojang 런처를 켜고 로그아웃을 한 뒤 Mojang 런처에서 다시 로그인을 해보세요. 나이 관련 작업이 필요할 경우 Mojang 런처에서 방법을 알려줍니다.&#x20;
4. [Xbox 사이트](https://www.xbox.com)에서 로그아웃을 한 뒤 다시 로그인을 해보세요. 나이 관련 작업이 필요할 경우 로그인 직후 관련 페이지가 표시될 것입니다.

대한민국 기준 마인크래프트에 로그인하려면 나이인증이 정상적으로 완료된 계정이 필요합니다. 보통 나이인증은 Mojang 런처에서 자동으로 진행하기 때문에, **Mojang 런처에서 로그인 가능한 계정은 이 오류가 발생하지 않습니다.**&#x20;

미성년자도 Mojang 런처에서 나이 인증과 가족 계정 등록 과정을 모두 진행하면 로그인이 가능합니다. 하지만 보호자가 게임 플레이를 차단한 경우, 혹은 가족에서 계정을 삭제한 경우 다시 오류가 발생할 수 있습니다. Mojang 런처에서 로그인을 다시 해보면 필요한 조치를 알려줍니다.&#x20;
