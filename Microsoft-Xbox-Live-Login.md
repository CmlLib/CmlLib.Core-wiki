# Microsoft Xbox Live Login

## Sample Project

[XboxLoginTest project](https://github.com/CmlLib/CmlLib.Core/tree/master/XboxLoginTest)

![img](https://github.com/CmlLib/CmlLib.Core-wiki/blob/master/img/XboxLoginTest.png?raw=true)

This project use additional library. [WebView2](https://docs.microsoft.com/en-us/microsoft-edge/webview2/) and [XboxAuthNet](https://github.com/AlphaBs/XboxAuthNet). You can get these libraries at nuget.  
But you don't have to download these libraries, because visual studio will install these library automatically when you build the project.

**Important !!!** You have to install [WebView2 Runtime](https://go.microsoft.com/fwlink/p/?LinkId=2124703) to run this project.

-----

이 프로젝트는 추가적인 라이브러리를 필요로 합니다. [WebView2](https://docs.microsoft.com/en-us/microsoft-edge/webview2/) 와 [XboxAuthNet](https://github.com/AlphaBs/XboxAuthNet) 를 이용하며 nuget 에서 이 라이브러리를 다운로드할 수 있습니다.   
프로젝트를 빌드하면 자동으로 위의 라이브러리가 설치됩니다.

**중요 !!!** 이 프로젝트를 실행하기 위해서는 [WebView2 Runtime](https://go.microsoft.com/fwlink/p/?LinkId=2124703) 을 설치해야 합니다.

## Microsoft / Xbox Live Login Process

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

