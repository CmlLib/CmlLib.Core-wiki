---
description: 게임 파일 추출
---

# FileExtractor

`IFileExtractor` 는 주어진 버전에 대해 모든 `GameFile` 을 추출합니다.

라이브러리에서는 기본적으로 5개의 extractor 를 제공합니다:

* AssetFileExtractor: extract asset files (\<game\_directory>/assets/objects)
* ClientFileExtractor: extract version.jar file (\<game\_directory>/versions/\<version>/\<version>.jar)
* JavaFileExtractor: extract java files (\<game\_directory>/runtime)
* LibraryFileExtractor: extract library files (\<game\_directory>/libraries)
* LogFileExtractor: extract log config file (\<game\_directory>/assets/log\_configs)

여기서 추출된 모든 `GameFile` 들은 [Downloader.md](Downloader.md "mention")으로 전달되며 파일이 존재하지 않거나 체크섬이 일치하지 않는 경우 파일이 다운로드됩니다.

만약 런처에서 다른 파일 (예시: 모드 파일) 을 검사하고 다운로드하도록 만들려면 `IFileExtractor` 를 직접 구현하고 [minecraftlauncherparameters.md](minecraftlauncherparameters.md "mention") 에 추가하세요.
