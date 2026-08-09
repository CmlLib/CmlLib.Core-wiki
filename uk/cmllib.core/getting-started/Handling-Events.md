---
description: Відображення прогресу інсталятора користувачеві
---

# Обробка подій

Інсталятор гри надає два типи подій:

* `FileProgress` вказує назву, тип та кількість файлів у процесі обробки.
* `ByteProgress` вказує розмір оброблених файлів / розмір усіх файлів у байтах.

І існує два способи зареєструвати обробник подій:

* Передати `IProgress<>` у метод інсталятора гри.
* Зареєструвати обробник подій (він буде викликаний у поточному `SynchronizationContext`, тому звертатися до компонентів UI безпечно).

Якщо в метод передано `IProgress<>`, будь-які зареєстровані обробники подій будуть ігноруватися.

### Приклад (з IProgress)

```csharp
var launcher = new MinecraftLauncher();
await launcher.InstallAsync(
    "1.20.4", 
    new Progress<InstallerProgressChangedEventArgs>(e =>
    {
        Console.WriteLine("Name: " + e.Name);
        Console.WriteLine("EventType: " + e.EventType);
        Console.WriteLine("TotalTasks: " + e.TotalTasks);
        Console.WriteLine("ProgressedTasks: " + e.ProgressedTasks);
    }),
    new Progress<ByteProgress>(e =>
    {
        Console.WriteLine("TotalBytes: " + e.TotalBytes);
        Console.WriteLine("ProgressedBytes: " + e.ProgressedBytes);
        Console.WriteLine("Percentage: " + e.ToRatio() * 100);
    }),
    CancellationToken.None);
```

### Приклад (з обробником подій)

```csharp
var launcher = new MinecraftLauncher();
launcher.FileProgressChanged += (_, e) =>
{
    Console.WriteLine("Name: " + e.Name);
    Console.WriteLine("EventType: " + e.EventType);
    Console.WriteLine("TotalTasks: " + e.TotalTasks);
    Console.WriteLine("ProgressedTasks: " + e.ProgressedTasks);
};
launcher.ByteProgressChanged += (_, e) =>
{
    Console.WriteLine("TotalBytes: " + e.TotalBytes);
    Console.WriteLine("ProgressedBytes: " + e.ProgressedBytes);
    Console.WriteLine("Percentage: " + e.ToRatio() * 100);
};
await launcher.InstallAsync("1.20.4", CancellationToken.None);
```

## Поради щодо продуктивності

`FileProgress` викликається дуже часто (від 4000 до 8000 разів під час кожного виклику `InstallAsync`), тому виконання ресурсоємних завдань у цьому обробнику може негативно вплинути на продуктивність вашої програми. `ByteProgress`, з іншого боку, викликається лише 3–4 рази на секунду, тому він значно менш чутливий до продуктивності.

Коли ви реєструєте обробник подій, він внутрішньо перетворюється на `new Progress<T>(handler)`. [Progress<T>](https://learn.microsoft.com/en-us/dotnet/api/system.progress-1?view=net-8.0) поводиться по-різному залежно від поточного `SynchronizationContext`. У застосунках WinForms або WPF код обробника виконуватиметься в UI-потоці, а в консольних застосунках — у `ThreadPool`.

Тому, якщо ви використовуєте обробник подій у консольному застосунку, це генеруватиме велику кількість викликів до `ThreadPool`. Це може негативно вплинути на продуктивність вашого застосунку, тому або не використовуйте `FileProgress`, або реалізуйте `IProgress<T>`, який не задіює `ThreadPool`. Бібліотека надає `SyncProgress<T>`, який запускає обробник безпосередньо у тому потоці, який викликав подію. `SyncProgress<T>` не повинен мати прямого доступу до UI та має містити якомога менше коду.

```csharp
// приклад
IProgress<InstallerProgressChangedEventArgs> fileProgress = new SyncProgress<InstallerProgressChangedEventArgs>(e => 
{ 
    Console.WriteLine($"{e.ProgressedTasks} / {e.TotalTasks}");
});
```

## Довідник API

- [MinecraftLauncher](https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.MinecraftLauncher.html)
- [ByteProgress](https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.ByteProgress.html)
- [InstallerProgressChangedEventArgs](https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.Installers.InstallerProgressChangedEventArgs.html)
- [FileProgressChanged](https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.MinecraftLauncher.html#CmlLib_Core_MinecraftLauncher_FileProgressChanged)
- [ByteProgressChanged](https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.MinecraftLauncher.html#CmlLib_Core_MinecraftLauncher_ByteProgressChanged)
