# MinecraftLauncherParameters

You can change the default behavior of the launcher.

### Example

```csharp
var path = new MinecraftPath();
var parameters = MinecraftLauncherParameters.CreateDefault(path);

// set default RulesEvaluator
parameters.RulesEvaluator = new RulesEvaluator();

// load only the locally installed version 
parameters.VersionLoader = new LocalJsonVersionLoader(path);

// set default JavaPathResolver
parameters.JavaPathResolver = new MinecraftJavaPathResolver(path);

// use single-threaded game installer
parameters.GameInstaller = new BasicGameInstaller(parameters.HttpClient);

// modify default file extractors
var extractors = DefaultFileExtractors.CreateDefault(
    parameters.HttpClient, 
    parameters.RulesEvaluator!, 
    parameters.JavaPathResolver!);
extractors.Asset!.AssetServer = MojangServer.ResourceDownload; // set asset download server
extractors.Library!.LibraryServer = MojangServer.Library; // set library download server
extractors.Java = null; // remove JavaFileExtractor
extractors.ExtraExtractors = []; // add additional file extractor
parameters.FileExtractors = extractors.ToExtractorCollection();

// initialize a new launcher with parameters
var launcher = new MinecraftLauncher(parameters);
```

### MinecraftPath

See [Minecraft Path](../getting-started/MinecraftPath.md)

```csharp
var path = new MinecraftPath();
var parameters = MinecraftLauncherParameters.CreateDefault(path);
```

### HttpClient

All HTTP requests use this HttpClient. You can use [Polly](https://github.com/App-vNext/Polly) for features like automatic retries on failed requests and failed downloads.

```csharp
var path = new MinecraftPath();
var httpClient = new HttpClient();
var parameters = MinecraftLauncherParameters.CreateDefault(path, httpClient);
```

### RulesEvaluator

See [Rules](rules.md)

```csharp
parameters.RulesEvaluator = new RulesEvaluator();
```

### VersionLoader

See [Versions](../getting-started/versions.md)

```csharp
parameters.VersionLoader = new MojangJsonVersionLoaderV2(path, httpClient);
```

### JavaPathResolver

See [Java](java.md)

```csharp
parameters.JavaPathResolver = new MinecraftJavaPathResolver(path);
```

### GameInstaller

See [GameInstaller](Downloader.md)

```csharp
parameters.GameInstaller = ParallelGameInstaller.CreateAsCoreCount(httpClient);
```

### FileExtractors

See [FileExtractor](FileChecker.md)

```csharp
var extractors = DefaultFileExtractors.CreateDefault(
    httpClient, 
    parameters.RulesEvaluator, 
    parameters.JavaPathResolver);
parameters.FileExtractors = extractors.ToExtractorCollection();
```
