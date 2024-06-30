# Rules

### RulesEvaluator

`IRulesEvaluator` evaluates the given rules to determine if the file or parameter should be used or not.

Some parameters or files are only used in certain OS versions or when certain features are enabled. For example, the lwjgl native library for Windows is only enabled on Windows. As another example, the `--demo` parameter is only used if the `is_demo_user` feature is enabled. Game versions provide a `rules` property to indicate in which environments features should be enabled.

The built-in implementation of `IRulesEvaluator`, `RulesEvaluator` has the same behavior as Mojang Launcher. In most situations, this RulesEvaluator is sufficient. If you want a different behavior, implement your own IRulesEvaluator.

You can set the `IRulesEvaluator` in [minecraftlauncherparameters.md](minecraftlauncherparameters.md "mention").

### RulesEvaluatorContext

`RulesEvaluatorContext` represents the current environment information for evaluating the given rules. This includes the OS type, version, architecture, and list of enabled features currently running.&#x20;

The code below creates a `RulesEvaluatorContext` that represents the current environment.

```csharp
var context = new RulesEvaluatorContext(LauncherOSRule.Current, []);
```

If you want to simulate running in a different environment, you can initialize the `RulesEvaluatorContext` by yourself.&#x20;

```csharp
var context = new RulesEvaluatorContext(new LauncherOSRule("windows", "64", "10.0"), []);
```

You can set the value of `RulesContext` for the launcher.

```csharp
var launcher = new MinecraftLauncher();
launcher.RulesContext = new RulesEvaluatorContext(new LauncherOSRule("windows", "64", "10.0"), []);
```

