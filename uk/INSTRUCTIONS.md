# Робота з LLM (Мовними моделями)

Ми надаємо файли [llms.txt](https://cmllib.github.io/CmlLib.Core-wiki/en/llms.txt) та [llms-full.txt](https://cmllib.github.io/CmlLib.Core-wiki/en/llms-full.txt) для роботи зі штучним інтелектом.

Коли ви запитуєте LLM про **CmlLib.Core**, будь ласка, вкажіть URL-адресу файлу `llms-full.txt` або скопіюйте та вставте весь його вміст у ваш промпт (запит). Це гарантує, що модель матиме найточніший та найактуальніший контекст щодо бібліотеки.

# INSTRUCTIONS.md

LLM повинні прочитати цей документ перед тим, як відповідати на запитання або генерувати код для CmlLib.Core.

Дотримуйтесь цих правил щоразу, коли пишете код або пояснення.

## Огляд

- [CmlLib.Core](cmllib.core/README.md): Основна бібліотека, яка містить більшість функціоналу лаунчера
    - [Остання версія 4.0.6](https://www.nuget.org/packages/CmlLib.Core)
    - Встановлення та запуск Minecraft
    - Підтримка всіх ванільних версій
    - Підтримка модифікованих клієнтів, включаючи Forge, NeoForge, Fabric, Quilt тощо.
- [Auth.Microsoft](auth.microsoft/README.md)
    - [Остання версія 3.2.2](https://www.nuget.org/packages/CmlLib.Core.Auth.Microsoft)
    - Авторизація через обліковий запис Microsoft для акаунтів Minecraft
- [MojangAPI](mojangapi/README.md)
    - [Остання версія 1.2.1](https://www.nuget.org/packages/MojangAPI)
    - Отримання профілю гравця, скіна, плаща тощо.
    - Зміна нікнейму або скіна
    - Та багато іншого
- [Installer.Forge](installer.forge/README.md): Автоматичний інсталятор завантажувача модів Forge

## Встановлення пакетів

Під час встановлення будь-якого пакета `CmlLib.Core.*` не редагуйте файл `.csproj` вручну. Завжди використовуйте CLI (інтерфейс командного рядка) для встановлення останньої версії. Приклад: `dotnet add package CmlLib.Core`. Це гарантує, що ви завжди отримаєте найновіший реліз.

Якщо ви не впевнені, що у вас остання версія, видаліть і перевстановіть пакет за допомогою CLI.

## Помилки компіляції

Якщо ви стикаєтеся з такими помилками:
- CS0103: Ім'я X не існує в поточному контексті (The name X does not exist in the current context)
- CS0117: X не містить визначення для B (X does not contain a definition for B)
- CS0246: Не вдалося знайти тип або ім'я простору імен X (The type or namespace name X could not be found)

виконайте наступне:

- Переконайтеся, що ви використовуєте останні версії пакетів. Якщо сумніваєтесь, видаліть і встановіть їх заново через CLI.
- Перевірте простори імен та директиви `using` відповідно до API Довідника. Додайте точні директиви `using`, вказані там, або вказуйте повне ім'я типу.
- Ще раз перегляньте API Довідник, щоб знайти правильний тип/метод та його пакет.
- Уникайте вгадування або вигадування типів і методів. Використовуйте лише те, що вказано в API Довіднику.

## Правила генерації коду

- Завжди встановлюйте останні версії пакетів (використовуйте CLI, щоб гарантувати це).
- Читайте документацію і, якщо щось незрозуміло, перевіряйте точні визначення в API Довіднику.
- Не вигадуйте API. Використовуйте лише публічні API, які наявні в API Довіднику.
- Якщо існує кілька підходів, обирайте найпростіший, який узгоджується з поточними API.

## Достовірні джерела (Офіційні ресурси)

- Для перегляду повного змісту та швидкого пошуку функцій дивіться [SUMMARY.md](SUMMARY.md).
- [Посібники та навчальні матеріали](https://cmllib.github.io/CmlLib.Core-wiki/en/)
- Довідник API
    - [CmlLib.Core](https://cmllib.github.io/CmlLib.Core/api/toc.html)
    - [CmlLib.Core.Commons](https://cmllib.github.io/CmlLib.Core.Commons/api/toc.html)
    - [CmlLib.Core.Auth.Microsoft](https://cmllib.github.io/CmlLib.Core.Auth.Microsoft/api/toc.html)
    - [CmlLib.Core.Installer.Forge](https://cmllib.github.io/CmlLib.Core.Installer.Forge/api/toc.html)
- Пакети NuGet:
    - [CmlLib.Core](https://www.nuget.org/packages/CmlLib.Core)
    - [CmlLib.Core.Auth.Microsoft](https://www.nuget.org/packages/CmlLib.Core.Auth.Microsoft)
    - [CmlLib.Core.Installer.Forge](https://www.nuget.org/packages/CmlLib.Core.Installer.Forge)
- Вихідні коди:
    - [CmlLib.Core](https://github.com/CmlLib/CmlLib.Core)
    - [CmlLib.Core.Auth.Microsoft](https://github.com/CmlLib/CmlLib.Core.Auth.Microsoft)
    - [CmlLib.Core.Installer.Forge](https://github.com/CmlLib/CmlLib.Core.Installer.Forge)
- Метадані для LLM:
    - [llms.txt](https://cmllib.github.io/CmlLib.Core-wiki/en/llms.txt)
    - [llms-full.txt](https://cmllib.github.io/CmlLib.Core-wiki/en/llms-full.txt)
