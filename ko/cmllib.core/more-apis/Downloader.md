---
description: 게임 파일 설치
---

# GameInstaller

`IGameInstaller` 는 파일의 존재 여부와 무결성 검사를 하고 필요한 경우 파일을 다운로드 받습니다. 설치 중 발생하는 이벤트를 확인하려면 [Handling-Events.md](../getting-started/Handling-Events.md "mention")를 참고하세요.

### 예시

```csharp
var installer = ParallelGameInstaller.CreateAsCoreCount(new HttpClient());
var file = new GameFile("name")
{
    Path = "absolute path of the file",
    Hash = "SHA1 checksum, in hex string",
    Size = 1024, // file size
    Url = "URL to download the file",
};
await installer.Install([file], fileProgress, byteProgress, CancellationToken.None);
```

### BasicGameInstaller

싱글 스레드 인스톨러

```csharp
var installer = new BasicGameInstaller(new HttpClient());
```

### ParallelGameInstaller

멀티 스레드 인스톨러. `CreateAsCoreCount` 메서드는 현재 PC의 CPU 코어 수에 맞추어 새로운 `ParallelGameInstaller` 를 초기화합니다.

```csharp
var installer = ParallelGameInstaller.CreateAsCoreCount(new HttpClient());
```

각 작업에 대해 스레드의 갯수를 직접 지정할 수도 있습니다.

```csharp
var installer = new ParallelGameInstaller(
    maxChecker: 4,
    maxDownloader: 8,
    boundedCapacity: 2048, // 다운로드 큐 크기
    new HttpClient());
```

