---
description: 마인크래프트 디렉터리의 경로와 구조를 나타냅니다.
---

# 게임 경로 설정

게임 파일이 저장되는 마인크래프트 디렉토리의 경로와 구조를 바꿀 수 있습니다.

## Example

마인크래프트 경로를 `./games` 로 설정하고 기본 디렉터리 구조로 `MinecraftLauncher` 를 초기화합니다.

```csharp
// initialize launcher with the specific path
MinecraftPath myPath = new MinecraftPath("./games");
MinecraftLauncher launcher = new MinecraftLauncher(myPath);

// myPath.BasePath : ./games
// myPath.Library : ./games/libraries
// myPath.Resource : ./games/resources
// myPath.Versions : ./games/versions
// myPath.GetVersionJarPath("1.16.5") : ./games/versions/1.16.5/1.16.5.jar
// myPath.GetIndexFilePath("1.16.5") : ./games/assets/indexes/1.16.5.json
```

## 기본 디렉터리 경로

`MinecraftPath.GetOSDefaultPath()` 메서드나 `new MinecraftPath()` 으로 기본 디렉터리 경로를 가져올 수 있습니다.

기본 디렉터리 경로는 다음과 같습니다:

* Windows: `%appdata%\.minecraft`
* Linux: `$HOME/.minecraft`
* macOS: `$HOME/Library/Application Support/minecraft`

## 기본 디렉터리 구조

```
Root directory : MinecraftPath.BasePath
 | - assets : MinecraftPath.Assets
 |    | - indexes
 |    |    | - {asset id}.json : MinecraftPath.GetIndexFilePath(assetId)
 |    | - objects : MinecraftPath.GetAssetObjectPath(assetId)
 |    | - virtual
 |         | - legacy : MinecraftPath.GetAssetLegacyPath(assetId)
 |
 | - libraries : MinecraftPath.Library
 | - resources : MinecraftPath.Resource
 | - runtime : MinecraftPath.Runtime
 | - versions : MinecraftPath.Versions
      | - {version name}
            | - {version name}.jar : MinecraftPath.GetVersionJarPath("version_name")
            | - {version name}.json : MinecraftPath.GetVersionJsonPath("version_name")
            | - natives : MinecraftPath.GetNativePath("version_name")
```

## 커스텀 디렉터리 구조 만들기

커스텀 디렉터리 구조를 만들기 위한 두가지 방법이 있습니다.

{% hint style="info" %}
모든 경로는 절대 경로로 저장됩니다. 상대 경로를 인수로 받은 경우, 절대 경로로 바꾸어 저장됩니다.
{% endhint %}

### 속성 설정하기

경로 속성을 바꾸세요. 모든 속성 (`Libraries`, `Versions`, 등) 은 [#properties](MinecraftPath.md#properties "mention") 에서 확인하세요

```csharp
MinecraftPath myPath = new MinecraftPath();
myPath.Libraries = "./commons/libs";
myPath.Versions = "./commons/versions";
myPath.Assets = MinecraftPath.GetOSDefaultPath() + "/assets";
```

### 상속

`MinecraftPath` 를 상속받는 클래스를 만들고 메서드를 오버라이드하세요. 모든 메서드 (`CreateDirs`, `NormalizePath`, 등등) 은은 [#methods](MinecraftPath.md#methods "mention") 에서 확인하세요.

{% hint style="info" %}
상대 경로를 인수로 받은 경우 반드시 절대 경로로 바꾸어 저장하세요.
{% endhint %}

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
    
    // 주의: 이 경로를 바꾸면 마인크래프트에서 인식하지 못할수도 있습니다
    public override string GetIndexFilePath(string assetId)
        => NormalizePath($"{Assets}/indexes/{assetId}.json");

    // 주의: 이 경로를 바꾸면 마인크래프트에서 인식하지 못할수도 있습니다
    public override string GetAssetObjectPath(string assetId)
        => NormalizePath($"{Assets}/objects");

    // 주의: 이 경로를 바꾸면 마인크래프트에서 인식하지 못할수도 있습니다
    public override string GetAssetLegacyPath(string assetId)
        => NormalizePath($"{Assets}/virtual/legacy");

    // 주의: 이 경로를 바꾸면 마인크래프트에서 인식하지 못할수도 있습니다
    public override string GetLogConfigFilePath(string configId)
        => NormalizePath($"{Assets}/log_configs/{configId}" + (!configId.EndsWith(".xml") ? ".xml" : ""));
}
```

## API References

<details>

<summary>Constructors</summary>

**public MinecraftPath()**

Initialize instance with default path.\
Same as `new MinecraftPath(MinecraftPath.GetOSDefaultPath())`.

**public MinecraftPath(string p)**

Initializze instance with the specific path, `p`.\
Call `Initialize(p)` and `CreateDirs()`.

</details>

<details>

<summary>Properties</summary>

**Properties**

**BasePath**

_Type: string_

Root directory path

**Assets**

_Type: string_

**Library**

_Type: string_

**Versions**

_Type: string_

**Runtime**

_Type: string_

The default download path of `MJava`

**Resource**

_Type: string_

Old minecraft versions use this path as Assets directory.

</details>

<details>

<summary>Methods</summary>

**Methods**

**public void CreateDirs()**

Create `BasePath`, `Assets`, `Library`, `Versions`, `Runtime`, `Resouce` directory.

**public virtual string GetIndexFilePath(string assetId)**

Get asset index file path.

**public virtual string GetAssetObjectPath(string assetId)**

Get asset object directory path.

**public virtual string GetAssetLegacyPath(string assetId)**

Get asset legacy directory path.

**public virtual string GetVersionJarPath(string id)**

Get client jar path.

**public virtual string GetVersionJsonPath(string id)**

Get client json path.

**public virtual string GetNativePath(string id)**

Get native directory path.\
Native dll files will be stored here.

**protected static string Dir(string path)**

Normalize `path` and create directory.

**protected static string NormalizePath(string path)**

Normalize `path`. Convert relative path to absolute path and replace invalid directory separator. (In windows, replace `/` to `\`)

</details>
