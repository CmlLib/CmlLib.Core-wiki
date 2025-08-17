# Java

### IJavaPathResolver <a href="#ijavapathresolver" id="ijavapathresolver"></a>

`IJavaPathResolver` 는 설치된 자바 버전의 목록을 반환하고 주어진 자바 버전의 바이너리 파일의 경로를 반환하는 역할을 합니다.

기본 `IJavaPathResolver` 구현체인 `MinecraftJavaPathResolver` 는 `MinecraftPath.Runtime` 디렉토리 내의 자바 버전들을 관리합니다.

기본 구현체인 `MinecraftJavaPathResolver` 가 아닌 다른 구현체를 사용하려면, [MinecraftLauncherParameters](minecraftlauncherparameters.md)의 [JavaPathResolver](minecraftlauncherparameters.md#javapathresolver)를 설정하세요.

### JavaFileExtractor <a href="#javafileextractor" id="javafileextractor"></a>

라이브러리에서 자동으로 모장에서 제공해주는 자바를 설치해주기 때문에 유저의 PC 에 미리 자바를 설치해 둘 필요는 없습니다. [FileExtractor](FileChecker.md) 참고

!!! info
    `JavaFileExtractor` 는 모든 플랫폼을 지원하지 않습니다. 지원되지 않는 플랫폼에서는 자바 바이너리 파일의 경로를 직접 지정해야 합니다. [실행 옵션 설정](../getting-started/MLaunchOption.md)의 `JavaPath` 를 확인하세요.

    지원하는 플랫폼:

    * windows-x64
    * windows-x86
    * windows-arm64
    * linux (x64)
    * linux-i386 (x86)
    * mac-os (x64)
    * mac-os-arm64
