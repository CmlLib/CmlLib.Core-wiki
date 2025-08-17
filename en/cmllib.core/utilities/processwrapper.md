# ProcessWrapper

To check if the game launched successfully or terminated due to an error, you need to collect logs displayed in the process's standard output and check the exit code.

Implementing this with the .NET `System.Diagnostics.Process` class returned by the CmlLib launcher can make the code complex. The `ProcessWrapper` class is provided to simplify this process.

The core features of `ProcessWrapper` are:

* Standard output reading: Notifies when the process's standard output is available as events.
* Exit code checking: Asynchronously waits for the process to terminate and returns the exit code.

**Usage Example**

```csharp
// 1. Create game process
var process = launcher.BuildProcessAsync("1.20.4", new MLaunchOption());

// 2. Create ProcessWrapper
var processWrapper = new ProcessWrapper(process);

// 3. Set up actions when logs are output
processWrapper.OutputReceived += (sender, log) => 
{
    // (Example) Simply output logs to console as-is
    Console.WriteLine(log);
};

// 4. Start the process
processWrapper.StartWithEvents();

// 5. Wait for the process to terminate and check the exit code
int exitCode = await processWrapper.WaitForExitTaskAsync();
if (exitCode == 0)
{
    Console.WriteLine("Game terminated successfully.");
}
else
{
    Console.WriteLine($"Game error occurred! Exit code: {exitCode}");
}
```
