# MLogin and MSession
You can get minecraft session by logining into mojang auth server. You can also create offline session.  
This document describe how to get or create minecraft session using CmlLib.Core. 

`MLogin` class provides methods to communicate with the mojang auth server.  
`MSession` class represents minecraft session data, containing `Username`, `UUID`, `AccessToken`. 

You have to set [MLaunchOption.Session](https://github.com/AlphaBs/CmlLib.Core/wiki/MLaunchOption#session) property to `MSession` instance.

## Example

[PremiumLogin() in CmlLibCoreSample](https://github.com/AlphaBs/CmlLib.Core/blob/master/CmlLibCoreSample/Program.cs)

            MSession session;
            var login = new MLogin();

            // TryAutoLogin() read login cache file and check validation.
            // if cached session is invalid, it refresh session automatically.
            // but refreshing session doesn't always succeed, so you have to handle this.
            Console.WriteLine("Try Auto login");
            session = login.TryAutoLogin();

            if (session.Result != MLoginResult.Success) // if cached session is invalid and failed to refresh token
            {
                Console.WriteLine("Auto login failed : {0}", session.Result.ToString());

                Console.WriteLine("Input mojang email : ");
                var email = Console.ReadLine();
                Console.WriteLine("Input mojang password : ");
                var pw = Console.ReadLine();

                session = login.Authenticate(email, pw);

                if (session.Result != MLoginResult.Success)
                {
                    // session.Message contains detailed error message. it can be null or empty string.
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

## MSession

Represents minecraft session. 

### Constructor

#### public MSession()

Create empty session

#### public MSession(string username, string accesstoken, string uuid)

Create MSession with Username, AccessToken, UUID property.

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

Login Result. If this property is not `MLoginResult.Success`, `Username`, `AccessToken`, and `UUID` is empty string.

#### Message
*Type: string*

Error message. It is set when `Result` property is not `MLoginResult.Success`. This property can be empty or null string even login result is not successful.

### Methods


## MLoginResult

Indicates Login Result

### Fields

#### Success

Success to login

#### BadRequest

#### WrongAccount

#### NeedLogin

#### UnknownError
