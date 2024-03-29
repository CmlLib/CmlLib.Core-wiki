---
description: 'Login, logout, and account management in Minecraft: Java Edition'
---

# CmlLib.Core.Auth.Microsoft

## Install

Install nuget package [CmlLib.Core.Auth.Microsoft](https://www.nuget.org/packages/CmlLib.Core.Auth.Microsoft)

## Getting Started

```csharp
using CmlLib.Core.Auth.Microsoft;

var loginHandler = JELoginHandlerBuilder.BuildDefault();
var session = await loginHandler.Authenticate();
```

Set `Session` property of [MLaunchOption.md](../../cmllib.core/getting-started/MLaunchOption.md "mention").

## Example

[CmlLib-Minecraft-Launcher](https://github.com/CmlLib/CmlLib-Minecraft-Launcher): CmlLib.Core and CmlLib.Core.Auth.Microsoft sample launcher.

[WinFormTest](https://github.com/CmlLib/CmlLib.Core.Auth.Microsoft/blob/dev/examples/WinFormTest)

[ConsoleTest](https://github.com/CmlLib/CmlLib.Core.Auth.Microsoft/blob/dev/examples/ConsoleTest/Program.cs)

## Usage

### [jeloginhandler.md](jeloginhandler.md "mention")

Login, logout, and account managements.

### [jeloginhandlerbuilder.md](jeloginhandlerbuilder.md "mention")

Builder for initializing an instance of `JELoginHandler`.

### [accountmanager.md](../xboxauthnet.game/accountmanager.md "mention")

Manage account list.
