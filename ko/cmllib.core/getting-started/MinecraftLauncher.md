# 런처 (Launcher)

`MinecraftLauncher` 는 이 라이브러리의 핵심 클래스입니다. 이 클래스는 설치된 버전을 찾고, 게임 파일을 다운로드하고, 게임 프로세스를 실행하는 역할을 합니다.

## 기본 사용법 단계

`MinecraftLauncher` 사용의 일반적인 흐름은 다음과 같습니다.

### 1. 초기화

먼저 게임 디렉터리(예: `%appdata%\.minecraft`)를 나타내는 `MinecraftPath` 객체를 생성합니다. 그 다음 이 경로를 사용하여 `MinecraftLauncher` 를 초기화합니다.

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);
```

필요하다면 디렉터리 구조를 수정할 수 있습니다. [게임 경로 설정](MinecraftPath.md) 과 [MinecraftLauncherParameters](../more-apis/minecraftlauncherparameters.md) 를 참고하세요.

### 2. 버전 목록

바닐라 버전과 설치된 모든 버전 목록을 가져올 수 있습니다.

```csharp
var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine($"Name: {v.Name}, Type: {v.GetVersionType()}");
}
```

더 자세한 내용은 [버전](versions.md) 문서를 참고하세요.

### 3. 설치 및 이벤트 처리

게임을 실행하기 전에 모든 게임 파일(JAR, 라이브러리, 에셋 등)이 다운로드되어 있고 유효한지 확인해야 합니다. `InstallAsync` 메서드가 이 작업을 처리합니다. 이벤트를 등록하여 다운로드 진행 상황을 확인할 수 있습니다.

```csharp
// 이벤트 핸들러
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

// 설치
await launcher.InstallAsync("1.20.4");
```

!!! info "설치 권장사항"
    실행하기 전에 **항상** `InstallAsync` 를 호출하는 것을 권장합니다. 이 메서드는 파일 무결성을 검사하고 누락되거나 손상된 파일만 다운로드하므로 매번 호출해도 괜찮습니다.

자세한 내용은 [이벤트 처리](Handling-Events.md) 를 참고하세요.

### 4. 실행

설치가 완료되면 `BuildProcessAsync` 를 사용하여 게임 프로세스를 생성합니다. 이 메서드는 표준 .NET `Process` 객체를 생성하여 반환합니다.

```csharp
var launchOption = new MLaunchOption
{
    MaximumRamMb = 4096,
    Session = MSession.CreateOfflineSession("Gamer123"),
};

var process = await launcher.BuildProcessAsync("1.20.4", launchOption);
```

자세한 내용은 [실행 옵션](MLaunchOption.md) 을 참고하세요.

### 5. 프로세스 관리

`ProcessWrapper` 헬퍼 클래스를 사용하면 게임 출력과 종료 이벤트를 쉽게 처리할 수 있습니다.

```csharp
var processWrapper = new ProcessWrapper(process);
processWrapper.OutputReceived += (s, e) => Console.WriteLine($"[Game] {e}");
processWrapper.StartWithEvents();
var exitCode = await processWrapper.WaitForExitTaskAsync();
Console.WriteLine($"Exited with code {exitCode}");
```

자세한 내용은 [ProcessWrapper](../utilities/processwrapper.md) 를 참고하세요.

---

## 전체 예제 코드

```csharp
using System;
using CmlLib.Core;
using CmlLib.Core.Auth;
using CmlLib.Core.ProcessBuilder;

// 1. 초기화
var path = new MinecraftPath(); 
var launcher = new MinecraftLauncher(path);

Console.WriteLine($"Initialized launcher at: {path.BasePath}");

// 2. 버전 목록 확인
var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine($"Name: {v.Name}, Type: {v.GetVersionType()}");
}
var selectedVersion = "1.21.6";

// 3. 이벤트 핸들러 등록 및 설치
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

await launcher.InstallAsync(selectedVersion);

// 4. 프로세스 생성
var launchOption = new MLaunchOption
{
    MaximumRamMb = 4096,
    Session = MSession.CreateOfflineSession("DevUser"),
};

var process = await launcher.BuildProcessAsync(selectedVersion, launchOption);

// 5. 실행 및 모니터링
var processWrapper = new ProcessWrapper(process);

// 게임 출력 캡처
processWrapper.OutputReceived += (sender, log) => 
    Console.WriteLine($"[Game] {log}");

processWrapper.StartWithEvents();
var exitCode = await processWrapper.WaitForExitTaskAsync();
Console.WriteLine($"Game exited with code: {exitCode}");
```

!!! tip ".NET Framework 최적화"
    **.NET Framework** 를 사용하는 경우 다운로드 속도를 최대화하기 위해 **애플리케이션 시작 부분**(`MinecraftLauncher` 초기화 전)에 `DefaultConnectionLimit` 을 설정하세요. .NET Core 나 .NET 5+ 에서는 필요하지 않습니다.

    ```csharp
    System.Net.ServicePointManager.DefaultConnectionLimit = 256;
    ```

## 기타 메서드

### 파일 추출

게임을 실행하지 않고 특정 버전에 필요한 파일 목록을 가져옵니다.

```csharp
// 버전 이름으로
IEnumerable<GameFile> files = await launcher.ExtractFiles("1.20.4", cancellationToken);
```

```csharp
// IVersion 객체로
IVersion version = await launcher.GetVersionAsync("1.20.4", cancellationToken);
IEnumerable<GameFile> files = await launcher.ExtractFiles(version, cancellationToken);
```

### 파일 설치

```csharp
// 진행률을 launcher.FileProgressChanged, launcher.ByteProgressChanged 로 보고
await launcher.InstallAsync("1.20.4", cancellationToken); // 버전 이름으로
await launcher.InstallAsync(version, cancellationToken); // IVersion 객체로

// 진행률을 별도의 fileProgress, byteProgress 객체로 보고
await launcher.InstallAsync("1.20.4", fileProgress, byteProgress, cancellationToken); // 버전 이름으로
await launcher.InstallAsync(version, fileProgress, byteProgress, cancellationToken); // IVersion 객체로
```

### 게임 프로세스 생성

```csharp
// 버전 이름으로
Process process = await launcher.BuildProcessAsync("1.20.4", new MLaunchOption(), cancellationToken);
```

```csharp
// IVersion 객체로
IVersion version = await launcher.GetVersionAsync("1.20.4", cancellationToken);
Process process = launcher.BuildProcess(version, new MLaunchOption());
```

### 자바 경로 가져오기

```csharp
IVersion version = await launcher.GetVersionAsync("1.20.4", cancellationToken);
string? javaPath = await launcher.GetJavaPath(version);
```

설치된 첫 번째 자바 경로 가져오기:

```csharp
string? javaPath = await launcher.GetDefaultJavaPath();
```

## API References

- https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.MinecraftLauncher.html
