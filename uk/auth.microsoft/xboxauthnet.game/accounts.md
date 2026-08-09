# Облікові записи

## ISessionStorage

Сесії зберігаються в `ISessionStorage` разом із різними токенами, отриманими під час процесу входу. Один обліковий запис зберігається в одному екземплярі `ISessionStorage`. Наприклад, коли користувач з ім'ям `Notch` входить у систему, він отримує токен Microsoft OAuth, токен Xbox та токен Minecraft JE. Усі три токени зберігатимуться в єдиному екземплярі `ISessionStorage`, який міститиме лише інформацію для входу, що стосується саме користувача `Notch`.

Існує три реалізації `ISessionStorage`: `InMemorySessionStorage`, яка зберігає всю інформацію в оперативній пам'яті; `JsonSessionStorage`, яка керує нею як об'єктом JSON у пам'яті; та `JsonFileSessionStorage`, яка керує нею у вигляді JSON-файлу.

### Приклад

```csharp
var sessionStorage = new InMemorySessionStorage();

// збереження даних
sessionStorage.Set<string>("myData", "HelloWorld");

// завантаження даних
var myData = sessionStorage.Get<string>("myData");

// збереження та завантаження даних через ISessionSource
var sessionSource = MicrosoftOAuthSessionSource.Default;
sessionSource.Set(sessionStorage, new MicrosoftOAuthResponse());
var oauth = sessionSource.Get(sessionStorage);
```

## XboxGameAccount

`XboxGameAccount` містить внутрішній екземпляр `ISessionStorage` та надає додаткову функціональність:

* Надає ідентифікатор для розрізнення між екземплярами `ISessionStorage`.
* Надає властивості для зручного доступу до інформації про сесію, що міститься в `ISessionStorage` (наприклад, `LastAccess`, `XboxTokens`).

### Identifier

Щоб управляти кількома обліковими записами, необхідно керувати кількома екземплярами `ISessionStorage`, для чого потрібен ідентифікатор, який дозволяє відрізнити кожен `ISessionStorage`.

Якщо два облікові записи мають однаковий ідентифікатор, вони вважаються одним і тим самим акаунтом, навіть якщо їхні `ISessionStorage` містять різні дані.

Наприклад, `JEGameAccount`, який представляє обліковий запис Minecraft Java Edition, використовує UUID користувача як ідентифікатор.

### LastAccess

Вказує на час останнього звернення (доступу) до цього облікового запису.

### XboxTokens

## Довідник API

- [JEGameAccount](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/CmlLib.Core.Auth.Microsoft.Sessions.JEGameAccount.html)
- [IXboxGameAccountManager](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/XboxAuthNet.Game.Accounts.IXboxGameAccountManager.html)
