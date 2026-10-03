# Часті запитання (FAQ)

## Отримання виводу гри (логів)

Ви можете читати стандартний вивід (standard output) процесу гри.  
Оскільки метод `CreateProcess` повертає екземпляр `Process`, ви можете використовувати всі API класу `Process`. ([довідка](https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.process?view=net-6.0))

```csharp
process.StartInfo.CreateNoWindow = false;
process.StartInfo.UseShellExecute = false;
process.StartInfo.RedirectStandardError = true;
process.StartInfo.RedirectStandardOutput = true;
process.EnableRaisingEvents = true;
process.ErrorDataReceived += (s, e) => Console.WriteLine(e.Data);
process.OutputDataReceived += (s, e) => Console.WriteLine(e.Data);

process.Start();
process.BeginErrorReadLine();
process.BeginOutputReadLine();
```

Наведений вище код виводить увесь вивід гри у консоль. Ви можете перевіряти логи гри у консолі.

## Запуск кастомного клієнта гри

Вам знадобляться два файли: `<назва_версії>.jar`, `<назва_версії>.json`.  
Помістіть ці файли у директорію `<директорія_гри>/versions/<назва_версії>`.

Приклад)

```
<директорія_гри>
 | - versions
 |    | - myversion
 |    |    | - myversion.jar
 |    |    | - myversion.json
```

Переконайтеся, що назва директорії версії, назва jar-файлу, назва json-файлу та властивість `id` у json-файлі версії збігаються між собою.

Якщо ви копіюєте json-файл версії з ванільної версії, вам слід видалити властивість `downloads` із json-файлу версії, щоб лаунчер не перезаписав ваш кастомний jar-файл ванільним.

(Приклад для 1.12.2.json)

```
1.12.2.json <-> 1.12.2-modified.json

 | {
 |     "assetIndex": {
 |         "id": "1.12",
 |         "sha1": "1584b57c1a0b5e593fad1f5b8f78536ca640547b",
 |         "size": 143138,
 |         "totalSize": 129336389,
 |         "url": "https://launchermeta.mojang.com/v1/packages/1584b57c1a0b5e593fad1f5b8f78536ca640547b/1.12.json"
 |     },
 |     "assets": "1.12",
 |     "complianceLevel": 0,
-|      "downloads": {            <===== ВИДАЛІТЬ цю властивість
-|          "client": {
-|              "sha1": "0f275bc1547d01fa5f56ba34bdc87d981ee12daf",
-|              "size": 10180113,
-|              "url": "https://launcher.mojang.com/v1/objects/0f275bc1547d01fa5f56ba34bdc87d981ee12daf/client.jar"
-|          },
-|          "server": {
-|              "sha1": "886945bfb2b978778c3a0288fd7fab09d315b25f",
-|              "size": 30222121,
-|              "url": "https://launcher.mojang.com/v1/objects/886945bfb2b978778c3a0288fd7fab09d315b25f/server.jar"
-|          }
-|     },
*|      "id": "1.12.2-modified", <== переконайтеся, що id такий самий, як і назва версії
 |     "javaVersion": {
 |         "component": "jre-legacy",
 |         "majorVersion": 8
 |     },

```

Будь-яка версія, яку може запустити лаунчер Mojang, також може бути запущена через CmlLib.Core. Перед використанням CmlLib.Core переконайтеся, що ваша кастомна версія працює в лаунчері Mojang. CmlLib.Core не зможе запустити вашу версію, якщо її не вдається запустити через лаунчер Mojang.

## [Вразливість log4j2 (CVE-2021-44228)](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44228)

Minecraft, запущений через `CmlLib 0.0.1` ~ `CmlLib.Core 3.3.3`, може містити вразливість log4j2. Починаючи з версії `CmlLib.Core 3.3.4`, цього немає.
