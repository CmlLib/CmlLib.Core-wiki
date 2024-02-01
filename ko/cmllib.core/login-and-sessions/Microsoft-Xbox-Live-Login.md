# 마이크로소프트 엑스박스 계정

## [Auth.Microsoft](../../auth.microsoft/cmllib.core.auth.microsoft/ "mention")

마이크로소프트 로그인 과정은 꽤나 복잡합니다. 런처에 마이크로소프트 로그인 기능을 넣으려면 아래 라이브러리를 이용하는 것을 강력 추천드립니다.

[Auth.Microsoft](../../auth.microsoft/cmllib.core.auth.microsoft/ "mention")

### **Example**

```csharp
using CmlLib.Core;
using CmlLib.Core.Auth.Microsoft;

var loginHandler = JELoginHandlerBuilder.BuildDefault();
var session = await loginHandler.Authenticate();

var launcher = new CMLauncher();
var process = await launcher.CreateProcessAsync("1.16.5", new MLaunchOption()
{
    Session = session
});
process.Start();
```
