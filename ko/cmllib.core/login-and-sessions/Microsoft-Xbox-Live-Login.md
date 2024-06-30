# 마이크로소프트 엑스박스 계정

## [CmlLib.Core.Auth.Microsoft](../../auth.microsoft/cmllib.core.auth.microsoft/)

마이크로소프트 로그인 과정은 꽤나 복잡합니다. 런처에 마이크로소프트 로그인 기능을 넣으려면 아래 라이브러리를 이용하는 것을 강력 추천드립니다.

[cmllib.core.auth.microsoft](../../auth.microsoft/cmllib.core.auth.microsoft/ "mention")

### **Example**

```csharp
using CmlLib.Core;
using CmlLib.Core.ProcessBuilder;
using CmlLib.Core.Auth.Microsoft;

var loginHandler = JELoginHandlerBuilder.BuildDefault();
var session = await loginHandler.Authenticate();

var launcher = new MinecraftLauncher();
var process = await launcher.InstallAndBuildProcessAsync("1.20.4", new MLaunchOption
{
    Session = session
});
process.Start();
```
