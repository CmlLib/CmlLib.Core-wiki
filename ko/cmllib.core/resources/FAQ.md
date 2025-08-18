# 자주 묻는 질문

## 게임 출력 가져오기 (logs)

게임 프로세스의 표준 입출력을 통해 프로세스의 상태와 로그를 쉽게 얻을 수 있습니다.
`CreateProcess` 메서드가 .NET 에서 제공하는 `Process` 인스턴스를 반환하기 때문에, `Process` 의 모든 API 를 사용할 수 있습니다. ([reference](https://docs.microsoft.com/en-us/dotnet/api/system.diagnostics.process?view=net-6.0))

```csharp
process.StartInfo.CreateNoWindow = false;
process.StartInfo.UseShellExecute = false;
process.StartInfo.RedirectStandardError = true;
process.StartInfo.RedirectStandardOutput = true;
process.EnableRaisingEvents = true;
process.ErrorDataReceived += (s, e) => Console.WriteLine(e.Data);
process.OutputDataReceived += (s, e) => Console.WriteLine(e.Data);

process.Start();
process.BeginErrorReadLine();
process.BeginOutputReadLine();
```

위 코드는 게임 출력을 모두 콘솔에 출력합니다. 콘솔에서 게임 로그를 확인할 수 있습니다.

## 커스텀 클라이언트 실행

두 파일이 필요합니다: `<버전_이름>.jar`, `<버전_이름>.json`.
두 파일을 `<게임_폴더>/versions/<버전_이름>` 디렉토리에 넣으세요.

예시)

```
<게임_폴더>
 | - versions
 |    | - myversion
 |    |    | - myversion.jar
 |    |    | - myversion.json
```

버전 디렉토리의 이름, jar 파일의 이름, json 파일의 이름, 그리고 json 파일 안 `id` 속성이 모두 같은 값이여야만 합니다.

만약 버전 json 파일을 바닐라 버전의 파일으로부터 복사해온 것이라면, `downloads` 속성을 제거해야 합니다. 그렇지 않으면 런처에서 커스텀 클라이언트 파일을 바닐라 클라이언트 파일로 덮어쓰기합니다.

(예시 1.12.2.json)

```
1.12.2.json <-> 1.12.2-커스텀.json

 | {
 |     "assetIndex": {
 |         "id": "1.12",
 |         "sha1": "1584b57c1a0b5e593fad1f5b8f78536ca640547b",
 |         "size": 143138,
 |         "totalSize": 129336389,
 |         "url": "https://launchermeta.mojang.com/v1/packages/1584b57c1a0b5e593fad1f5b8f78536ca640547b/1.12.json"
 |     },
 |     "assets": "1.12",
 |     "complianceLevel": 0,
-|      "downloads": {            <===== 이 속성 제거
-|         "client": {
-|             "sha1": "0f275bc1547d01fa5f56ba34bdc87d981ee12daf",
-|             "size": 10180113,
-|             "url": "https://launcher.mojang.com/v1/objects/0f275bc1547d01fa5f56ba34bdc87d981ee12daf/client.jar"
-|         },
-|         "server": {
-|             "sha1": "886945bfb2b978778c3a0288fd7fab09d315b25f",
-|             "size": 30222121,
-|             "url": "https://launcher.mojang.com/v1/objects/886945bfb2b978778c3a0288fd7fab09d315b25f/server.jar"
-|         }
-|    },
*|     "id": "1.12.2-modified", <== make sure id is same as version name
 |     "javaVersion": {
 |         "component": "jre-legacy",
 |         "majorVersion": 8
 |     },

```

모장 런처에서 실행할 수 있는 모든 버전은 CmlLib 에서도 실행 가능합니다. 반대로 말하면 모장 런처에서 실행할 수 없는 버전은 CmlLib 에서 정상 실행을 보장하지 않습니다. 모장 런처에서 커스텀 클라이언트가 잘 실행되는 것을 확인한 후에 CmlLib 에서 사용하세요.

## [log4j2 vulnerability (CVE-2021-44228)](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44228)

`CmlLib 0.0.1` \~ `CmlLib.Core 3.3.3` 버전에서 실행한 마인크래프트는 log4j2 취약점을 가지고 있을 수 있습니다. `CmlLib.Core 3.3.4` 이후 버전에서 실행한 마인크래프트는 안전합니다.
