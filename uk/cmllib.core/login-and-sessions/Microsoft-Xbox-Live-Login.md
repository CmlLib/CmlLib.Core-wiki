# Обліковий запис Microsoft Xbox

## [CmlLib.Core.Auth.Microsoft](../../auth.microsoft/cmllib.core.auth.microsoft/README.md)

Процес авторизації Microsoft є досить складним. Тому цей функціонал надається у вигляді окремої бібліотеки. Використовуйте цю бібліотеку.

[CmlLib.Core.Auth.Microsoft](../../auth.microsoft/cmllib.core.auth.microsoft/README.md)

### **Приклад**

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
