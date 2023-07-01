---
description: Install Forge mod loader
---

# Forge Installer

## Note

**이 라이브러리에서 포지 설치 기능은 작동하지 않습니다.** `MForge` 는 업데이트되지 않은 지 오래 되었으며, 누군가가 pull request 를 넣어주지 않는 이상 이 기능을 더 이상 업데이트 할 계획도 없습니다.\
포지 설치 자동화는 복잡하며 유지보수 하는데 많은 노력이 필요합니다. 그리고 포지 개발 팀에서 자동화 프로그램을 만들지 말라고 부탁하고 있습니다.

포지 인스톨러 안 메세지:

```
Please do not automate the download and installation of Forge.
Our efforts are supported by ads from the download page.
If you MUST automate this, please consider supporting the project through https://www.patreon.com/LexManos
```

```
포지 다운로드와 설치를 자동화하지 마세요.
우리의 노력은 다운로드 페이지의 광고를 통해 지속됩니다. 
만약 자동화가 꼭 필요하다면, 프로젝트에 후원을 부탁드립니다. https://www.patreon.com/LexManos
```

## 포지 설치

가장 추천하는 방법은 포지 공식 사이트에서 인스톨러를 다운받아 직접 설치하는 것입니다.

만약 런처에 포지 설치 기능을 넣고 싶다면:

1. 포지 파일 추출
2. 추출한 포지 파일을 개인 서버에 올리거나 런처와 함께 배포
3. 추출한 포지 파일을 게임 폴더 안으로 복사하는 코드를 작성

혹은, 포지 설치 자동화 도구를 직접 만드세요. CmlLib.Core 는 포지 설치 코드를 제공하지 않습니다.

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
var process = await launcher.CreateProcess("forge-version-name", options);
process.Start();
```

Example `1.12.2-forge-14.23.5.2855`:

```csharp
var process = await launcher.CreateProcess("1.12.2-forge-14.23.5.2855", new MLaunchOption
{
    Session = MSession.GetOfflineSession("hello"),
    MaximumRamMb = 4096
});
process.Start();
```
