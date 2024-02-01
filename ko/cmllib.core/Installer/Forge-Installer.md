---
description: Install Forge mod loader
---

# Forge Installer

## [Installer.Forge](../../installer.forge/ "mention")

포지 인스톨러 라이브러리를 사용할 수 있습니다.

## 라이브러리 없이 포지 설치

1. 포지 파일 추출
2. 추출한 포지 파일을 개인 서버에 올리거나 런처와 함께 배포
3. 추출한 포지 파일을 게임 폴더 안으로 복사하는 코드를 작성

## 포지 파일 추출 방법

1. `.minecraft` 폴더 삭제
2. 모장 런처를 통해서 추출하고 싶은 포지 버전의 바닐라 버전을 실행 (CmlLib 같은 제삼자 런처 사용하면 안됨)
3. 공식 포지 인스톨러를 통해서 `.minecraft` 폴더에 포지를 설치
4. `.minecraft` 폴더에서 `libraries` 폴더와 `versions/<forge-version-name>` 폴더를 복사하세요. 두 폴더가 추출된 포지입니다.

예시 폴더 구조:

```
<root>
 |- libraries
 |  |- org
 |  |- net
 |  |- (여러 폴더들)
 |
 |- versions
    |- <포지-버전-이름>
        |- <포지-버전-이름>.json
        |- <포지-버전-이름>.jar
```

_NOTE: 몇몇 포지 버전은 \<forge-version-name>.jar 파일이 없습니다. 없어도 문제 없습니다_

## 포지

포지를 설치한 후, 포지 버전은 `launcher.GetAllVersions()` 이나 `await launcher.GetAllVersionsAsync()` 를 통해서 불러올 수 있습니다. [CMLauncher.md](../getting-started/CMLauncher.md "mention")

불러온 게임 버전의 이름을 통해서 포지를 실행하세요.

```csharp
var process = await launcher.CreateProcessAsync("forge-version-name", options);
process.Start();
```

Example `1.12.2-forge-14.23.5.2855`:

```csharp
var process = await launcher.CreateProcessAsync("1.12.2-forge-14.23.5.2855", new MLaunchOption
{
    Session = MSession.GetOfflineSession("hello"),
    MaximumRamMb = 4096
});
process.Start();
```
