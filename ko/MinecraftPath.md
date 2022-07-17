# MinecraftPath

마인크래프트 디렉터리의 경로와 디렉터리 구조를 표현합니다. 

## 기본 경로

`MinecraftPath.GetOSDefaultPath()` 를 호출하거나 `MinecraftPath` 의 생성자를 인수 없이 만들어 기본 게임 디렉터리 경로를 가져올 수 있습니다.  

OS 별 기본 경로:
- Windows: %appdata%\.minecraft
- Linux: $HOME/.minecraft
- macOS: $HOME/Library/Application Support/minecraft

## 기본 구조

```
Root directory : BasePath
 | - assets : Assets
 |    | - indexes
 |    |    | - {asset_id}.json : GetIndexFilePath(assetId)
 |    | - objects : GetAssetObjectPath(assetId)
 |    | - virtual
 |         | - legacy : GetAssetLegacyPath(assetId)
 |
 | - libraries : Library
 | - resources : Resource
 | - runtime : Runtime
 | - versions : Versions
      | - {version_name}
            | - {version_name}.jar : GetVersionJarPath(id)
            | - {version_name}.json : GetVersionJsonPath(id)
            | - natives : GetNativePath(id)
```

## 예제

이 예시는 기본 게임 디렉터리 구조를 따르는 `MinecraftPath` 인스턴스를 생성합니다.  

```csharp
// 기본 경로
MinecraftPath defaultPath = new MinecraftPath();

// windows: %appdata%\.minecraft
// linux: $HOME/.minecraft
// mac: $HOME/Library/Application Support/minecraft

// 특정 경로로 설정
// 루트 경로 (myPath.BasePath): ./games
MinecraftPath myPath = new MinecraftPath("./games");

// myPath.BasePath : ./games
// myPath.Library : ./games/libraries
// myPath.Resource : ./games/resources
// myPath.Versions : ./games/versions
// myPath.GetVersionJarPath("1.16.5") : ./games/versions/1.16.5/1.16.5.jar
// myPath.GetIndexFilePath("1.16.5") : ./games/assets/indexes/1.16.5.json
```

**Note** : 모든 경로는 절대 경로로 바뀌어 저장됩니다.

## 디렉터리 구조 바꾸기

디렉터리 구조를 바꾸는 방법은 두 가지가 있습니다.  
상황에 맞는 방법을 사용하세요.  

### a. 속성 설정

경로 속성들을 원하는 값으로 바꾸세요. 

```csharp
MinecraftPath myPath = new MinecraftPath();
myPath.Libraries = "./commons/libs";
myPath.Versions = "./commons/versions";
myPath.Assets = MinecraftPath.GetOSDefaultPath() + "/assets";
```

### b. 상속 사용 

`MinecraftPath` 클래스를 상속받는 클래스를 만들어 메서드를 오버라이드하세요.  
각 메서드들은 (`CreateDirs`, `NormalizePath`, etc) 아래에 설명되어 있습니다. [설명](#Methods)

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
        => NormalizePath($"{Versions}/{id}/client.jar");
    
    public override string GetVersionJsonPath(string id)
        => NormalizePath($"{Versions}/{id}/client.json");

    public override string GetAssetObjectPath(string assetId)
        => NormalizePath($"{Assets}/files");
}
```

### 속성

#### BasePath

*Type: string*

루트 경로

#### Assets

*Type: string*

에셋 파일을 저장하는 곳. BGM, 효과음, 언어 파일 등이 저장됩니다.

#### Library

*Type: string*

#### Versions

*Type: string*

#### Runtime

*Type: string*

자바 파일이 설치되는 곳

#### Resource

*Type: string*

옛날 마인크래프트 버전은 이곳에 에셋 파일을 저장합니다. 

### 생성자

#### public MinecraftPath()

기본 경로를 통해 초기화합니다.   
`new MinecraftPath(MinecraftPath.GetOSDefaultPath())` 와 같은 동작.

#### public MinecraftPath(string p)

루트 경로를 `p` 로 설정해 초기화합니다.  
내부적으로 `Initialize(p)` 와 `CreateDirs()` 메서드를 호출합니다.

### Methods

#### public void CreateDirs()

`BasePath`, `Assets`, `Library`, `Versions`, `Runtime`, `Resouce` 디렉토리를 만듭니다..

#### public virtual string GetIndexFilePath(string assetId)

Get asset index file path.

#### public virtual string GetAssetObjectPath(string assetId)

Get asset object directory path.

#### public virtual string GetAssetLegacyPath(string assetId)

Get asset legacy directory path.

#### public virtual string GetVersionJarPath(string id)

Get client jar path.

#### public virtual string GetVersionJsonPath(string id)

Get client json path.

#### public virtual string GetNativePath(string id)

Get native directory path.  
Native dll files will be stored here.

#### protected static string Dir(string path)

Normalize `path` and create directory.

#### protected static string NormalizePath(string path)

Normalize `path`. Convert relative path to absolute path and replace invalid directory separator. (In windows, replace `/` to `\`)