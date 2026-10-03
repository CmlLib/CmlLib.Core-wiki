---
description: Надає основу для автентифікації в іграх Xbox
---

# XboxAuthNet.Game

Бібліотека надає спільний функціонал для автентифікації в іграх Xbox, включаючи Microsoft OAuth, автентифікацію Xbox та управління обліковими записами.

Наприклад, спільний функціонал [CmlLib.Core.Auth.Microsoft](../cmllib.core.auth.microsoft/README.md) для входу в Minecraft Java Edition та [CmlLib.Core.Bedrock.Auth](../cmllib.core.bedrock.auth.md) для входу в Bedrock Edition реалізовано саме за допомогою цієї бібліотеки.

## Встановлення

Вам не потрібно встановлювати цей пакет вручну. `CmlLib.Core.Auth.Microsoft` залежить від цього пакета.

## Authenticator (Автентифікатор)

### [OAuth](oauth.md)

Забезпечує вхід через OAuth за допомогою облікового запису Microsoft.

### [XboxAuth](xboxauth.md)

Забезпечує автентифікацію Xbox за допомогою токена Microsoft OAuth.

### Розширення (Extensions)

Процес автентифікації розроблено легкорозширюваним: ви можете легко додавати нові автентифікатори та вільно змінювати їхній порядок.

Наприклад, існує бібліотека розширення для Microsoft OAuth з використанням бібліотеки MSAL — [xboxauthnet.game.msal](../xboxauthnet.game.msal/README.md).

## Account (Облікові записи)

### [AccountManager](accountmanager.md)

Управління списком облікових записів.

### [Accounts](accounts.md)

Управління кожним окремим обліковим записом.
