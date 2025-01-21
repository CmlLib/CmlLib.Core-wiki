# 홈

[GitHub](https://github.com/CmlLib/CmlLib.Core)

version: 4.0.4

CmlLib.Core 는 **커스텀 마인크래프트 런처** 제작을 위한 .NET 라이브러러리입니다.

## [ad.md](../ad.md "mention")

## 주요 기능

* online-mode 서버에 접속하기 위한 마인크래프트 로그인 (렐름, 하이픽셀)등
* 마이크로소프트 엑스박스 계정으로 로그인
* 바닐라 마인크래프트 다운로드, 설치
* 자바 런타임 자동 설치
* 모드 로더 설치 (Fabric, Fabric, Quilt, LiteLoader)
* 모든 게임 버전 실행 (1.21.4 버전까지 테스트)
* 커스텀 게임 버전 실행 (ex: Forge, Fabric, LiteLoader, 등등 수정된 클라이언트)
* 다양한 실행 옵션 (서버 바로 접속, 화면 크기설정)
* 크로스플랫폼(Windows, Linux, macOS)
* 모장 API (스킨, 유저이름 변경 등)
* 실행 과정 커스터마이징

## [getting-started](getting-started/ "mention")

## 모든 기능

<details>

<summary>Index</summary>

[CMLauncher.md](getting-started/CMLauncher.md "mention")

* 기본적인 사용방법
* **이 문서를 먼저 읽어 보세요!**

[Sample-Code.md](resources/Sample-Code.md "mention")

* CmlLibCoreSample: 간단한 콘솔 프로그램
* CmlLibWinFormSample: 모든 기능

[Common-Errors.md](resources/Common-Errors.md "mention")

* Java runtime errors
* macOS / Linux errors

[MinecraftPath.md](getting-started/MinecraftPath.md "mention")

* 기본 경로 가져오기
* 새로운 마인크래프트 디렉터리 만들기
* 마인크래프트 디렉터리 구조 바꾸기

[login-and-sessions](login-and-sessions/ "mention")

* Get game session from mojang auth server
* Create offline game session

[Microsoft-Xbox-Live-Login.md](login-and-sessions/Microsoft-Xbox-Live-Login.md "mention")

* 마이크로소프트 엑스박스 계정으로 마인크래프트 로그인

[Handling-Events.md](getting-started/Handling-Events.md "mention")

* 런처의 진행 상황 표시 (percentage, file count)
* 진행률 표시

[MLaunchOption.md](getting-started/MLaunchOption.md "mention")

* 최대 메모리 크기 (-Xmx), 최소 메모리 크기 (-Xms)
* 서버 바로 접속
* 창 해상도, 전체화면
* 자바 설정

[**Mojang APIs**](https://github.com/CmlLib/MojangAPI)

* 모든 Mojang API 구현
* 플레이어 프로필 가져오기, 스킨 바꾸기, 게임 소유 확인, 닉네임 바꾸기, UUID 확인 등등
* Mojang authentication
* Microsoft Xbox authentication
* Security question-answer flow

[Downloader.md](more-apis/Downloader.md "mention")

* AsyncParallelDownloader (default)
* SequenceDownloader

[FileChecker.md](more-apis/FileChecker.md "mention")

* AssetChecker, ClientChecker, LibraryChecker
* Skip file hash checking
* Skip specific game file checking
* Use file mirror server (like BMCLAPI mirror service)
* Make custom file checker

[Broken link](broken-reference "mention")

* Get version metadata list from local directory
* Get version metadata list from mojang server
* Get version metadata list from FabricMC server
* Get version metadata information (version name, type, release date, etc)
* Make custom version loader

[Broken link](broken-reference "mention")

* Get version information (version name, type, arguments, library list, asset id, etc)

[Installer](Installer/ "mention")

* Forge 설치
* LiteLoader 설치
* FabricMC 설치

[FAQ.md](resources/FAQ.md "mention")

* 커스텀 클라이언트 실행
* 게임 출력 확인 (logs)
* log4j2

[Get-Minecraft-Changelogs.md](utilites/Get-Minecraft-Changelogs.md "mention")

[Licenses-and-Dependencies.md](resources/Licenses-and-Dependencies.md "mention")

</details>
