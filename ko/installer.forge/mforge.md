# MForge

`MForge` 는 포지 인스톨러의 래퍼입니다.

```csharp
var forge = new MForge(launcher);

// 이벤트 헨들러 추가
forge.FileChanged += fileChanged;
forge.ProgressChanged += progressChanged;
forge.InstallerOutput += (s, e) => Console.WriteLine(e);

// 1.20.1 의 최적의 포지 버전 설치
await forge.Install("1.20.1");

// 특정 포지 버전 설치
await forge.Install("1.20.1", "47.1.0");

// 포지 설치 확인 없이 무조건 설치 진행
await forge.Install("1.20.1", forceUpdate: true);
await forge.Install("1.20.1", "47.1.0", forceUpdate: true);
```

## 이벤트 헨들러

`FileChanged` 와 `ProgressChanged` 는 [Handling-Events.md](../cmllib.core/getting-started/Handling-Events.md "mention") 여기서 확인하세요.

`InstallerOutput` 이벤트와 함께 포지 인스톨러의 로그를 확인할 수 있습니다.

## 설치 메서드

### Install(string mcVersion, bool forceUpdate = false)

인수로 들어온 `mcVersion` 에서 최적의 포지 버전을 설치합니다. 최적의 포지 버전은 다음과 같은 규칙에 의해 결정됩니다:

1. Recommended 표시된 버전
2. Latest 표시된 버전
3. 첫번째 버전

### Install(string mcVersion, string forgeVersion, bool forceUpdate = false)

특정한 포지 버전을 설치합니다. 

### forceUpdate: true

인스톨러는 포지 버전이 설치되었는지 먼저 확인하고 이미 설치된 경우라면 설치를 건너뜁니다. 하지만 `forceUpdate: true` 옵션과 함께라면 인스톨러는 설치를 건너뛰지 않고 항상 설치를 진행합니다.

## 광고

`MForge` 는 설치가 성공한 후에 광고 페이지를 표시합니다. 공식 포지 설치기에 아래 메세지가 포함되어 있습니다:

```
Please do not automate the download and installation of Forge.
Our efforts are supported by ads from the download page.
If you MUST automate this, please consider supporting the project through https://www.patreon.com/LexManos
```

만약 광고 표시를 원하지 않는다면, [MForge 소스코드](https://github.com/CmlLib/CmlLib.Core.Installer.Forge/blob/main/CmlLib.Core.Installer.Forge/MForge.cs)를 직접 수정하세요.&#x20;
