# 버전

### 예시: 모든 버전 출력

`GetAllVersionsAsync` 메서드는 모든 바닐라 버전과 설치된 모든 버전을 반환합니다.

```csharp
var launcher = new MinecraftLauncher();
var versions = await launcher.GetAllVersionsAsync();
foreach (var version in versions)
{
    Console.WriteLine("Name: " + version.Name);
    Console.WriteLine("Type: " + version.GetVersionType());
    Console.WriteLine("ReleaseTime: " + version.ReleaseTime);
}
```

### 예시: 특정 버전 가져오기

`GetVersionAsync` 메서드는 버전을 로드, 파싱합니다.

```csharp
var launcher = new MinecraftLauncher();
var version = await launcher.GetVersionAsync("1.20.4");
// version.Id
// version.Jar
// version.Libraries
// etc...
```

### 예시: 버전 수정하기

`IVersion` 은 immutable 타입으로 설계되었지만  `.ToMutableVersion` 메서드를 호출하면 mutable 타입으로 변환할 수 있습니다.

1.16.5 버전에서 offline session 으로 게임을 실행한 경우 멀티플레이 버튼이 비활성화됩니다. 이 문제는 수정된 `authlib` 라이브러리를 사용하여 해결할 수 있습니다. ([#85](https://github.com/CmlLib/CmlLib.Core/issues/85))

```csharp
var launcher = new MinecraftLauncher();
var version = (await launcher.GetVersionAsync("1.16.5")).ToMutableVersion();

// 기존의 authlib 제거
version.LibraryList.RemoveAt(version.LibraryList.FindIndex(lib => lib.Name == "com.mojang:authlib:2.1.28"));

// 수정된 authlib 추가
// authlib-2.1.28-workaround.jar 다운로드 후 <game_directory>/libraries/com/mojang/authlib/2.1.28/authlib-2.1.28-workaround.jar 경로에 넣기
version.LibraryList.Add(new MLibrary("com.mojang:authlib:2.1.28")
{
    Artifact = new CmlLib.Core.Files.MFileMetadata
    {
        Path = "com/mojang/authlib/2.1.28/authlib-2.1.28-workaround.jar",
        Sha1 = "", // (optional) 파일의SHA1 체크섬
        Url = "" // (optional) 파일이 존재하지 않거나 체크섬이 일치하지 않을 때 다운로드할 파일의 URL
    }
});

await launcher.InstallAsync(version);
var process = launcher.BuildProcess(version, new MLaunchOption
{
    Session = MSession.CreateOfflineSession("tester123")
});
process.Start(); 
```
