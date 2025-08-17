# Login and Sessions

To connect to online-mode server, you should obtain player's session data. The game session data contains player's username, UUID, and accessToken.

There are some ways to obtain game session:

* [Microsoft-Xbox-Live-Login.md](Microsoft-Xbox-Live-Login.md)
* [offline-account.md](offline-account.md)

After obtaining a session data, you should set the `MLaunchOption.Session` property to an `MSession` instance. [Launch Options](../getting-started/MLaunchOption.md)

## MSession API References

??? abstract "Constructors"

    **public MSession()**

    Creates an empty session.

    **public MSession(string username, string accesstoken, string uuid)**

    Creates an MSession with the specified Username, AccessToken, and UUID properties.

??? abstract "Properties"

    **Username**

    *Type: string*

    **UUID**

    *Type: string*

    **AccessToken**

    *Type: string*

    **ClientToken**

    *Type: string*

??? abstract "Methods"

    **public bool CheckIsValid()**

    Return true if `Username`, `AccessToken`, `UUID` is not null or empty.

    **public static MSession GetOfflineSession(string username)**

    Creates a new MSession and returns it. `Username=username`, `AccessToken="access_token"`, `UUID="user_uuid"`
