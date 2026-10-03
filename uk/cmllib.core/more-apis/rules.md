# Правила

## RulesEvaluator

Інтерфейс `IRulesEvaluator` оцінює задані правила, щоб визначити, чи слід використовувати той чи інший файл або параметр. Деякі параметри або файли застосовуються лише у певних версіях ОС або у разі ввімкнення відповідних функцій.

### Приклади

* **Файли для конкретних ОС**: `lwjgl-windows` вмикається лише на Windows.
* **Параметри для конкретних функцій**: параметр `--demo` використовується лише тоді, коли ввімкнено функцію `is_demo_user`.

Версії гри надають властивість `rules`, щоб вказати, у яких саме середовищах мають вмикатися ті чи інші функції.

### Вбудована реалізація

Вбудована реалізація `IRulesEvaluator` під назвою `RulesEvaluator` працює ідентично до реалізації у Mojang Launcher. У більшості випадків цієї реалізації цілком достатньо.

Якщо вам потрібна власна поведінка, ви можете реалізувати свій `IRulesEvaluator`. Встановити власний `IRulesEvaluator` можна у [MinecraftLauncherParameters](minecraftlauncherparameters.md).

## RulesEvaluatorContext

`RulesEvaluatorContext` представляє інформацію про поточне середовище для оцінки заданих правил. Сюди входять тип ОС, версія, архітектура та список увімкнених на цей момент функцій.  

Наведений нижче код створює `RulesEvaluatorContext`, який представляє поточне середовище.

```csharp
var context = new RulesEvaluatorContext(LauncherOSRule.Current, []);
```

Якщо ви хочете зімітувати запуск у іншому середовищі, ви можете ініціалізувати `RulesEvaluatorContext` самостійно.  

```csharp
var context = new RulesEvaluatorContext(new LauncherOSRule("windows", "64", "10.0"), []);
```

Ви можете встановити значення `RulesContext` для лаунчера:

```csharp
var launcher = new MinecraftLauncher();
launcher.RulesContext = new RulesEvaluatorContext(new LauncherOSRule("windows", "64", "10.0"), []);
```
