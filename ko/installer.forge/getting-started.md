# 시작하기

## 설치

nuget 패키지 설치: [CmlLib.Core.Installer.Forge](https://www.nuget.org/packages/CmlLib.Core.Installer.Forge).

## 예시

```csharp
﻿using CmlLib.Core.Installer.Forge;
using CmlLib.Core;
using CmlLib.Core.Auth;
using CmlLib.Core.Downloader;
using System.ComponentModel;
using CmlLib.Utils;

// 진행률 콘솔에 표시
void fileChanged(DownloadFileChangedEventArgs e)
{
    Console.WriteLine($"[{e.FileKind.ToString()}] {e.FileName} - {e.ProgressedFileCount}/{e.TotalFileCount}");
}
void progressChanged(object? sender, ProgressChangedEventArgs e)
{
    Console.WriteLine($"{e.ProgressPercentage}%");
}

// CMLauncher 초기화
var path = new MinecraftPath(); // 기본 경로 사용
var launcher = new CMLauncher(path);
launcher.FileChanged += fileChanged;
launcher.ProgressChanged += progressChanged;

// MForge 초기화
var forge = new MForge(launcher);
forge.FileChanged += fileChanged;
forge.ProgressChanged += progressChanged;
forge.InstallerOutput += (s, e) => Console.WriteLine(e);

// 1.20.1 에서 가장 좋은 포지 버전 설치
var versionName = await forge.Install("1.20.1");

// 특정 포지 버전 설치
// var versionName = await forge.Install("1.20.1", "47.0.35");

// 게임 실행
var launchOption = new MLaunchOption
{
    MaximumRamMb = 1024,
    Session = MSession.GetOfflineSession("TaiogStudio"),
};

var process = await launcher.CreateProcessAsync(versionName, launchOption);
process.Start();
```

## 예시

[SampleForgeInstaller](https://github.com/CmlLib/CmlLib.Core.Installer.Forge/blob/main/SampleForgeInstaller/Program.cs)
