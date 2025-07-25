# 마이크로소프트 엑스박스 계정

## [CmlLib.Core.Auth.Microsoft](../../auth.microsoft/cmllib.core.auth.microsoft/)

마이크로소프트 로그인 과정은 꽤나 복잡합니다. 따라서 이 기능은 별도의 라이브러리로 제공합니다. 이 라이브러리를 사용하세요.

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
