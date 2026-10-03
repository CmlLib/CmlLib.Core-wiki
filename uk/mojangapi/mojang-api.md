# Mojang API

Якщо запит провалюється, генерується відповідна помилка (exception). Наприклад, MojangException генерується, коли сервер Mojang повертає повідомлення про помилку.

## Як отримати `AccessToken` або `UUID`?

Ви можете отримати ці токени за допомогою автентифікації Mojang або Microsoft Xbox. Див. [Вхід та сесії](../cmllib.core/login-and-sessions/README.md).

```csharp
var session = await loginHandler.Authenticate();
var username = session.Username;
var uuid = session.UUID;
```

## Методи

### GetUUID

нікнейм -> uuid

```csharp
Mojang mojang = new Mojang(new HttpClient());
PlayerUUID uuid = await mojang.GetUUID("username");

// uuid.UUID
// uuid.IsLegacy
// uuid.IsDemo
```

### GetUUIDs

нікнейми -> uuids

```csharp
Mojang mojang = new Mojang(new HttpClient());
PlayerUUID[] uuids = await mojang.GetUUIDs(new string[] { "user1", "user2" });

foreach (PlayerUUID uuid in uuids)
{
    Console.WriteLine(uuid.UUID);
}
```

### GetNameHistories

_примітка: це API було визнано застарілим (deprecated) розробниками Mojang_

```csharp
Mojang mojang = new Mojang(new HttpClient());
NameHistory[] response = await mojang.GetNameHistories("uuid");

foreach (NameHistory item in response.Histories)
{
    // item.Name
    // item.ChangedToAt
    // item.ChangedTime
}
```

### GetProfileUsingUUID

```csharp
Mojang mojang = new Mojang(new HttpClient());
PlayerProfile profile = await mojang.GetProfileUsingUUID("uuid");

// profile.UUID
// profile.Name
// profile.Skin
// profile.IsLegacy
```

### GetProfileUsingAccessToken

_примітка: це API працює лише для акаунтів Xbox_

```csharp
Mojang mojang = new Mojang(new HttpClient());
PlayerProfile profile = await mojang.GetProfileUsingAccessToken("accessToken");
```

### GetPlayerAttributes

_примітка: це API працює лише для акаунтів Xbox_

```csharp
Mojang mojang = new Mojang(new HttpClient());
PlayerAttributes attributes = await mojang.GetPlayerAttributes("accessToken");

// attributes.Privileges.OnlineChat
// attributes.Privileges.MultiplayerServer
// attributes.Privileges.MultiplayerRealms
// attributes.Privileges.Telemtry
// attributes.ProfanityFilterPreferences.ProfanityFilterOn
```

### GetPlayerBlocklist

_примітка: це API працює лише для акаунтів Xbox_

```csharp
Mojang mojang = new Mojang(new HttpClient());
string[] blocklists = await mojang.GetPlayerBlocklist("accessToken");
```

### GetPlayerCertificates

_примітка: це API працює лише для акаунтів Xbox_

```csharp
Mojang mojang = new Mojang(new HttpClient());
PlayerCertificates certs = await mojang.GetPlayerCertificates("accessToken");

// certs.KeyPair.PrivateKey
// certs.KeyPair.PublicKey
// certs.PublicKeySignature
// certs.ExpiresAt
// certs.RefreshedAfter
```

### CheckNameAvailability

```csharp
Mojang mojang = new Mojang(new HttpClient());
string? result = await mojang.CheckNameAvailability("accessToken", "newName");
```

### ChangeName

_примітка: це API працює лише для акаунтів Xbox_

```csharp
Mojang mojang = new Mojang(new HttpClient());
PlayerProfile profile = await mojang.ChangeName("accessToken", "newName");
```

### ChangeSkin

_примітка: це API працює лише для акаунтів Xbox_

```csharp
Mojang mojang = new Mojang(new HttpClient());

// SkinType.Steve або SkinType.Alex
PlayerProfile response = await mojang.ChangeSkin("uuid", "accessToken", SkinType.Steve, "skinUrl");
```

### UploadSkin

_примітка: це API працює лише для акаунтів Xbox_

```csharp
Mojang mojang = new Mojang(new HttpClient());

// SkinType.Steve або SkinType.Alex
await mojang.UploadSkin("accessToken", SkinType.Steve, "skin_png_file_path");
```

```csharp
Mojang mojang = new Mojang(new HttpClient());
Stream stream; // створення потоку (stream) для завантаження скіна
await mojang.UploadSkin("accessToken", SkinType.Steve, stream, "file_name");
```

### ResetSkin

_примітка: це API працює лише для акаунтів Xbox_

```csharp
Mojang mojang = new Mojang(new HttpClient());
await mojang.ResetSkin("uuid", "accessToken");
```

### GetBlockedServer

```csharp
Mojang mojang = new Mojang(new HttpClient());
string[] servers = await mojang.GetBlockedServer();
```

### GetStatistics

_примітка: це API було видалено з підтримки Mojang_

```csharp
Mojang mojang = new Mojang(new HttpClient());
Statistics stats = await mojang.GetStatistics(
    StatisticOption.ItemSoldMinecraft,
    StatisticOption.ItemSoldCobalt
);

// stats.Total
// stats.Last24h
// stats.SaleVelocityPerSeconds
```

### CheckGameOwnership

_примітка 1: це API працює лише для акаунтів Xbox_  
_примітка 2: це API не перевіряє наявність підписки Xbox Game Pass. Якщо користувач має підписку Xbox Game Pass замість придбаної гри Minecraft, це API поверне `false`, хоча користувач має доступ до Minecraft і може в нього грати._

```csharp
Mojang mojang = new Mojang(new HttpClient());
bool result = await mojang.CheckGameOwnership("accessToken");

if (result)
    Console.WriteLine("У вас є Minecraft JE");
else
    Console.WriteLine("У вас немає Minecraft JE");
```
