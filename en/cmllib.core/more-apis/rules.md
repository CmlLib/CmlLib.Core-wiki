# Rules

{% hint style="warning" %}
**This document is outdated!** The latest documentation has moved to [here](https://cmllib.github.io/CmlLib.Core-wiki/en/).
{% endhint %}

## RulesEvaluator

The `IRulesEvaluator` interface evaluates the given rules to determine whether a file or parameter should be used. Some parameters or files are only applicable in specific OS versions or when certain features are enabled.

### Examples

* **OS-specific files**: `lwjgl-windows` is only enabled on Windows.
* **Feature-specific parameters**: The `--demo` parameter is only used if the `is_demo_user` feature is enabled.

Game versions provide a `rules` property to specify in which environments particular features should be enabled.

### Built-in Implementation

The built-in implementation of `IRulesEvaluator`, named `RulesEvaluator`, behaves identically to the Mojang Launcher’s implementation. In most cases, this implementation is sufficient.

If you need custom behavior, you can implement your own `IRulesEvaluator`. You can set your `IRulesEvaluator` in [minecraftlauncherparameters.md](minecraftlauncherparameters.md "mention").

## RulesEvaluatorContext

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

