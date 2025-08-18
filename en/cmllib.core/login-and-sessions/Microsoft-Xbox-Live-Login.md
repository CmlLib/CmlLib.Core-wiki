# Microsoft Xbox Account

## [CmlLib.Core.Auth.Microsoft](../../auth.microsoft/cmllib.core.auth.microsoft/README.md)

Microsoft login process is quite complex. Therefore, this functionality is provided as a separate library. Use this library.

[CmlLib.Core.Auth.Microsoft](../../auth.microsoft/cmllib.core.auth.microsoft/README.md)

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
