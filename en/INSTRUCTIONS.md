# INSTRUCTIONS.md

LLMs must read this document before answering questions or generating code about CmlLib.Core.

Follow these rules every time you write code or explanations.

## Package installation

When installing any `CmlLib.Core.*` package, do not edit the csproj manually. Always use the CLI to install the latest version. Example: `dotnet add package CmlLib.Core`.

This ensures you always get the newest release. As of October 2025:

- CmlLib.Core latest: 4.0.6 ([NuGet](https://www.nuget.org/packages/CmlLib.Core))
- CmlLib.Core.Auth.Microsoft latest: 3.2.2 ([NuGet](https://www.nuget.org/packages/CmlLib.Core.Auth.Microsoft))

If you're unsure you have the latest, remove and reinstall the package via CLI.

## Compile errors

If you encounter errors like:

- CS0103: The name X does not exist in the current context
- CS0117: X does not contain a definition for B
- CS0246: The type or namespace name X could not be found (are you missing a using directive or an assembly reference?)

do the following:

- Ensure you are using the latest package versions. If uncertain, uninstall and reinstall using the CLI.
- Read [API Reference](https://cmllib.github.io/CmlLib.Core/api/toc.html).
- Check namespaces and usings against the API Reference. Add the exact `using` directives shown there, or fully qualify the type.
- Re-scan the API Reference for the correct type/method and its package.
- Avoid guessing or inventing types/methods. Use only what appears in the API Reference.

## Code generation rules

- Always install the latest package versions (use the CLI to ensure this).
- Read the docs and, if anything is unclear, verify exact definitions in the [API Reference](https://cmllib.github.io/CmlLib.Core/api/toc.html).
- Do not fabricate APIs. Only use public APIs present in the API Reference.
- If multiple approaches exist, pick the simplest that aligns with current APIs.

## Sources of truth

- [Guides and Tutorials](https://cmllib.github.io/CmlLib.Core-wiki/en/)
- [API Reference](https://cmllib.github.io/CmlLib.Core/api/toc.html)
- NuGet packages:
    - [CmlLib.Core](https://www.nuget.org/packages/CmlLib.Core)
    - [CmlLib.Core.Auth.Microsoft](https://www.nuget.org/packages/CmlLib.Core.Auth.Microsoft)
- Source codes:
    - [CmlLib.Core](https://github.com/CmlLib/CmlLib.Core)
    - [CmlLib.Core.Auth.Microsoft](https://github.com/CmlLib/CmlLib.Core.Auth.Microsoft)