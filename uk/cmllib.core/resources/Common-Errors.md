# Відомі проблеми

### Не завантажуються деякі текстури на екрані завантаження при використанні параметру `ServerIP`

* [\[БАГ\] Якщо вказати IP-адресу та порт сервера для автопідключення під час запуску, фон не завантажується в 1.16.5 OptiFine](https://github.com/CmlLib/CmlLib.Core/issues/93)
* Гра завершується з помилкою, пов'язаною з текстурами, на екрані завантаження «Connecting...» («Підключення...»).

На жаль, це баги самого Minecraft, і ми не можемо їх виправити.

### Заблокована кнопка «Мережева гра» (Multiplayer), відсутня автентифікація з Minecraft.net

Можливо, ваш обліковий запис Xbox блокує функції мережевої гри. Перевірте налаштування свого облікового запису. [Докладніше](https://support.xbox.com/ko-KR/help/family-online-safety/online-safety/manage-a-members-safety-settings-to-access-minecraft-features)

### Заблокована кнопка «Мережева гра» при офлайн-сесії у версіях 1.16.4 та 1.16.5

[https://github.com/CmlLib/CmlLib.Core/issues/85](https://github.com/CmlLib/CmlLib.Core/issues/85)

### Не вдається знайти версію `<назва_версії>`

Переконайтеся, що офіційний лаунчер Mojang бачит та успішно запускає вашу версію. CmlLib.Core не зможе знайти чи запустити версію, яку не бачить лаунчер Mojang.

Якщо ця виняткова ситуація (exception) виникає навіть тоді, коли потрібна версія є в директорії версій (за замовчуванням: `<Шлях до вашого Minecraft>/versions`), перевірте, чи назва директорії версії, назва json-файлу версії та властивість `id` є абсолютно однаковими.  
Наприклад, припустимо, що ви хочете запустити власну версію під назвою `myversion`. Ваш json-файл версії повинен знаходитися за шляхом `versions/myversion/myversion.json`, а властивість `id` у файлі `myversion.json` повинна мати значення `myversion`. Таким чином, назва директорії `myversion`, назва json-файлу `myversion.json` та значення властивості `id` `myversion` збігаються.

Якщо лаунчер все одно викликає цю помилку, викличте метод `launcher.GetAllVersionsAsync()` перед запуском `launcher.BuildProcess`.  
Якщо ви додаєте нову версію в директорію версій вже після ініціалізації лаунчера, вам слід оновити список версій за допомогою методу `GetAllVersionsAsync()`.

### Помилка: Could not create Java Virtual Machine

У 32-бітній JVM існує обмеження на `MaximumRamMb`.  
Рекомендоване значення `MaximumRamMb` для 32-бітної JVM становить `1024`.  
[Докладніше](https://stackoverflow.com/questions/1434779/maximum-java-heap-size-of-a-32-bit-jvm-on-a-64-bit-os/7019624#7019624)

### Помилка: Error: could not open jvm.cfg

Перевстановіть Java.  
Якщо ваш лаунчер використовує `MJava` або `JavaChecker`, видаліть директорію runtime (за замовчуванням: `<Шлях до вашого Minecraft>/runtime`) та встановіть Java знову.

### SRV-записи та `ServerIP`

Деякі версії Minecraft не можуть підключитися до сервера з SRV-записом під час використання функції прямого підключення (`MLaunchOption.ServerIP`).

### Не вдається отримати доступ до вікна Minecraft (macOS)

Вам необхідно вказати `DockName` та `DockIcon` у `MLaunchOption`. Якщо параметр `DockName` порожній, ви не зможете клікнути по вікну Minecraft або взаємодіяти з ним.

Приклад:

```csharp
var launchOption = new MLaunchOption
{
    MaximumRamMb = 1024,
    Session = session, 
    DockName = "Minecraft"
};
```

На macOS Catalina Minecraft працює нормально і без цих параметрів. На старіших версіях macOS виникають проблеми.

### Помилка середовища виконання Java з OpenJDK 11 (macOS)

Старі версії Minecraft не підтримують OpenJDK 11.

### Помилка середовища виконання Java з OpenJDK 11 (Linux)

Використовуйте Java 8. Старі версії Minecraft не підтримують OpenJDK 11.

Щоб встановити Java 8, виконайте в терміналі такі команды:

```bash
sudo apt-get update
sudo apt-get install openjdk-8-jre
```

Щоб переконатися, що все спрацювало, введіть `java -version`. Команда має повернути рядок `java version "1.8.0_~~~"`.
