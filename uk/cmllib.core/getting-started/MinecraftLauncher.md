# Minecraft Launcher

`MinecraftLauncher` — це основний клас цієї бібліотеки. Він відповідає за пошук встановлених версій, завантаження ігрових файлів та побудову процесу гри. Він виступає головною точкою входу для більшості операцій лаунчера.

## Основні кроки використання

Ось типовий порядок використання `MinecraftLauncher`:

### 1. Ініціалізація

Спочатку створіть об'єкт `MinecraftPath`, який представляє директорію гри (наприклад, `%appdata%\.minecraft`). Потім ініціалізуйте `MinecraftLauncher` із цим шляхом.

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);
```

За потреби ви можете налаштувати структуру директорій. Дивіться [MinecraftPath](MinecraftPath.md) та [MinecraftLauncherParameters](../more-apis/minecraftlauncherparameters.md).

### 2. Версії

Ви можете отримати список усіх встановлених та доступних версій із серверів Mojang.

```csharp
var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine($"Name: {v.Name}, Type: {v.GetVersionType()}");
}
```

Дивіться [Версії](versions.md) для отримання детальнішої інформації.

### 3. Встановлення та обробка подій

Перед запуском ви повинні переконатися, що всі файли гри (JAR, бібліотеки, асети) завантажені та є цілісними. Метод `InstallAsync` відповідає за це. Ви можете підписатися на події для відстеження прогресу завантаження.

```csharp
// Обробники подій
launcher.FileProgressChanged += (sender, args) =>
{
    Console.WriteLine($"Name: {args.Name}");
    Console.WriteLine($"Type: {args.EventType}");
    Console.WriteLine($"Total: {args.TotalTasks}");
    Console.WriteLine($"Progressed: {args.ProgressedTasks}");
};
launcher.ByteProgressChanged += (sender, args) =>
{
    Console.WriteLine($"{args.ProgressedBytes} bytes / {args.TotalBytes} bytes");
};

// Встановлення
await launcher.InstallAsync("1.20.4");
```

!!! info "Рекомендація щодо встановлення"
    Завжди викликайте `InstallAsync` перед запуском. Він перевіряє цілісність файлів і завантажує лише відсутні або пошкоджені файли, тому його ефективно викликати кожного разу.

Дивіться [Обробка подій](Handling-Events.md).

### 4. Запуск

Після встановлення побудуйте процес гри за допомогою `BuildProcessAsync`. Це створить стандартний об'єкт .NET `Process`, налаштований з відповідними аргументами.

```csharp
var launchOption = new MLaunchOption
{
    MaximumRamMb = 4096,
    Session = MSession.CreateOfflineSession("Gamer123"),
};

var process = await launcher.BuildProcessAsync("1.20.4", launchOption);
```

Дивіться [Параметри запуску](MLaunchOption.md).

### 5. Управління процесом

Ви можете використовувати допоміжний клас `ProcessWrapper`, щоб легко обробляти вивід гри та події завершення.

```csharp
var processWrapper = new ProcessWrapper(process);
processWrapper.OutputReceived += (s, e) => Console.WriteLine($"[Game] {e}");
processWrapper.StartWithEvents();
var exitCode = await processWrapper.WaitForExitTaskAsync();
Console.WriteLine($"Exited with code {exitCode}");
```

Дивіться [ProcessWrapper](../utilities/processwrapper.md).

---

## Повний приклад

Ось повний код, що об'єднує всі вищезазначені кроки.

```csharp
using System;
using CmlLib.Core;
using CmlLib.Core.Auth;
using CmlLib.Core.ProcessBuilder;

// 1. Ініціалізація
var path = new MinecraftPath(); 
var launcher = new MinecraftLauncher(path);

Console.WriteLine($"Initialized launcher at: {path.BasePath}");

// 2. Список версій

var versions = await launcher.GetAllVersionsAsync();
foreach (var v in versions)
{
    Console.WriteLine($"Name: {v.Name}, Type: {v.GetVersionType()}");
}
var selectedVersion = "1.21.6";

// 3. Додавання обробників подій та встановлення
launcher.FileProgressChanged += (sender, args) =>
{
    Console.WriteLine($"Name: {args.Name}");
    Console.WriteLine($"Type: {args.EventType}");
    Console.WriteLine($"Total: {args.TotalTasks}");
    Console.WriteLine($"Progressed: {args.ProgressedTasks}");
};
launcher.ByteProgressChanged += (sender, args) =>
{
    Console.WriteLine($"{args.ProgressedBytes} bytes / {args.TotalBytes} bytes");
};

await launcher.InstallAsync(selectedVersion);

// 4. Побудова процесу
var launchOption = new MLaunchOption
{
    MaximumRamMb = 4096,
    Session = MSession.CreateOfflineSession("DevUser"),
};

var process = await launcher.BuildProcessAsync(selectedVersion, launchOption);

// 5. Запуск та моніторинг
var processWrapper = new ProcessWrapper(process);

processWrapper.OutputReceived += (sender, log) => 
    Console.WriteLine($"[Game] {log}");

processWrapper.StartWithEvents();
var exitCode = await processWrapper.WaitForExitTaskAsync();
Console.WriteLine($"Гра завершилася з кодом: {exitCode}");
```

!!! tip "Оптимізація для .NET Framework"
    Якщо ви використовуєте **.NET Framework**, встановіть `DefaultConnectionLimit` на **початку вашого застосунку** (до ініціалізації `MinecraftLauncher`), щоб максимізувати швидкість завантаження. У .NET Core або .NET 5+ у цьому немає потреби.

    ```csharp
    System.Net.ServicePointManager.DefaultConnectionLimit = 256;
    ```

## Додаткові методи

### Витягнення файлів

```csharp
// за назвою версії
IEnumerable<GameFile> files = await launcher.ExtractFiles("1.20.4", cancellationToken);
```

```csharp
// за екземпляром IVersion 
IVersion version = await launcher.GetVersionAsync("1.20.4", cancellationToken);
IEnumerable<GameFile> files = await launcher.ExtractFiles(version, cancellationToken);
```

### Встановлення файлів

```csharp
// повідомлення про прогрес встановлення через launcher.FileProgressChanged, launcher.ByteProgressChanged
await launcher.InstallAsync("1.20.4", cancellationToken); // за назвою версії
await launcher.InstallAsync(version, cancellationToken); // за екземпляром IVersion 

// повідомлення про прогрес встановлення через fileProgress, byteProgress
await launcher.InstallAsync("1.20.4", fileProgress, byteProgress, cancellationToken); // за назвою версії 
await launcher.InstallAsync(version, fileProgress, byteProgress, cancellationToken); // за екземпляром IVersion 
```

### Створення процесу гри

```csharp
// за назвою версії
Process process = await launcher.BuildProcessAsync("1.20.4", new MLaunchOption(), cancellationToken);
```

```csharp
// за екземпляром IVersion
IVersion version = await launcher.GetVersionAsync("1.20.4", cancellationToken);
Process process = launcher.BuildProcess(version, new MLaunchOption());
```

### Отримання шляху до Java

```csharp
IVersion version = await launcher.GetVersionAsync("1.20.4", cancellationToken);
string? javaPath = await launcher.GetJavaPath(version);
```

Отримання шляху до першої встановленої Java

```csharp
string? javaPath = await launcher.GetDefaultJavaPath();
```

## Довідник API

- https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.MinecraftLauncher.html
