# Rules

## RulesEvaluator

`IRulesEvaluator` 인터페이스는 주어진 규칙을 평가하여 특정 파일 또는 매개변수를 사용할지 여부를 결정합니다. 일부 매개변수나 파일은 특정 운영 체제(OS) 버전에서만 적용되거나 특정 기능이 활성화된 경우에만 사용 가능합니다.

### 예시

* **OS별 파일**: `lwjgl-windowsd`는 Windows에서만 활성화됩니다.
* **기능별 매개변수**: `--demo` 매개변수는 `is_demo_user` 기능이 활성화된 경우에만 사용됩니다.

게임 버전은 특정 기능이 활성화되어야 하는 환경을 명시하기 위해 `rules` 속성을 제공합니다.

### 기본 구현

`IRulesEvaluator`의 기본 구현체인 `RulesEvaluator`는 Mojang 런처의 구현과 동일하게 동작합니다. 대부분의 경우 이 구현체로 충분합니다.

다른동작이 필요한 경우, 사용자 정의 `IRulesEvaluator`를 구현할 수 있습니다. [minecraftlauncherparameters.md](minecraftlauncherparameters.md "mention") 에서 `IRulesEvaluator 를 바꿀 수 있습니다.`

### RulesEvaluatorContext

`RulesEvaluatorContext` 는 rules 를 평가하기 위해 필요한 현재 환경에 대한 정보를 나타냅니다. 여기에는 OS 종류, 버전, 아키텍쳐, 활성화된 feature 목록을 포함되어 있습니다.&#x20;

아래 코드는 현재 환경을 나타내는`RulesEvaluatorContext` 를 만듭니다.

```csharp
var context = new RulesEvaluatorContext(LauncherOSRule.Current, []);
```

만약 다른 환경을 만들려면 `RulesEvaluatorContext` 를 직접 초기화하면 됩니다.

```csharp
var context = new RulesEvaluatorContext(new LauncherOSRule("windows", "64", "10.0"), []);
```

만들어진 context 는 런처의 `RulesContext` 속성을 통해 설정할 수 있습니다.

```csharp
var launcher = new MinecraftLauncher();
launcher.RulesContext = new RulesEvaluatorContext(new LauncherOSRule("windows", "64", "10.0"), []);
```
