# ForgeInstaller

ForgeInstaller надає функціонал для завантаження та встановлення версій Forge для Minecraft.

## Ініціалізація інсталятора

```csharp
var path = new MinecraftPath();
var launcher = new MinecraftLauncher(path);
var forgeInstaller = new ForgeInstaller(launcher);
```

За бажанням ви можете налаштувати `HttpClient`, який використовується для доступу до вебсайту Forge, за допомогою `new ForgeInstaller(launcher, new HttpClient())`.

## Отримання списку доступних версій

```csharp
var versions = await forgeInstaller.GetForgeVersions("1.20.1");
foreach (var version in versions)
{
    Console.WriteLine();
    Console.WriteLine("Версія Minecraft: " + version.MinecraftVersionName);
    Console.WriteLine("Версія Forge: " + version.ForgeVersionName);
    Console.WriteLine("Дата: " + version.Time);
    Console.WriteLine("Остання версія: " + version.IsLatestVersion);
    Console.WriteLine("Рекомендована версія: " + version.IsRecommendedVersion);

    var installerFile = version.GetInstallerFile();
    if (installerFile != null)
    {
        Console.WriteLine("Тип: " + installerFile.Type);
        Console.WriteLine("Пряме посилання: " + installerFile.DirectUrl);
        Console.WriteLine("Рекламне посилання: " + installerFile.AdUrl);
        Console.WriteLine("MD5: " + installerFile.MD5);
        Console.WriteLine("SHA1: " + installerFile.SHA1);
    }
}
```

Цей метод отримує всі доступні версії Forge, які можна встановити для вказаної версії Minecraft.

## Встановлення

### Встановлення найоптимальнішої версії

```csharp
var installedVersionName = await forgeInstaller.Install("1.20.1", new ForgeInstallOptions());
```

Знаходить та встановлює найвідповіднішу версію Forge, доступну для Minecraft 1.20.1.

Оптимальна версія обирається за такими правилами пріоритету:

1. Перша версія з прапорцем «Recommended Version» (Рекомендована версія)
2. Перша версія з прапорцем «Latest Version» (Остання версія)
3. Найперша (найвища) версія у списку версій

### Встановлення конкретної версії

```csharp
var installedVersionName = await forgeInstaller.Install("1.20.1", "47.1.0", new ForgeInstallOptions());
```

Встановлює версію Forge 47.1.0 для Minecraft 1.20.1.

### Встановлення найновішої версії

```csharp
var versions = await forgeInstaller.GetForgeVersions("1.20.1");
var latestVersion = versions.First(v => v.IsLatestVersion);
var installedVersionName = await forgeInstaller.Install(latestVersion, new ForgeInstallOptions());
```

Знаходить та встановлює найновішу доступну версію Forge для Minecraft 1.20.1.

## Параметри встановлення

Щоб використовувати такі можливості, як відображення прогресу встановлення та скасування, налаштуйте відповідні значення в `ForgeInstallOptions`.

```csharp
var installOptions = new ForgeInstallOptions
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
var installedVersionName = await forgeInstaller.Install("1.20.1", installOptions);
```

- **FileProgress** та **ByteProgress**: повідомляють про прогрес завантаження файлів. Див. [Обробка подій](../cmllib.core/getting-started/Handling-Events.md) для отримання детальнішої інформації.
- **InstallerOutput**: виводить логи з консолі інсталятора.
- **CancellationToken**: дозволяє скасувати процес встановлення.
- **JavaPath**: задає шлях до середовища виконання Java, яке використовується для запуску інсталятора. Значення за замовчуванням — `null`, що автоматично визначає шлях до Java.
- **SkipIfAlreadyInstalled**: якщо встановити значення `true`, процес пропускає встановлення, якщо цільова версія вже встановлена. Значення за замовчуванням — `true`.

## Важлива примітка щодо повного встановлення

`forgeInstaller.Install` не встановлює версію Forge повністю. Для роботи версії все ще потрібні додаткові файли, такі як звукові ресурси, середовище виконання Java та файли ванільної версії. Тому ви завжди повинні викликати `launcher.InstallAsync` перед запуском гри.

```csharp
// Встановлення Forge
var versionName = await forgeInstaller.Install("1.20.1", new ForgeInstallOptions());

// Встановлення решти залежностей (звуки, середовище Java, ванільна версія)
await launcher.InstallAsync(versionName);

// Запуск гри
var process = await launcher.BuildProcessAsync(versionName, new MLaunchOption
{
    MaximumRamMb = 1024,
    Session = MSession.CreateOfflineSession("Gamer123"),
});
process.Start();
```

## Про рекламу

`ForgeInstaller` відкриє сторінку з рекламою після успішного встановлення. Офіційний інсталятор Forge показує таке повідомлення:

```
Please do not automate the download and installation of Forge.
Our efforts are supported by ads from the download page.
If you MUST automate this, please consider supporting the project through https://www.patreon.com/LexManos
```

Якщо ви хочете вимкнути цю поведінку, ви можете самостійно змінити [вихідний код ForgeInstaller](https://github.com/CmlLib/CmlLib.Core.Installer.Forge/blob/main/CmlLib.Core.Installer.Forge/ForgeInstaller.cs).

## Довідник API

- [ForgeInstaller](https://cmllib.github.io/CmlLib.Core.Installer.Forge/api/CmlLib.Core.Installer.Forge.ForgeInstaller.html)
- [ForgeInstallOptions](https://cmllib.github.io/CmlLib.Core.Installer.Forge/api/CmlLib.Core.Installer.Forge.ForgeInstallOptions.html)
