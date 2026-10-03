# ClientID

Для використання MSAL вам потрібно отримати власний Azure Client ID. У цьому документі описано, як отримати власний Azure Client ID для автентифікації Xbox.

## 1. Перехід до Azure Active Directory

Відкрийте [Azure Portal](https://portal.azure.com/) та знайдіть меню **Azure Active Directory**.

![image](https://user-images.githubusercontent.com/17783561/154854882-79918bb0-f317-4ab8-aac9-4b51f4086be9.png)

## 2. Реєстрація застосунку (App registration)

Додати — Реєстрація застосунку (**App Registration**)

![image](https://user-images.githubusercontent.com/17783561/154855003-4f5fc4ea-7083-47f9-818d-72216a548c27.png)

* **Назва (Name):** назва вашого застосунку  
* **Тип облікового запису (Account type):** Облікові записи в будь-якому організаційному каталозі (Будь-який каталог Azure AD — Багатоорендний) та особисті облікові записи Microsoft (наприклад, Skype, Xbox)  
* **URI перенаправлення (Redirect URI):** Public client/native, `http://localhost`

![image](https://user-images.githubusercontent.com/17783561/154855171-2198b328-9457-46e3-89b8-b1e295bfb5bd.png)

Натисніть кнопку **Register** (Зареєструвати).

## 3. Управління автентифікацією (Authentication manage)

Перейдіть до **App registrations** — назва вашого застосунку

![image](https://user-images.githubusercontent.com/17783561/154855363-17386531-4fb6-4fa3-aab2-3dc1ed954d48.png)

**На цьому екрані ви можете отримати Application (Client) ID**  
Натисніть **Redirect URIs**

![image](https://user-images.githubusercontent.com/17783561/154855473-19713858-8c6e-49f0-ab13-51c33fc245fb.png)

Додайте **Msal Only**

![image](https://user-images.githubusercontent.com/17783561/154855535-6b1abe22-a310-4038-89ad-b5c1cc006327.png)

Прокрутіть вниз та увімкніть **Allow public client flows** (Дозволити потоки публічних клієнтів)

![image](https://user-images.githubusercontent.com/17783561/154855569-e5e8441e-30ad-4930-af5d-5e790ad9e1ce.png)

Натисніть кнопку **Save** (Зберегти).

## 4. Реєстрація Client ID

Після створення застосунку в Azure вам необхідно внести свій Client ID до білого списку (allowlist), щоб запобігти виникненню помилок `403: FORBIDDEN` від API автентифікації Minecraft. Дотримуйтесь інструкцій в офіційній довідковій статті Minecraft, щоб переконатися, що ваш застосунок розпізнається:

https://help.minecraft.net/hc/en-us/articles/16254801392141

https://github.com/CmlLib/CmlLib.Core.Auth.Microsoft/issues/16
