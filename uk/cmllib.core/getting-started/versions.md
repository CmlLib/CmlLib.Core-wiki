# Версії

### Приклад: Виведення всіх версій

Метод `GetAllVersionsAsync` повертає всі ванільні та локально встановлені версії Minecraft.

```csharp
var launcher = new MinecraftLauncher();
VersionMetadataCollection versions = await launcher.GetAllVersionsAsync();
foreach (IVersionMetadata version in versions)
{
    Console.WriteLine("Name: " + version.Name);
    Console.WriteLine("Type: " + version.GetVersionType());
    Console.WriteLine("ReleaseTime: " + version.ReleaseTime);
}
```

### Приклад: Отримання конкретної версії

Метод `GetVersionAsync` завантажує та розбирає (парсить) json-файл версії.

```csharp
var launcher = new MinecraftLauncher();
IVersion version = await launcher.GetVersionAsync("1.20.4");
// version.Id
// version.Jar
// version.Libraries
// тощо...
```

### Приклад: Модифікація версії

Тип `IVersion` розроблений як незмінний (immutable). За допомогою `.ToMutableVersion()` ви можете перетворити будь-яку версію на змінювану (mutable), щоб редагувати її дані.

У версії 1.16.5 кнопка «Мережева гра» (Multiplayer) вимкнена під час запуску гри з офлайн-сесією. Це можна виправити за допомогою модифікованої бібліотеки `authlib`. ([#85](https://github.com/CmlLib/CmlLib.Core/issues/85))

```csharp
var launcher = new MinecraftLauncher();
MinecraftVersion version = (await launcher.GetVersionAsync("1.16.5")).ToMutableVersion();

// видалення існуючої authlib
version.LibraryList.RemoveAt(version.LibraryList.FindIndex(lib => lib.Name == "com.mojang:authlib:2.1.28"));

// додавання модифікованої authlib
// завантажте файл authlib-2.1.28-workaround.jar та розмістіть його у <game_directory>/libraries/com/mojang/authlib/2.1.28/authlib-2.1.28-workaround.jar
version.LibraryList.Add(new MLibrary("com.mojang:authlib:2.1.28")
{
    Artifact = new CmlLib.Core.Files.MFileMetadata
    {
        Path = "com/mojang/authlib/2.1.28/authlib-2.1.28-workaround.jar",
        Sha1 = "", // (необов'язково) контрольна сума SHA1 бібліотеки
        Url = "" // (необов'язково) URL-адреса для завантаження бібліотеки, якщо файл відсутній або контрольна сума не збігається
    }
});

await launcher.InstallAsync(version);
var process = launcher.BuildProcess(version, new MLaunchOption
{
    Session = MSession.CreateOfflineSession("tester123")
});
process.Start(); 
```

## Довідник API

- [IVersion](https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.Version.IVersion.html)
- [VersionMetadataCollection](https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.VersionMetadata.VersionMetadataCollection.html)
- [IVersionMetadata](https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.VersionMetadata.IVersionMetadata.html)
- [MVersionType](https://cmllib.github.io/CmlLib.Core/api/CmlLib.Core.VersionMetadata.MVersionType.html)
