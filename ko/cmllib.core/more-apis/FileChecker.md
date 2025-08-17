---
description: 게임 파일 추출
---

# FileExtractor

`IFileExtractor` 는 주어진 버전에 대해 모든 `GameFile` 을 추출합니다.

라이브러리에서는 기본적으로 5개의 extractor 를 제공합니다:

* AssetFileExtractor: extract asset files (`<game_directory>/assets/objects`)
* ClientFileExtractor: extract version.jar file (`<game_directory>/versions/<version>/<version>.jar`)
* JavaFileExtractor: extract java files (`<game_directory>/runtime`)
* LibraryFileExtractor: extract library files (`<game_directory>/libraries`)
* LogFileExtractor: extract log config file (`<game_directory>/assets/log_configs`)

여기서 추출된 모든 `GameFile` 들은 [GameInstaller](Downloader.md)으로 전달되며 파일을 설치합니다.

만약 런처에서 더 많은 파일 (예시: 모드 파일) 을 검사하고 다운로드하도록 만들려면 `IFileExtractor` 를 직접 구현하고 [MinecraftLauncherParameters](minecraftlauncherparameters.md)의 [FileExtractors](minecraftlauncherparameters.md#fileextractors)에 추가하세요.
