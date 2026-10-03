# Головна

![Discord](https://img.shields.io/discord/795952027443527690?label=discord&logo=discord&style=for-the-badge)

[GitHub](https://github.com/CmlLib/MojangAPI)

.NET бібліотека для [Mojang API](https://wiki.vg/Mojang_API), [Mojang Authentication](https://wiki.vg/Authentication) та [Microsoft Xbox Authentication](https://wiki.vg/Microsoft_Authentication_Scheme)

* Асинхронний API
* Отримання даних гравця
* Зміна нікнейму або скіна гравця
* Автентифікація Mojang
* Автентифікація Microsoft
* Відповіді на контрольні запитання (Security Question)
* Статистика

Підтримка:

* netstandard 2.0

## Встановлення

Використовуйте NuGet-пакет [MojangAPI](https://www.nuget.org/packages/MojangAPI)


```
dotnet add package MojangAPI
```

## Використання

Підключіть ці простори імен:

```csharp
using MojangAPI;
using MojangAPI.Model;
```

Приклад програми: [MojangAPISample](https://github.com/CmlLib/MojangAPI/tree/master/MojangAPISample)

### [Mojang API](mojang-api.md)

Отримання профілю гравця, зміна нікнейму або скіна, статистика, заблоковані сервери, перевірка наявності придбаної гри.

### [Контрольні запитання (SecurityQuestion)](securityquestion.md)

Процес відповідей на контрольні запитання.

### Автентифікація

Для автентифікації перегляньте розділ [Вхід та сесії](../cmllib.core/login-and-sessions/README.md) або використовуйте бібліотеку [CmlLib.Core.Auth.Microsoft](../auth.microsoft/cmllib.core.auth.microsoft/README.md).
