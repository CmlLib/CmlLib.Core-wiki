---
description: CmlLib.Core 의 메인 클래스
---

# 런처

### 기본 사용법

```csharp
System.Net.ServicePointManager.DefaultConnectionLimit = 256;

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
    Console.WriteLine(v.Name);
}

// 게임 설치 및 실행
await launcher.InstallAsync("1.20.6");
var process = await launcher.BuildProcessAsync("1.20.6", new MLaunchOption
{
    Session = MSession.CreateOfflineSession("Gamer123"),
    MaximumRamMb = 4096
});
process.Start();
```

### 코드설명

```csharp
System.Net.ServicePointManager.DefaultConnectionLimit = 256;
```

최대 커넥션 갯수 제한을 늘립니다. 다운로드 속도를 최대한 높혀줍니다.

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);
```

마인크래프트 디렉터리 구조를 만들고 런처를 초기화합니다. 여기서 마인크래프트 경로와 디렉터리 구조를 바꿀 수 있습니다. [MinecraftPath.md](MinecraftPath.md "mention"), [minecraftlauncherparameters.md](../more-apis/minecraftlauncherparameters.md "mention") 참고

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

이벤트 헨들러를 추가합니다. 다운로드 진행 상황을 콘솔에 출력합니다. [Handling-Events.md](Handling-Events.md "mention") 참고

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
