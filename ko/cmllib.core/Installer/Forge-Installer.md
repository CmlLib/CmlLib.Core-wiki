# 모드 로더 파일 추출

Forge, fabric 뿐만 아니라 어떤 형태의 클라이언트든 모두 파일을 추출하여 설치를 자동화 할 수 있습니다.

!!! danger "저작권 주의사항"
    **추출한 파일에는 저작권으로 보호된 파일이 포함되어 있을 수 있습니다. 이러한 파일을 배포할 경우 Minecraft EULA 위반 혹은 관련 법령을 위반할 수 있습니다. 배포하기 전 반드시 확인하세요.**

## 추출 방법

1. `.minecraft` 디렉토리 삭제
2. Mojang 런처를 통해서 추출하고 싶은 버전의 바닐라 버전을 실행하고 종료 (예시: 1.7.10 forge 를 추출하기 위해서는 먼저 바닐라 1.7.10 버전 실행)
3. 모드 로더를 `.minecraft` 에 설치
4. 설치된 모드 로더를 Mojang 런처로 실행하고 종료
5. `.minecraft` 디렉토리에서 `libraries` 디렉토리와 `versions/<버전 이름>` 디렉토리를 복사하세요. 두 디렉토리가 추출된 파일입니다.

예시: 1.21.4-forge-54.1.0

```
/
├── libraries/
│   ├── org/
│   ├── net/
│   └── ...
└── versions/
    └── 1.21.4-forge-54.1.0/
        └── 1.21.4-forge-54.1.0.json
```

!!! danger "JAR 파일 주의사항"
    만약 versions/<버전 이름>/<버전 이름>.jar 파일이 존재하는 경우, **배포하기 전 반드시 확인하세요!**

    * 대부분의 경우 해당 파일이 없어도 CmlLib 는 해당 파일을 Mojang 공식 배포 서버로부터 설치합니다.
    * 배포가 필요하다면, **Minecraft EULA 혹은 저작권 법률을 위반하지 않았는지 확인하세요.**

## 배포 및 설치

추출한 파일을 런처와 함께 배포하세요. 배포는 여러가지 방법이 있습니다. 예시:

* 추출된 파일을 본인이 운영하는 파일 서버에 업로드
* EmbeddedResource 로 추출된 파일을 런처 실행파일에 임베딩

배포된 파일을 복사하거나 다운로드하여 게임 디렉토리에 파일이 설치되도록 구현하세요.

## 실행

버전을 불러오면 설치된 버전의 이름이 표시됩니다. 해당 버전의 이름을 통해 게임을 실행하세요. [런처](../getting-started/CMLauncher.md) 참고

```csharp
var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine(v.Name);
}

// 예시: 설치된 버전이 1.21.4-forge-54.1.0 일 때,

await launcher.InstallAsync("1.21.4-forge-54.1.0");
var process = await launcher.BuildProcessAsync("1.21.4-forge-54.1.0", new MLaunchOption
{
    Session = MSession.CreateOfflineSession("Gamer123"),
    MaximumRamMb = 4096
});
process.Start();
```

추출된 파일은 대부분 완전한 상태가 아니기에, 누락된 파일이 모두 설치되도록 반드시 `InstallAsync` 를 호출하세요.
