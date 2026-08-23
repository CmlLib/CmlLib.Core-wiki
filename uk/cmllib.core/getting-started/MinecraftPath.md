---
description: Представляє шлях та структуру директорії Minecraft.
---

# MinecraftPath

Ви можете налаштувати шлях та структуру директорії гри Minecraft, де зберігаються всі ігрові файли.

## Приклад

Ініціалізація `MinecraftLauncher` із власним шляхом Minecraft та стандартною структурою директорій.

```csharp
// ініціалізація лаунчера зі вказаним шляхом
MinecraftPath myPath = new MinecraftPath("./games");
MinecraftLauncher launcher = new MinecraftLauncher(myPath);

// myPath.BasePath : ./games
// myPath.Library : ./games/libraries
// myPath.Resource : ./games/resources
// myPath.Versions : ./games/versions
// myPath.GetVersionJarPath("1.16.5") : ./games/versions/1.16.5/1.16.5.jar
// myPath.GetIndexFilePath("1.16.5") : ./games/assets/indexes/1.16.5.json
```

## Стандартний шлях директорії

Ви можете отримати стандартний шлях директорії гри за допомогою `MinecraftPath.GetOSDefaultPath()` або створивши новий екземпляр `MinecraftPath` без аргументів.

Стандартний шлях Minecraft:

* Windows: `%appdata%\.minecraft`
* Linux: `$HOME/.minecraft`
* macOS: `$HOME/Library/Application Support/minecraft`

## Стандартна структура директорії

```
/ (MinecraftPath.BasePath)
├── assets/ (MinecraftPath.Assets)
│   ├── indexes/
│   │   └── {asset_id}.json (MinecraftPath.GetIndexFilePath(assetId))
│   ├── objects/ (MinecraftPath.GetAssetObjectPath(assetId))
│   └── virtual/
│       └── legacy/ (MinecraftPath.GetAssetLegacyPath(assetId))
├── libraries/ (MinecraftPath.Library)
├── resources/ (MinecraftPath.Resource)
├── runtime/ (MinecraftPath.Runtime)
└── versions/ (MinecraftPath.Versions)
    └── {version_name}/
        ├── {version_name}.jar (MinecraftPath.GetVersionJarPath("version_name"))
        ├── {version_name}.json (MinecraftPath.GetVersionJsonPath("version_name"))
        └── natives/ (MinecraftPath.GetNativePath("version_name"))
```

## Створення власної структури директорії

Існує два способи створити власну структуру директорії.

### Налаштування властивостей

Встановіть значення властивостей шляхів відповідно до ваших потреб. Для отримання додаткової інформації дивіться [Довідник API](#довідник-api).

!!! info "Інформація"
    Переконайтеся, що використовуєте лише абсолютні шляхи.

```csharp
MinecraftPath myPath = new MinecraftPath();
myPath.Libraries = myPath.BasePath + "/commons/libs";
myPath.Versions = myPath.BasePath + "/commons/versions";
myPath.Assets = MinecraftPath.GetOSDefaultPath() + "/assets";
```

### Успадкування

!!! info "Інформація"
    Отримуючи відносний шлях як аргумент, переконайтеся, що ви перетворюєте його на абсолютний шлях перед збереженням.

Створіть похідний клас від `MinecraftPath` та перевизначте його методи. Кожен із методів (`CreateDirs`, `NormalizePath` тощо) описано у [Довіднику API](#довідник-api).

```csharp
class MyMinecraftPath : MinecraftPath
{
    public MyMinecraftPath(string p)
    {
        BasePath = NormalizePath(p);

        Library = NormalizePath(BasePath + "/libs");
        Versions = NormalizePath(BasePath + "/vers");
        Resource = NormalizePath(BasePath + "/resources");

        Runtime = NormalizePath(BasePath + "/java");
        Assets = NormalizePath(BasePath + "/assets");

        CreateDirs();
    }

    public override string GetVersionJarPath(string id)
        => NormalizePath($"{Versions}/{id}/{id}.jar");

    public override string GetVersionJsonPath(string id)
        => NormalizePath($"{Versions}/{id}/{id}.json");

    public override string GetNativePath(string id)
        => NormalizePath($"{Versions}/{id}/natives");
    
    // ПРИМІТКА: Minecraft може не розпізнати змінений шлях
    public override string GetIndexFilePath(string assetId)
        => NormalizePath($"{Assets}/indexes/{assetId}.json");

    // ПРИМІТКА: Minecraft може не розпізнати змінений шлях
    public override string GetAssetObjectPath(string assetId)
        => NormalizePath($"{Assets}/objects");

    // ПРИМІТКА: Minecraft може не розпізнати змінений шлях
    public override string GetAssetLegacyPath(string assetId)
        => NormalizePath($"{Assets}/virtual/legacy");

    // ПРИМІТКА: Minecraft може не розпізнати змінений шлях
    public override string GetLogConfigFilePath(string configId)
        => NormalizePath($"{Assets}/log_configs/{configId}" + (!configId.EndsWith(".xml") ? ".xml" : ""));
}
```

# Довідник API {#довідник-api}

- [MinecraftPath](https://cmllib.github.io/CmlLib.Core.Commons/api/CmlLib.Core.MinecraftPath.html)
