---
description: Отримання списків змін Minecraft
---

# Списки змін Minecraft

![image](https://user-images.githubusercontent.com/17783561/82139750-20f0eb00-9865-11ea-8a41-c045ee123c09.png)

## Приклад коду

Дивіться [ChangeLog.cs](https://github.com/CmlLib/CmlLib.Core/blob/master/examples/winform/ChangeLog.cs) у проєкті CmlLibWinFormSample.

## Приклад

```csharp
Changelogs changelogs = await Changelogs.GetChangelogs(); // отримання інформації про списки змін
string[] versions = changelogs.GetAvailableVersions(); // отримання всіх доступних версій
string changelogHtml = await changelogs.GetChangelogHtml("1.16.5"); // отримання HTML списку змін для 1.16.5
```

## Методи

### static GetChangelogs()

_Повертає: `Task<Changelogs>`_

Отримує інформацію про списки змін із сервера Mojang.

### GetAvailableVersions()

_Повертає: `string[]`_

Повертає версії Minecraft, для яких доступний список змін.

### GetChangelogHtml(string version)

_Повертає: `Task<string>`_

Повертає HTML-код списку змін для вказаної `version`.
HTML-код містить лише самий список змін, без шапки (header) чи нижньою частини (footer). За бажанням ви можете відобразити цей HTML за допомогою елемента WebBrowser.
