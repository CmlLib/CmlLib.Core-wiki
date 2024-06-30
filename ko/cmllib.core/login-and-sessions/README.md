# 로그인과 세션

online-mode 서버에 접속하기 위해서는 플레이어의 세션 데이터를 얻어야 합니다. 세션 데이터는 플레이어의 유저이름, UUID, 엑세스토큰을 가지고 있습니다.

게임 세션을 얻기 위한 몇가지 방법이 있습니다:

* [Microsoft-Xbox-Live-Login.md](Microsoft-Xbox-Live-Login.md "mention")
* [offline-account.md](offline-account.md "mention")

세션을 얻은 후에는 `MLaunchOption.Session` 속성을 설정해야 합니다. [#session](../getting-started/MLaunchOption.md#session "mention")
