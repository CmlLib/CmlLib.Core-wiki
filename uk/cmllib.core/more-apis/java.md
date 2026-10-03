# Java

### IJavaPathResolver

`IJavaPathResolver` повертає список встановлених версій Java та повертає шлях до бінарного файлу для вказаної версії Java.

Вбудована реалізація `IJavaPathResolver` під назвою `MinecraftJavaPathResolver` керує версіями Java у директорії `MinecraftPath.Runtime`.

Встановити `IJavaPathResolver` можна у [MinecraftLauncherParameters](minecraftlauncherparameters.md).

### JavaFileExtractor

Бібліотека встановлює Java, надану Mojang, тому вам не потрібно мати заздалегідь встановлену Java на ПК користувача. Дивіться `JavaFileExtractor` у [FileExtractor](FileChecker.md).

!!! info "Підтримка платформ"
    `JavaFileExtractor` підтримує не всі платформи. На непідтримуваній платформі вам слід вказати шлях до бінарного файлу Java самостійно. Дивіться `JavaPath` у [Параметрах запуску](../getting-started/MLaunchOption.md).

    Підтримувані платформи:

    * windows-x64
    * windows-x86
    * windows-arm64
    * linux (x64)
    * linux-i386 (x86)
    * mac-os (x64)
    * mac-os-arm64
