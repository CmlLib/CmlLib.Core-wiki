# MLogin and MSession
You can get Minecraft sessions by logging in to the Mojang auth server. You can also create offline sessions.  
This document describes how to get or create Minecraft sessions using CmlLib.Core. 

The `MLogin` class provides methods to communicate with the Mojang auth server.  
The `MSession` class represents Minecraft session data, containing `Username`, `UUID`, and `AccessToken`. 

You have to set the [MLaunchOption.Session](https://github.com/AlphaBs/CmlLib.Core/wiki/MLaunchOption#session) property to an `MSession` instance.

## Example

[PremiumLogin() in CmlLibCoreSample](https://github.com/AlphaBs/CmlLib.Core/blob/master/CmlLibCoreSample/Program.cs)

```csharp
MSession session;
var login = new MLogin();

// TryAutoLogin() reads the login cache file and check validation.
// If the cached session is invalid, it refreshes the session automatically.
// Refreshing the session doesn't always succeed, so you have to handle this.
Console.WriteLine("Attempting to automatically log in.");
session = login.TryAutoLogin();

if (session.Result != MLoginResult.Success) // if cached session is invalid and failed to refresh token
{
    Console.WriteLine("Auto login failed: {0}", session.Result.ToString());

    Console.WriteLine("Input your Mojang email: ");
    var email = Console.ReadLine();
    Console.WriteLine("Input your Mojang password: ");
    var pw = Console.ReadLine();

    session = login.Authenticate(email, pw);

    if (session.Result != MLoginResult.Success)
    {
        // session.Message contains a detailed error message. It can be null or an empty string.
        Console.WriteLine("failed to login. {0} : {1}", session.Result.ToString(), session.Message);
        Console.ReadLine();
        Environment.Exit(0);
        return null;
    }
}

// var launchOption = new MLaunchOption()
// {
//      Session = session,
//      // launch options
// };
```

## MSession

Represents a Minecraft session. 

### Constructor

#### public MSession()

Creates an empty session.

#### public MSession(string username, string accesstoken, string uuid)

Creates an MSession with the specified Username, AccessToken, and UUID properties.

### Properties

#### Username
*Type: string*

#### UUID
*Type: string*

#### AccessToken
*Type: string*

#### ClientToken
*Type: string*

#### Result
*Type: [MLoginResult](#MLoginResult)*

Login Result. If this property is not `MLoginResult.Success`, then `Username`, `AccessToken`, and `UUID` are empty strings.

#### Message
*Type: string*

Error message. It is set when the `Result` property is not `MLoginResult.Success`. This property can be empty or a null string when the login result is not successful.

### Methods

#### public bool CheckIsValid()
Checks to see if the current instance is valid.

#### public static MSession GetOfflineSession(string username)
Creates a new MSession and returns it. 
`Username=username`, `AccessToken="access_token"`, `UUID="user_uuid"`

## MLoginResult

Indicates the login result.

### Fields

#### Success

Login successful.

#### BadRequest

#### WrongAccount

#### NeedLogin

#### UnknownError
