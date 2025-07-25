---
description: 설치 진행 과정을 유저에게 보여줍니다.
---

# 이벤트 처리

게임 설치 중에는 두 종류의 이벤트가 발생됩니다.

* `FileProgress` 는 파일의 이름, 종류, 완료된 파일의 갯수를 알려줍니다.
* `ByteProgress` 는 완료된 파일의 크기 / 전체 파일의 크기를 바이트 단위로 알려줍니다.

이벤트 처리기를 등록하는 방법은 두 가지가 있습니다.

* `IProgress<>` 인터페이스의 구현체를 게임 설치 메서드를 호출할 때 넘겨주기
* 이벤트 헨들러 등록하기 (여기서 등록한 이벤트 헨들러는 현재 `SynchronizationContext` 위에서 실행되므로 UI 요소에 접근해도 안전합니다)

만약 `IProgress<>` 를 메서드로 넘겨준 경우, 모든 이벤트 헨들러는 무시됩니다.&#x20;

### 예시 (IProgress 사용)

```csharp
var launcher = new MinecraftLauncher();
await launcher.InstallAsync(
    "1.20.4", 
    new Progress<InstallerProgressChangedEventArgs>(e =>
    {
        Console.WriteLine("Name: " + e.Name);
        Console.WriteLine("EventType: " + e.EventType);
        Console.WriteLine("TotalTasks: " + e.TotalTasks);
        Console.WriteLine("ProgressedTasks: " + e.ProgressedTasks);
    }),
    new Progress<ByteProgress>(e =>
    {
        Console.WriteLine("TotalBytes: " + e.TotalBytes);
        Console.WriteLine("ProgressedBytes: " + e.ProgressedBytes);
        Console.WriteLine("Percentage: " + e.ToRatio() * 100);
    }),
    CancellationToken.None);
```

## 예시 (이벤트 헨들러 사용)

```csharp
var launcher = new MinecraftLauncher();
launcher.FileProgressChanged += (_, e) =>
{
    Console.WriteLine("Name: " + e.Name);
    Console.WriteLine("EventType: " + e.EventType);
    Console.WriteLine("TotalTasks: " + e.TotalTasks);
    Console.WriteLine("ProgressedTasks: " + e.ProgressedTasks);
};
launcher.ByteProgressChanged += (_, e) =>
{
    Console.WriteLine("TotalBytes: " + e.TotalBytes);
    Console.WriteLine("ProgressedBytes: " + e.ProgressedBytes);
    Console.WriteLine("Percentage: " + e.ToRatio() * 100);
};
await launcher.InstallAsync("1.20.4", CancellationToken.None);
```

## 성능 팁

`FileProgress` 는 매우 많이 호출됩니다. (InstallAsync 호출할 때마다 4000번 \~ 8000번) 따라서 이벤트 헨들러에 시간이 많이 걸리는 작업을 넣는다면 프로그램의 성능에 영향을 끼칠 수 있습니다. 반면에 `ByteProgress` 는 1초에 3\~4번만 호출되기에 비교적 성능에 민감하지 않습니다.

이벤트 헨들러를 등록하면 내부적으로 `new Progress<T>(handler)` 으로 변환됩니다. [Progress\<T>](https://learn.microsoft.com/en-us/dotnet/api/system.progress-1?view=net-8.0)는 현재 `SynchronizationContext` 에 따라서 다른 동작을 합니다. 만약 WinForm 이나 WPF 앱이라면 헨들러의 코드는 UI 스레드에서 실행되고, 콘솔 앱이라면 ThreadPool 에서 실행될 것입니다.&#x20;

따라서 콘솔 앱에서 이벤트 헨들러를 사용하면 ThreadPool 을 매우 많이 호출하게 됩니다. 이는 애플리케이션의 성능에 나쁜 영향을 줄 수 있으므로 `FileProgress` 를 사용하지 말거나, ThreadPool 을 사용하지 않는 `IProgress<T>` 를 구현해서 사용하세요. 라이브러리에서는 이벤트를 호출한 스레드에서 바로 헨들러를 실행하는 `SyncProgress<T>` 를 제공합니다.  `SyncProgress<T>` 에서는 UI 에 직접 접근하면 안되며, 최대한 간단한 코드만 포함해야 합니다.&#x20;

```csharp
// 예시
IProgress<InstallerProgressChangedEventArgs> fileProgress = new SyncProgress<InstallerProgressChangedEventArgs>(e => 
{ 
    // event handler
    Console.WriteLine(e.Name);
});
```

