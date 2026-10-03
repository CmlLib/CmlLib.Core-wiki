# ProcessWrapper

Щоб перевірити, чи гра запустилася успішно, чи завершила роботу через помилку, вам потрібно збирати логи, що виводяться в стандартний вивід (standard output) процесу, та перевіряти код завершення (exit code).

Реалізація цього за допомогою стандартного класу .NET `System.Diagnostics.Process`, який повертає лаунчер CmlLib, може ускладнити код. Клас `ProcessWrapper` надається саме для того, щоб спростити цей процес.

Основні можливості `ProcessWrapper`:

* Читання стандартного виводу: сповіщає через події (events), коли з'являються нові логи в стандартному виводі процесу.
* Перевірка коду завершення: асинхронно очікує на завершення процесу та повертає код завершення.

**Приклад використання**

```csharp
// 1. Створення процесу гри
var process = await launcher.BuildProcessAsync("1.20.4", new MLaunchOption());

// 2. Створення ProcessWrapper
var processWrapper = new ProcessWrapper(process);

// 3. Налаштування дій при отриманні логів
processWrapper.OutputReceived += (sender, log) => 
{
    // (Приклад) Просто виводимо логи в консоль "як є"
    Console.WriteLine(log);
};

// 4. Запуск процесу
processWrapper.StartWithEvents();

// 5. Очікування завершення процесу та перевірка коду завершення
int exitCode = await processWrapper.WaitForExitTaskAsync();
if (exitCode == 0)
{
    Console.WriteLine("Гра завершила роботу успішно.");
}
else
{
    Console.WriteLine($"Сталася помилка гри! Код завершення: {exitCode}");
}
```

## Довідник API

- [ProcessWrapper](https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.ProcessBuilder.ProcessWrapper.html)
