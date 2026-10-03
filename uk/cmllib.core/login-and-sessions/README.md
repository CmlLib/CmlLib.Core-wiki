# Вхід та сесії

Щоб підключитися до сервера в онлайновому режимі (online-mode), вам потрібно отримати дані сесії гравця. Дані ігрової сесії містять ім'я користувача (username), UUID та accessToken гравця.

Існує кілька способів отримати ігрову сесію:

* [Обліковий запис Microsoft Xbox](Microsoft-Xbox-Live-Login.md)
* [Офлайн обліковий запис](offline-account.md)

Після отримання даних сесії вам слід встановити властивість `MLaunchOption.Session` в екземпляр `MSession`. [Параметри запуску](../getting-started/MLaunchOption.md)

# Довідник API

- [MSession](https://cmllib.github.io/CmlLib.Core.Commons/api/CmlLib.Core.Auth.MSession.html)
