---
description: 런처의 작동 방식을 바꿀 수 있습니다.
---

# MinecraftLauncherParameters

### 예시

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

[MinecraftPath.md](../getting-started/MinecraftPath.md "mention") 참고

```csharp
var path = new MinecraftPath();
var parameters = MinecraftLauncherParameters.CreateDefault(path);
```

### HttpClient

모든 HTTP 요청은 이 HttpClient 를 사용합니다. 요청 실패 혹은 파일 다운로드 실패시 재시도 같은 기능을 위해 [Polly](https://github.com/App-vNext/Polly) 를 사용할 수 있습니다.

```csharp
var path = new MinecraftPath();
var httpClient = new HttpClient();
var parameters = MinecraftLauncherParameters.CreateDefault(path, httpClient);
```

### RulesEvaluator

[rules.md](rules.md "mention") 참고

```csharp
parameters.RulesEvaluator = new RulesEvaluator();
```

### VersionLoader

[undefined.md](../getting-started/undefined.md "mention") 참고

```csharp
parameters.VersionLoader = new MojangJsonVersionLoaderV2(path, httpClient);
```

### JavaPathResolver

[java.md](java.md "mention") 참고

```csharp
parameters.JavaPathResolver = new MinecraftJavaPathResolver(path);
```

### GameInstaller

[Downloader.md](Downloader.md "mention") 참고

```csharp
parameters.GameInstaller = ParallelGameInstaller.CreateAsCoreCount(httpClient);
```

### FileExtractors

[FileChecker.md](FileChecker.md "mention") 참고

```csharp
var extractors = DefaultFileExtractors.CreateDefault(
    httpClient, 
    parameters.RulesEvaluator, 
    parameters.JavaPathResolver);
parameters.FileExtractors = extractors.ToExtractorCollection();
```
