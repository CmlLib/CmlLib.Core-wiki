# MArgument

Various parameters set in the launcher (user information, game directory path, server address, etc.) are passed as an argument list when the game process is executed. The operating system passes this list to the process, separated by spaces.

Each argument string can have the following characteristics:

* It can have a key and value separated by `=` like `-key=value`, or a single value like `value`.
* It can contain `${template}` format that the launcher will replace with appropriate values, like `--key=${template}`.
* If `value` contains spaces, it is enclosed in quotes. (e.g., `--key="hello world"`, `"this value"`)

!!! info "Argument Separation"
    Arguments are basically separated by spaces, but spaces enclosed in quotes do not separate arguments.

    * `--username ${auth_player_name}`: These are **two arguments**: `--username` and `${auth_player_name}`.
    * `-Dminecraft.launcher.brand="hello world"`: This is **one argument** even though it contains spaces, because it's enclosed in quotes.

`MArgument` is a type that manages a list of such arguments. When initializing `MArgument`, each element must contain **only one argument**.

```csharp
// MArgument takes multiple individual arguments to create a list
var arguments = new MArgument(["--username", "${auth_player_name}", "-Dminecraft.launcher.brand=${launcher_name}"]);

var result = arguments.InterpolateValues(new Dictionary<string, string?>
{
    ["auth_player_name"] = "hello1234",
    ["launcher_name"] = "my launcher",
});
// result: "--username", "hello1234", "-Dminecraft.launcher.brand=\"my launcher\""
```

**Template Substitution**

CmlLib automatically substitutes `${template}` parts with actual values by calling the `InterpolateValues` method. If the substituted value contains spaces, it automatically adds quotes, so no additional processing is needed.

The following templates are provided by default. To register more templates, set the `ArgumentDictionary` in the launch options. See [MLaunchOption.md](../getting-started/MLaunchOption.md)

| Template Key            | Description                                                                                                      |
| ----------------------- | ------------------------------------------------------------------------------------------------------- |
| `library_directory`     | `launchOption.Path.Library`                                                                             |
| `natives_directory`     | `launchOption.NativesDirectory`                                                                         |
| `launcher_name`         | `launchOption.GameLauncherName`                                                                         |
| `launcher_version`      | `launchOption.GameLauncherVersion`                                                                      |
| `classpath_separator`   | Path separator (e.g., `;` or `:`)                                                                               |
| `classpath`             | `-cp`                                                                                                   |
| `auth_player_name`      | Username (`launchOption.Session.Username`)                                                                 |
| `version_name`          | Name of the version being launched                                                                                             |
| `game_directory`        | Game directory path (`launchOption.Path.BasePath`)                                                               |
| `assets_root`           | Assets directory path (`launchOption.Path.Assets`)                                                             |
| `assets_index_name`     | Asset version name                                                                                                |
| `auth_uuid`             | User UUID (`launchOption.Session.UUID`)                                                                   |
| `auth_access_token`     | User access token (`launchOption.Session.AccessToken`)                                                           |
| `user_properties`       | `launchOption.UserProperties`                                                                           |
| `auth_xuid`             | User XUID (`launchOption.Session.Xuid`)                                                                   |
| `clientid`              | `launchOption.ClientId`                                                                                 |
| `user_type`             | User type, `Mojang` for pre-migration Mojang accounts, `msa` for post-migration Microsoft accounts (`launchOption.Session.UserType`) |
| `game_assets`           | Legacy asset directory path (`launchOption.Path.GetAssetLegacyPath`)                                                  |
| `auth_session`          | User access token (`launchOption.Session.AccessToken`)                                                           |
| `version_type`          | `launchOption.VersionType`                                                                              |
| `resolution_width`      | `launchOption.ScreenWidth`                                                                              |
| `resolution_height`     | `launchOption.ScreenHeight`                                                                             |
| `quickPlayPath`         | `launchOption.QuickPlayPath`                                                                            |
| `quickPlaySingleplayer` | `launchOption.QuickPlaySingleplayer`                                                                    |
| `quickPlayMultiplayer`  | `launchOption.ServerIp, launchOption.ServerPort`                                                        |
| `quickPlayRealms`       | `launchOption.QuickPlayRealms`                                                                          |

**Conditional Arguments (Rules)**

`MArgument` can have `Rules` to activate arguments only in specific environments. For example, the `-XstartOnFirstThread` argument has `Rules` set to only be added on macOS.

**Parsing Argument List from Single String**

`MArgument` must contain only one argument. If you input multiple arguments at once, it won't work properly.

```csharp
// Wrong usage!
var arguments = new MArgument("--username ${auth_player_name} -Dminecraft.launcher.brand=${launcher_name}");
```

Simply splitting a string by space characters (`string.Split(' ')`) cannot properly handle spaces enclosed in quotes.

```csharp
// Wrong method: using Split
var argumentsStr = "-Dos.name=\"Windows 10\" -version 1.0";
var splitArgs = argumentsStr.Split(' ');
// Wrong result: "-Dos.name=\"Windows", "10\"", "-version", "1.0"
```

In such cases, you should use the `FromCommandLine` method. This method parses strings according to command line rules and creates an `MArgument` object.

```csharp
// Correct method: using FromCommandLine
var argumentsStr = "-Dos.name=\"Windows 10\" --username \"hello 1234\"";
var arguments = MArgument.FromCommandLine(argumentsStr);
// Correct result: "-Dos.name=\"Windows 10\"", "--username", "hello 1234"
```
