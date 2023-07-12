# 예시 런처

이 레포지토리에서 CmlLib.Core 를 사용한 런처는 두가지가 있습니다.\
두 런처는 [release](https://github.com/CmlLib/CmlLib.Core/releases) 에서 다운받거나, 레포를 클론하여 직접 빌드할 수 있습니다.


## [CmlLib-Minecraft-Launcher](https://github.com/CmlLib/CmlLib-Minecraft-Launcher)

CmlLib.Core 와 CmlLib.Core.Auth.Microsoft 를 함께 사용한 샘플 런처.


## CmlLibCoreSample

[./CmlLibCoreSample/Program.cs](https://github.com/CmlLib/CmlLib.Core/tree/master/CmlLibCoreSample)\
.NET Core 콘솔 런처. 필수적인 기능만 포함하고 있습니다.

## CmlLibWinFormSample

[./CmlLibWinFormSample](https://github.com/CmlLib/CmlLib.Core/tree/master/CmlLibWinFormSample)\
.NET Core Winform 런처. CmlLib.Core 의 거의 모든 기능이 포함되어 있습니다. ![image](https://user-images.githubusercontent.com/17783561/82755684-2b385980-9e10-11ea-966e-9edb2f1c0718.png)

런처를 사용할 때 모든 칸을 채우지 않아도 됩니다. 로그인 하고 버전 선택해서 게임 실행 버튼을 누르면 됩니다. [MLaunchOption.md](../getting-started/MLaunchOption.md "mention")

이 런처에는 게임 출력을 표시해주는 기능이 있기 때문에 만약 게임 실행에 문제가 있다면 이 런처를 통해 문제를 찾아 보세요.
