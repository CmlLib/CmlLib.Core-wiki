# 로그인과 세션

online-mode 서버에 접속하기 위해서는 플레이어의 세션 데이터를 얻어야 합니다. 세션 데이터는 플레이어의 유저이름, UUID, 엑세스토큰을 가지고 있습니다.

게임 세션을 얻기 위한 몇가지 방법이 있습니다:

* [Microsoft-Xbox-Live-Login.md](Microsoft-Xbox-Live-Login.md "mention")
* [Login-and-Sessions.md](Login-and-Sessions.md "mention")
* [undefined.md](undefined.md "mention")

세션을 얻은 후에는 `MLaunchOption.Session` 속성을 설정해야 합니다. [MLaunchOption.md](../undefined-1/MLaunchOption.md "mention")

## MSession API Refernces

<details>

<summary>Constructors</summary>

#### public MSession()

Creates an empty session.

#### public MSession(string username, string accesstoken, string uuid)

Creates an MSession with the specified Username, AccessToken, and UUID properties.

</details>

<details>

<summary>Properties</summary>

#### Username

_Type: string_

#### UUID

_Type: string_

#### AccessToken

_Type: string_

#### ClientToken

_Type: string_

</details>

<details>

<summary>Methods</summary>

#### public bool CheckIsValid()

Return true if `Username`, `AccessToken`, `UUID` is not null or empty.

#### public static MSession GetOfflineSession(string username)

Creates a new MSession and returns it. `Username=username`, `AccessToken="access_token"`, `UUID="user_uuid"`

</details>
