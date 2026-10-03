---
description: Завантаження файлів гри
---

# GameInstaller

`IGameInstaller` перевіряє наявність та цілісність файлу і завантажує його за потреби.

`GameInstaller` викликає події, які відображають прогрес встановлення. Дивіться [Обробка подій](../getting-started/Handling-Events.md).

### Приклад

```csharp
var installer = ParallelGameInstaller.CreateAsCoreCount(new HttpClient());
var file = new GameFile("name")
{
    Path = "абсолютний шлях до файлу",
    Hash = "контрольна сума SHA1 у вигляді шестнадцятирічного рядка (hex)",
    Size = 1024, // розмір файлу
    Url = "URL-адреса для завантаження файлу",
};
await installer.Install([file], fileProgress, byteProgress, CancellationToken.None);
```

### BasicGameInstaller

Однопотоковий інсталятор

```csharp
var installer = new BasicGameInstaller(new HttpClient());
```

### ParallelGameInstaller

Багатопотоковий інсталятор. Метод `CreateAsCoreCount` ініціалізує новий `ParallelGameInstaller` з кількістю операцій, що відповідає кількості ядер поточного ПК.

```csharp
var installer = ParallelGameInstaller.CreateAsCoreCount(new HttpClient());
```

Ви можете вказати максимальну кількість паралельних дій (паралелізму) для кожного завдання:

```csharp
var installer = new ParallelGameInstaller(
    maxChecker: 4,
    maxDownloader: 8,
    boundedCapacity: 2048, // розмір черги завантаження
    new HttpClient());
```
