# FAQ

## Get game outputs (logs)

You can read standard output of game process so that you can easily check process status and read game logs.  
As `CreateProcess` method returns `Process` instance, you can use all APIs of `Process`. ([reference](https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.process?view=net-6.0))

```csharp
process.StartInfo.RedirectStandardError = true;
process.StartInfo.RedirectStandardOutput = true;
process.EnableRaisingEvents = true;
process.ErrorDataReceived += (s, e) => Console.WriteLine(e.Data);
process.OutputDataReceived += (s, e) => Console.WriteLine(e.Data);

process.Start();
process.BeginErrorReadLine();
process.BeginOutputReadLine();
```

Above code write all game outputs to console. You can check game logs in console.

## Launch custom game client

same way applied to mojang launcher.  
(writing)

## [log4j2 vulnerability (CVE-2021-44228)](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44228)

Minecraft launched by `CmlLib 0.0.1` ~ `CmlLib.Core 3.3.3` has log4j2 vulnerability. It is safe after `CmlLib.Core 3.3.4` version.