# NeoForgeInstaller

NeoForgeInstaller надає функціонал для завантаження та встановлення версій NeoForge для Minecraft.

## Ініціалізація інсталятора

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);
var neoForgeInstaller = new NeoForgeInstaller(launcher);
```

За бажанням ви можете налаштувати `HttpClient`, який використовується для доступу до вебсайту NeoForge, за допомогою `new NeoForgeInstaller(launcher, new HttpClient())`.

## Отримання списку доступних версій

```csharp
var versions = await neoForgeInstaller.GetForgeVersions("1.21.10");
foreach (var version in versions)
{
    Console.WriteLine();
    Console.WriteLine("Версія Minecraft: " + version.MinecraftVersion);
    Console.WriteLine("Версія NeoForge: " + version.VersionName);

    var installerFile = version.GetInstallerFile();
    if (installerFile != null)
    {
        Console.WriteLine("Пряме посилання:" + installerFile.DirectUrl);
    }
}
```

Цей метод отримує всі доступні версії NeoForge, які можна встановити для вказаної версії Minecraft.

## Встановлення

### Встановлення найоптимальнішої версії

```csharp
var installedVersionName = await neoForgeInstaller.Install("1.21.10", new NeoForgeInstallOptions());
```

Знаходить та встановлює найвідповіднішу версію NeoForge, доступну для Minecraft 1.21.10.

Оптимальна версія обирається за такими правилами пріоритету:

1. Перша версія з прапорцем «Recommended Version» (Рекомендована версія)
2. Перша версія з прапорцем «Latest Version» (Остання версія)
3. Найперша (найвища) версія у списку версій

### Встановлення конкретної версії

```csharp
var installedVersionName = await neoForgeInstaller.Install("1.21.10", "21.10.56-beta", new NeoForgeInstallOptions());
```

Встановлює версію NeoForge 21.10.56-beta для Minecraft 1.21.10.

### Встановлення найновішої версії

```csharp
var versions = await neoForgeInstaller.GetForgeVersions("1.21.10");
var latestVersion = versions.First();
var installedVersionName = await neoForgeInstaller.Install(latestVersion, new NeoForgeInstallOptions());
```

Знаходить та встановлює найновішу доступну версію NeoForge для Minecraft 1.21.10.

## Параметри встановлення

Щоб використовувати такі можливості, як відображення прогресу встановлення та скасування, налаштуйте відповідні значення в `NeoForgeInstallOptions`.

```csharp
var installOptions = new NeoForgeInstallOptions
{
    FileProgress = new Progress<InstallerProgressChangedEventArgs>(e =>
        Console.WriteLine($"[{e.EventType}][{e.ProgressedTasks}/{e.TotalTasks}] {e.Name}")),
    ByteProgress = new Progress<ByteProgress>(e =>
        Console.WriteLine(e.ToRatio() * 100 + "%")),
    InstallerOutput = new Progress<string>(e =>
        Console.WriteLine(e)),
    CancellationToken = CancellationToken.None,

    JavaPath = "java.exe",
    SkipIfAlreadyInstalled = true,
};
var installedVersionName = await neoForgeInstaller.Install("1.21.10", installOptions);
```

- **FileProgress** та **ByteProgress**: повідомляють про прогрес завантаження файлів. Див. [Обробка подій](../cmllib.core/getting-started/Handling-Events.md) для отримання детальнішої інформації.
- **InstallerOutput**: виводить логи з консолі інсталятора.
- **CancellationToken**: дозволяє скасувати процес встановлення.
- **JavaPath**: задає шлях до середовища виконання Java, яке використовується для запуску інсталятора. Значення за замовчуванням — `null`, що автоматично визначає шлях до Java.
- **SkipIfAlreadyInstalled**: якщо встановити значення `true`, процес пропускає встановлення, якщо цільова версія вже встановлена. Значення за замовчуванням — `true`.

## Важлива примітка щодо повного встановлення

`neoForgeInstaller.Install` не встановлює версію NeoForge повністю. Для роботи версії все ще потрібні додаткові файли, такі як звукові ресурси, середовище виконання Java та файли ванільної версії. Тому ви завжди повинні викликати `launcher.InstallAsync` перед запуском гри.

```csharp
// Встановлення NeoForge
var versionName = await neoForgeInstaller.Install("1.21.10", new NeoForgeInstallOptions());

// Встановлення решти залежностей (звуки, середовище Java, ванільна версія)
await launcher.InstallAsync(versionName);

// Запуск гри
var process = await launcher.BuildProcessAsync(versionName, new MLaunchOption
{
    MaximumRamMb = 1024,
    Session = MSession.CreateOfflineSession("GamerVII"),
});
process.Start();
```
