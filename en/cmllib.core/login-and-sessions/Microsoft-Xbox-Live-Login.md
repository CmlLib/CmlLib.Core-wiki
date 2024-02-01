# Microsoft Xbox Account

## [Broken link](broken-reference "mention")

Microsoft login process is quite complex. I **highly** recommend you to use this library to add Microsoft login feature in your launcher.

[cmllib.core.auth.microsoft](../../auth.microsoft/cmllib.core.auth.microsoft/ "mention")

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
