---
description: CmlLib.Core 의 메인 클래스
---

# 런처

### 기본 사용법

{% hint style="info" %}
.NET Framework 에서는 빠른 다운로드 속도를 위해 다음 코드를 추가하세요. .NET Core 에서는 필요하지 않습니다.

```csharp
System.Net.ServicePointManager.DefaultConnectionLimit = 256;
```
{% endhint %}

```csharp
using CmlLib.Core;
using CmlLib.Core.Auth;
using CmlLib.Core.ProcessBuilder;
using CmlLib.Core.VersionMetadata;

// 런처 초기화
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);

// 이벤트 헨들러 추가
launcher.FileProgressChanged += (sender, args) =>
{
    Console.WriteLine($"Name: {args.Name}");
    Console.WriteLine($"Type: {args.EventType}");
    Console.WriteLine($"Total: {args.TotalTasks}");
    Console.WriteLine($"Progressed: {args.ProgressedTasks}");
};
launcher.ByteProgressChanged += (sender, args) =>
{
    Console.WriteLine($"{args.ProgressedBytes} bytes / {args.TotalBytes} bytes");
};

// 모든 버전 가져오기
var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine(v.GetVersionType());
    Console.WriteLine(v.Name);
}

// 게임 설치 및 프로세스 생성
await launcher.InstallAsync("1.20.6");
var process = await launcher.BuildProcessAsync("1.20.6", new MLaunchOption
{
    Session = MSession.CreateOfflineSession("Gamer123"),
    MaximumRamMb = 4096
});
Console.WriteLine(process.StartInfo.Arguments);

// 게임 실행
var processWrapper = new ProcessWrapper(process);
processWrapper.OutputReceived += (s, e) => Console.WriteLine(e);
processWrapper.StartWithEvents();

var exitCode = await processWrapper.WaitForExitTaskAsync();
Console.WriteLine($"Exited with code {exitCode}");
```

### 코드설명

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);
```

마인크래프트 디렉터리 구조를 만들고 런처를 초기화합니다. 게임 경로와 디렉터리 구조를 바꾸고 싶으면 [MinecraftPath.md](MinecraftPath.md "mention"), [minecraftlauncherparameters.md](../more-apis/minecraftlauncherparameters.md "mention") 을 참고하세요.

```csharp
launcher.FileProgressChanged += (sender, args) =>
{
    Console.WriteLine($"Name: {args.Name}");
    Console.WriteLine($"Type: {args.EventType}");
    Console.WriteLine($"Total: {args.TotalTasks}");
    Console.WriteLine($"Progressed: {args.ProgressedTasks}");
};
launcher.ByteProgressChanged += (sender, args) =>
{
    Console.WriteLine($"{args.ProgressedBytes} bytes / {args.TotalBytes} bytes");
};
```

이벤트 헨들러를 추가하여 파일 설치 진행률을 콘솔에 출력합니다. 자세한 내용은 [Handling-Events.md](Handling-Events.md "mention") 를 참고하세요.

```csharp
var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine(v.Name);
}
```

모든 버전을 불러오고 버전 이름을 출력합니다. [undefined.md](undefined.md "mention") 참고

```csharp
await launcher.InstallAsync("1.20.4");
var process = await launcher.BuildProcessAsync("1.20.4", new MLaunchOption
{
    Session = MSession.CreateOfflineSession("Gamer123"),
    MaximumRamMb = 4096
});
process.Start();
```

실행 옵션을 설정하고, 게임 파일을 검사하고, 게임 파일을 다운로드하고, 게임을 실행해 게임의 `Process` 인스턴스를 반환합니다. [MLaunchOption.md](MLaunchOption.md "mention") 에서 더 많은 실행 옵션을 확인하세요.

{% hint style="info" %}
실행하기 전 설치 여부와 상관 없이 항상 InstallAsync 메서드를 호출하는 것을 권장합니다. InstallAsync 메서드는 설치된 파일을 모두 검사하고 손상되었거나 존재하지 않는 파일만 다운로드합니다.
{% endhint %}

```csharp
var processWrapper = new ProcessWrapper(process);
processWrapper.OutputReceived += (s, e) => Console.WriteLine(e);
processWrapper.StartWithEvents();

var exitCode = await processWrapper.WaitForExitTaskAsync();
Console.WriteLine($"Exited with code {exitCode}");
```

게임 프로세스를 실행하고 게임 로그를 콘솔에출력합니다. 게임이 종료될 까지 대기하고 종료 코드를 출력합니다. [processwrapper.md](../utilites/processwrapper.md "mention") 참고

{% hint style="info" %}
`process` 변수는 .NET 표준 [Process](https://learn.microsoft.com/en-us/dotnet/api/system.diagnostics.process) 객체입니다. `ProcessWrapper` 를 사용하지 않고 `process.Start();` 으로 즉시 실행해도 됩니다.
{% endhint %}

## 모든 메서드

버전 실행에 필요한 모든 파일 목록 가져오기

```csharp
// 버전 이름으로
IEnumerable<GameFile> files = await launcher.ExtractFiles("1.20.4", CancellationToken.None);
```

```csharp
// IVersion 으로
IVersion version = await launcher.GetVersionAsync("1.20.4", CancellationToken.None);
IEnumerable<GameFile> files = await launcher.ExtractFiles(version, CancellationToken.None);
```

파일 검사하고 다운로드가 필요한 파일이 있으면 다운로드

```csharp
// 설치 진행률을 launcher.FileProgressChanged, launcher.ByteProgressChanged 으로 보고
await launcher.InstallAsync(version, CancellationToken.None); // IVersion 으로 설치

// 설치 진행률을 fileProgress, byteProgress 으로 보고
await launcher.InstallAsync(version, fileProgress, byteProgress, CancellationToken.None); // IVersion 으로 설치
```

게임 프로세스 만들기

```csharp
// 버전 이름으로
Process process = await launcher.BuildProcessAsync("1.20.4", new MLaunchOption(), CancellationToken.None);
```

```csharp
// IVersion 으로 
IVersion version = await launcher.GetVersionAsync("1.20.4", CancellationToken.None);
Process process = launcher.BuildProcess(version, new MLaunchOption());
```

버전 실행에 필요한 자바 경로 가져오기

```csharp
IVersion version = await launcher.GetVersionAsync("1.20.4", CancellationToken.None);
string? javaPath = await launcher.GetJavaPath(version);
```

설치된 첫번째 자바 경로 가져오기

```csharp
string? javaPath = await launcher.GetDefaultJavaPath();
```
