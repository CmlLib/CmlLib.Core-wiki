---
description: Видобування файлів гри
---

# FileExtractor

`IFileExtractor` вилучає (витягує) всі `GameFile` із вказаної версії.  

Бібліотека надає п'ять вбудованих екстракторів:

* AssetFileExtractor: вилучає файли асетів (`<game_directory>/assets/objects`)
* ClientFileExtractor: вилучає файл version.jar (`<game_directory>/versions/<version>/<version>.jar`)
* JavaFileExtractor: вилучає файли Java (`<game_directory>/runtime`)
* LibraryFileExtractor: вилучає файли бібліотек (`<game_directory>/libraries`)
* LogFileExtractor: вилучає конфігураційний файл логів (`<game_directory>/assets/log_configs`)

Будь-який згенерований тут `GameFile` передається до [GameInstaller](Downloader.md), який завантажує файл, якщо той відсутній або його контрольна сума (checksum) не збігається.

Реалізуйте інтерфейс `IFileExtractor` та додайте його до лаунчера, якщо ви хочете, щоб лаунчер перевіряв і завантажував додаткові файли (наприклад, файли модів). Дивіться [MinecraftLauncherParameters](minecraftlauncherparameters.md).
