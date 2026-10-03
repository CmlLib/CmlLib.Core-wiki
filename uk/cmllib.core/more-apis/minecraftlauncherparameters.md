# MinecraftLauncherParameters

Ви можете змінити стандартну поведінку лаунчера.

### Приклад

```csharp
var path = new MinecraftPath();
var parameters = MinecraftLauncherParameters.CreateDefault(path);

// встановлення стандартного RulesEvaluator
parameters.RulesEvaluator = new RulesEvaluator();

// завантажувати лише локально встановлені версії 
parameters.VersionLoader = new LocalJsonVersionLoader(path);

// встановлення стандартного JavaPathResolver
parameters.JavaPathResolver = new MinecraftJavaPathResolver(path);

// використання однопотокового інсталятора гри
parameters.GameInstaller = new BasicGameInstaller(parameters.HttpClient);

// модифікація стандартних екстракторів файлів
var extractors = DefaultFileExtractors.CreateDefault(
    parameters.HttpClient, 
    parameters.RulesEvaluator!, 
    parameters.JavaPathResolver!);
extractors.Asset!.AssetServer = MojangServer.ResourceDownload; // встановлення сервера завантаження асетів
extractors.Library!.LibraryServer = MojangServer.Library; // встановлення сервера завантаження бібліотек
extractors.Java = null; // видалення JavaFileExtractor
extractors.ExtraExtractors = []; // додавання додаткового екстрактора файлів
parameters.FileExtractors = extractors.ToExtractorCollection();

// ініціалізація нового лаунчера з налаштованими параметрами
var launcher = new MinecraftLauncher(parameters);
```

### MinecraftPath

Дивіться [Minecraft Path](../getting-started/MinecraftPath.md)

```csharp
var path = new MinecraftPath();
var parameters = MinecraftLauncherParameters.CreateDefault(path);
```

### HttpClient

Усі HTTP-запити використовують цей HttpClient. Ви можете використовувати бібліотеку [Polly](https://github.com/App-vNext/Polly) для реалізації таких функцій, як автоматичні повторні спроби у разі невдалих запитів чи завантажень.

```csharp
var path = new MinecraftPath();
var httpClient = new HttpClient();
var parameters = MinecraftLauncherParameters.CreateDefault(path, httpClient);
```

### RulesEvaluator

Дивіться [Правила](rules.md)

```csharp
parameters.RulesEvaluator = new RulesEvaluator();
```

### VersionLoader

Дивіться [Версії](../getting-started/versions.md)

```csharp
parameters.VersionLoader = new MojangJsonVersionLoaderV2(path, httpClient);
```

### JavaPathResolver

Дивіться [Java](java.md)

```csharp
parameters.JavaPathResolver = new MinecraftJavaPathResolver(path);
```

### GameInstaller

Дивіться [GameInstaller](Downloader.md)

```csharp
parameters.GameInstaller = ParallelGameInstaller.CreateAsCoreCount(httpClient);
```

### FileExtractors

Дивіться [FileExtractor](FileChecker.md)

```csharp
var extractors = DefaultFileExtractors.CreateDefault(
    httpClient, 
    parameters.RulesEvaluator, 
    parameters.JavaPathResolver);
parameters.FileExtractors = extractors.ToExtractorCollection();
```
