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
