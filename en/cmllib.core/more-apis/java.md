# Java

### IJavaPathResolver

`IJavaPathResolver` returns a list of installed Java versions and returns the path to the binary file for the given Java version.

The built-in `IJavaPathResolver` implementation, `MinecraftJavaPathResolver`, manages the Java versions within the `MinecraftPath.Runtime` directory.

You can set the `IJavaPathResolver` in [MinecraftLauncherParameters](minecraftlauncherparameters.md)

### JavaFileExtractor

The library installs the Java provided by Mojang, so you don't need to have Java pre-installed on the user's PC. See `JavaFileExtractor` in [FileExtractor](FileChecker.md).

!!! info "Platform Support"
    `JavaFileExtractor` does not support all platforms. On unsupported platform you should specify Java binary path yourself. See `JavaPath` in [Launch Options](../getting-started/MLaunchOption.md).

    Supported platform:

    * windows-x64
    * windows-x86
    * windows-arm64
    * linux (x64)
    * linux-i386 (x86)
    * mac-os (x64)
    * mac-os-arm64

