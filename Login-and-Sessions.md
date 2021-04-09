# MLogin and MSession

You can get Minecraft sessions by logging in to the Mojang auth server. You can also create offline sessions.  
This document describes how to get or create Minecraft sessions using CmlLib.Core.

The `MLogin` class provides methods to communicate with the Mojang auth server.  
The `MLoginResult` class represents login result. `MLogin` methods return this object.  
The `MSession` class represents Minecraft session data, containing `Username`, `UUID`, and `AccessToken`.

You have to set the [MLaunchOption.Session](https://github.com/CmlLib/CmlLib.Core/wiki/MLaunchOption#session) property to an `MSession` instance.

_Note: [this document](https://wiki.vg/Authentication) will help you to understand basic process of minecraft login._

## Example

The basic login process is:  
![img](https://github.com/CmlLib/CmlLib.Core-wiki/blob/master/img/login.png?raw=true)

[PremiumLogin() in CmlLibCoreSample](https://github.com/CmlLib/CmlLib.Core/blob/master/CmlLibCoreSample/Program.cs)

```csharp
var login = new MLogin();

// TryAutoLogin() reads the login cache file and check validation.
// If the cached session is invalid, it refreshes the session automatically.
// Refreshing the session doesn't always succeed, so you have to handle this.
Console.WriteLine("Attempting to automatically log in.");
var response = login.TryAutoLogin();

if (!response.IsSuccess) // if cached session is invalid and failed to refresh token
{
    Console.WriteLine("Auto login failed: {0}", response.Result.ToString());

    Console.WriteLine("Input your Mojang email: ");
    var email = Console.ReadLine();
    Console.WriteLine("Input your Mojang password: ");
    var pw = Console.ReadLine();

    response = login.Authenticate(email, pw);

    if (!response.IsSuccess)
    {
        // session.Message contains a detailed error message. It can be null or an empty string.
        Console.WriteLine("failed to login. {0} : {1}", response.Result.ToString(), response.ErrorMessage);
        Console.ReadLine();
        Environment.Exit(0);
    }
}

// The result Session
MSession session = response.Session;

// var launchOption = new MLaunchOption()
// {
//      Session = session,
//      // launch options
// };
```

---

You can also create offline session.  
but you can't connect to an online-mode server or realm with this session.

```csharp
MSession session = MSession.GetOfflineSession("player-username");
```

## MLogin

Provides methods to communicate with the Mojang auth server and cache game session.  
All methods return [MLoginResponse](#MLoginResponse). You can get the result of login and result session from `MLoginResponse`.  
This class fully implments [Yggdrasil authentication scheme](https://wiki.vg/Authentication).

### Constructor

#### public MLogin()

Initialize object with default login cache file path.
Default path : `Path.Combine(MinecraftPath.GetOSDefaultPath(), "logintoken.json")`

#### public MLogin(string sessionCacheFilePath)

Initializes object and sets `SessionCacheFilePath`.

### Properties

#### SessionCacheFilePath

_Type: string_

SessionCacheFilePath

#### SaveSession

Save session data to `SessionCacheFilePath` if this true.
Default value is true.

### Methods

#### public MSession ReadSessionCache()

Returns session from cache file.

#### public MLoginResponse Authenticate(string id, string pw)

Login with Mojang email and password, with cached clientToken.

#### public MLoginResponse Authenticate(string id, string pw, string clientToken)

Login with Mojang email and password.

#### public MLoginResponse TryAutoLogin()

Checks validation of cached session and refresh session if it is not valid session.

#### public MLoginResponse TryAutoLogin(MSession session)

Checks validation of the specified session and refresh session if it is not valid session.

#### public MLoginResponse Refresh()

Refresh session using cached session.

#### public MLoginResponse Refresh(MSession session)

Refresh the specified session.

#### public MLoginResponse Validate()

Validate session with cached session.

#### public MLoginResponse Validate(MSession session)

Validate the specified session.

#### public void DeleteTokenFile()

Delete cached session file. This is the easiest way to logout.

#### public bool Invalidate()

Logout with cached session file.

#### public bool Invalidate(MSession session)

Logout the specified session.

#### public bool Signout(string id, string pw)

Logout using Mojang email and password.

## MSession

Represents a Minecraft session.

### Constructor

#### public MSession()

Creates an empty session.

#### public MSession(string username, string accesstoken, string uuid)

Creates an MSession with the specified Username, AccessToken, and UUID properties.

### Properties

#### Username

_Type: string_

#### UUID

_Type: string_

#### AccessToken

_Type: string_

#### ClientToken

_Type: string_

### Methods

#### public bool CheckIsValid()

Return true if `Username`, `AccessToken`, `UUID` is not null or empty.

#### public static MSession GetOfflineSession(string username)

Creates a new MSession and returns it.
`Username=username`, `AccessToken="access_token"`, `UUID="user_uuid"`

## MLoginResponse

Indicates the login response.

### Properties

#### IsSuccess

_Type: bool_

Returns true if `Result` is `MLoginResult.Success`.

#### Result

_Type: [MLoginResult](#MLoginResult)_

Login Result. If this property is not `MLoginResult.Success`, then `Session` will be null.

#### Session

_Type: [MSession](#MSession)_

Result session.

#### ErrorMessage

_Type: string_

Error message. It is set when the `Result` property is not `MLoginResult.Success`. This property can be empty or a null string when the login result is not successful.

## MLoginResult

Indicates the login result.

### Fields

#### Success

Login successful.

#### BadRequest

#### WrongAccount

#### NeedLogin

#### UnknownError

#### NoProfile

User doesn't purchase minecraft.
