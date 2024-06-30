# Rules

### RulesEvaluator

`IRulesEvaluator` 는 주어진 rules 를 평가하여 파일이나 파라미터를 사용해야 할 지 말아야 할 지 결정하는 역할을 합니다.

일부 파라미터나 파일은 특정 OS 버전이나 특정 feature 가 활성화된 상태에서만 사용됩니다. 예를 들어 윈도우용 네이티브 lwjgl 라이브러리는 윈도우에서만 사용되어야 합니다. 또 다른 예시로 `--demo` 파라미터는 `is_demo_user` feature 가 활성화된 경우에만 사용되어야 합니다. 게임 버전에서는 `rules` 프로퍼티를 제공하여 어떤 환경에서 기능이 활성화되어야 할 지 알려줍니다.

기본 구현체인 `IRulesEvaluator` 인 `RulesEvaluator` 는 모장 런처와 동일한 동작을 합니다. 대부분의 상황에서 이것만으로 충분합니다. 만약 다른 동작을 원한다면 `IRulesEvaluator` 를 직접 구현하세요.

기본값인 `RulesEvaluator` 가 아닌 다른 구현체를 사용하려면  [minecraftlauncherparameters.md](minecraftlauncherparameters.md "mention")의 [#rulesevaluator](minecraftlauncherparameters.md#rulesevaluator "mention")을 설정하세요.

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
