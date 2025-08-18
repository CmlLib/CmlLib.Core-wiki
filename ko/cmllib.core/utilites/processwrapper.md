# ProcessWrapper

게임이 정상적으로 실행되었는지, 오류로 인해 종료되었는지 확인하기 위해서는 프로세스의 표준 출력으로 표시되는 로그를 수집하고 exit code 를 확인하면 됩니다.

CmlLib 런처가 반환하는 .NET `System.Diagnostics.Process` 클래스로 이를 구현하려면 코드가 복잡해질 수 있습니다. 이 과정을 단순화하기 위해 `ProcessWrapper` 클래스를 제공합니다.

`ProcessWrapper`의 핵심 기능은 다음과 같습니다:

* 표준 출력 읽기: 프로세스의 표준 출력을 이벤트로 알립니다.
* 종료 코드 확인: 프로세스가 종료될 때까지 비동기적으로 대기하고, 종료 코드를 반환합니다.

**사용 예제**

```csharp
// 1. 게임 프로세스 생성
var process = launcher.BuildProcessAsync("1.20.4", new MLaunchOption());

// 2. ProcessWrapper 생성
var processWrapper = new ProcessWrapper(process);

// 3. 로그가 출력되었을 때 작업 설정
processWrapper.OutputReceived += (sender, log) => 
{
    // (예시) 단순히 콘솔에 로그를 그대로 출력
    Console.WriteLine(log);
};

// 4. 프로세스 시작
processWrapper.StartWithEvents();

// 5. 프로세스가 종료될 때까지 대기하고, 종료 코드를 확인
int exitCode = await processWrapper.WaitForExitTaskAsync();
if (exitCode == 0)
{
    Console.WriteLine("게임이 정상적으로 종료되었습니다.");
}
else
{
    Console.WriteLine($"게임 오류 발생! 종료 코드: {exitCode}");
}
```
