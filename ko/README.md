# 홈

[GitHub](https://github.com/CmlLib/CmlLib.Core)

version: 3.3.6

CmlLib.Core 는 **커스텀 마인크래프트 런처** 제작을 위한 .NET 라이브러러리입니다. &#x20;

## 주요 기능

* online-mode 서버에 접속하기 위한 마인크래프트 로그인 (예시: 하이픽셀)
* 마이크로소프트엑스박스 계정으로 로그인
* 바닐라 마인크래프트 다운로드, 설치
* 필요한 자바 런타임 자동 설치
* 모드 로더 설치 (Fabric, LiteLoader)
* 모든 게임 버전 실행 (1.19 버전까지  테스트)
* 커스텀 게임 버전 실행 (ex: Forge, Fabric, LiteLoader, 등등 수정된 클라이언트)
* 다양한 실행 옵션 (서버 바로 접속, 화면 크기설정)
* 크로스플랫폼(Windows, Linux, macOS)
* 모장 API (스킨, 유저이름 변경 등)
* 실행 과정 커스터마이징

## 모든 기능

<details>

<summary>Index</summary>

#### [CMLauncher.md](cmllib.core/undefined-1/CMLauncher.md "mention")

* 기본적인 사용방법
* **이 문서를 먼저 읽어 보세요!**

#### [Sample-Code.md](cmllib.core/undefined-5/Sample-Code.md "mention")

* CmlLibCoreSample: 간단한 콘솔 프로그램
* CmlLibWinFormSample: 모든 기능

#### [Common-Errors.md](cmllib.core/undefined-5/Common-Errors.md "mention")

* Java runtime errors
* macOS / Linux errors

#### [MinecraftPath.md](cmllib.core/undefined-1/MinecraftPath.md "mention")

* 기본 경로 가져오기
* 새로운 마인크래프트 디렉터리 만들기
* 마인크래프트 디렉터리 구조 바꾸기

#### [Login-and-Sessions.md](cmllib.core/undefined-2/Login-and-Sessions.md "mention")

* Get game session from mojang auth server
* Create offline game session

#### [Microsoft-Xbox-Live-Login.md](cmllib.core/undefined-2/Microsoft-Xbox-Live-Login.md "mention")

* 마이크로소프트 엑스박스 계정으로 마인크래프트 로그인

#### [Handling-Events.md](cmllib.core/undefined-1/Handling-Events.md "mention")

* 런처의 진행 상황 표시 (percentage, file count)
* 진행률 표시

#### [MLaunchOption.md](cmllib.core/undefined-1/MLaunchOption.md "mention")

* 최대 메모리 크기 (-Xmx), 최소 메모리 크기 (-Xms)&#x20;
* 서버 바로 접속&#x20;
* 창 해상도, 전체화면&#x20;
* 자바 설정

#### [Mojang APIs](https://github.com/CmlLib/MojangAPI)

* 모든 Mojang API 구현
* 플레이어 프로필 가져오기, 스킨 바꾸기, 게임 소유 확인, 닉네임 바꾸기, UUID 확인 등등
* Mojang authentication
* Microsoft Xbox authentication
* Security question-answer flow

#### [Downloader.md](cmllib.core/undefined-3/Downloader.md "mention")

* AsyncParallelDownloader (default)
* SequenceDownloader

#### [FileChecker.md](cmllib.core/undefined-3/FileChecker.md "mention")

* AssetChecker, ClientChecker, LibraryChecker
* Skip file hash checking
* Skip specific game file checking
* Use file mirror server (like BMCLAPI mirror service)
* Make custom file checker

#### [VersionLoader.md](cmllib.core/undefined-3/VersionLoader.md "mention")

* Get version metadata list from local directory
* Get version metadata list from mojang server
* Get version metadata list from FabricMC server
* Get version metadata information (version name, type, release date, etc)
* Make custom version loader

#### [Version.md](cmllib.core/undefined-3/Version.md "mention")

* Get version information (version name, type, arguments, library list, asset id, etc)

#### [Installer](cmllib.core/Installer/ "mention")

* Forge 설치
* LiteLoader 설치
* FabricMC 설치

#### [FAQ.md](cmllib.core/undefined-5/FAQ.md "mention")

* 커스텀 클라이언트 실행
* 게임 출력 확인 (logs)
* log4j2

[Get-Minecraft-Changelogs.md](cmllib.core/undefined-4/Get-Minecraft-Changelogs.md "mention")

[Licenses-and-Dependencies.md](cmllib.core/undefined-5/Licenses-and-Dependencies.md "mention")

</details>
