# Microsoft Xbox Live Login

## CmlLib.Core.Auth.Microsoft.UI

Microsoft login process is quite complex, so I created extern library.  
I **highly** recommend you to use this library to add Microsoft login feature in your launcher.

[CmlLib.Core.Auth.Microsoft.UI](https://github.com/CmlLib/CmlLib.Core.Auth.Microsoft.UI)

## Microsoft / Xbox Live Login Process

(You don't need to understand this if you are using [CmlLib.Core.Auth.Microsoft.UI](https://github.com/CmlLib/CmlLib.Core.Auth.Microsoft.UI))

Basic login process is described in [wiki.vg](https://wiki.vg/Microsoft_Authentication_Scheme).  

Login process is consists of three big part, Microsoft OAuth, Xbox Live authenticate, and Minecraft authenticate.  
`CmlLib.Core` does not provide methods about Microsoft OAuth and Xbox Live authenticate, it only provide Minecraft authenticate part. 

So, you have to use external library like [XboxAuthNet](https://github.com/AlphaBs/XboxAuthNet) to authenticate with Microsoft and Xbox Live.   
This library provide methods about Microsoft OAuth and Xbox Live authenticate, and you need **`uhs` (UserHash) and `xsts_token`**.

If you suceed to get `uhs` and `xsts_token`, follow next step to get minecraft session.

## Minecraft Login Process

1. Call [LoginWithXbox](https://github.com/CmlLib/CmlLib.Core/wiki/Microsoft-Xbox-Live-Login#LoginWithXbox) method using `uhs` and `xsts_token`. this method will return minecraft access token.
2. Call `CheckGameOwnership` using minecraft access token to check whether the user owns minecraft.
3. Call `GetProfileUsingToken`. using minecraft access token. this method will return `UUID` and `Username` of the user.
4. Create `MSession` instance using minecraft access token, `UUID`, and `Username`. Use this session when you launch the game.

*Note: `LoginWithXbox` method does not cache tokens. you have to implement it yourself.*

-----

## API Reference

### XboxMinecraftLogin class

#### LoginWithXbox

`public AuthenticationResponse LoginWithXbox(string uhs, string xstsToken)`  
Return [AuthenticationResponse](https://github.com/CmlLib/CmlLib.Core/wiki/Microsoft-Xbox-Live-Login#AuthenticationResponse%20class) instance including minecraft access token.

### AuthenticationResponse class

You need just two properties, `AccessToken` and `ExpiresOn`.

#### AccessToken

*Type: string*

Minecraft Access Token.

#### ExpiresOn

*Type: DateTime*

Represents the time the token expires.

#### Username

*Type: string*

*Note: this is not the uuid or username of the account*

#### Roles

*Type: string*

#### TokenType

*Type: string*

#### ExpiresIn

*Type: int*

