# Контрольні запитання (SecurityQuestion)

Це необхідно для того, щоб ендпоінт зміни скіна працював у випадках, коли сервіси ще не довіряють вашій IP-адресі.

Більшість методів повертають `MojangAPIResponse` або клас, успадкований від `MojangAPIResponse`.  
Ви можете перевірити успішність виконання запиту за допомогою властивості `IsSuccess` у `MojangAPIResponse`.  
Якщо `IsSuccess` має значення `false`, властивості `Error` та `ErrorMessage` вкажуть на причину помилки.

Приклад:

```csharp
using MojangAPI.SecurityQuestion;

HttpClient httpClient = new HttpClient();
QuestionFlow questionFlow = new QuestionFlow(httpClient);

try
{
    await questionFlow.CheckTrusted("accessToken");
    Console.WriteLine("Вашу IP-адресу підтверджено");
}
catch
{
    QuestionList questions = await questionFlow.GetQuestionList("accessToken");
    for (int i = 0; i < questions.Count; i++)
    {
        Question question = questions[i];
        Console.WriteLine($"Q{i + 1}. [{question.QuestionId}] {question.QuestionMessage}");
        Console.Write("Відповідь? : ");

        var answer = Console.ReadLine();
        question.Answer = answer;
        Console.WriteLine();
    }

    await questionFlow.SendAnswers(questions, session.AccessToken);
    Console.WriteLine("Успішно");
}
```

## Методи (клас QuestionFlow)

### CheckTrusted

Перевіряє, чи потрібні запитання безпеки.

```csharp
try
{
    await questionFlow.CheckTrusted("accessToken");
    // IP підтверджено (запитання безпеки не потрібні)
}
catch 
{
    // потрібні запитання безпеки
}
```

### GetQuestionList

```csharp
QuestionList questionList = await questionFlow.GetQuestionList("accessToken");
foreach (Question q in questionList)
{
    // q.QuestionId
    // q.QuestionMessage
    // q.AnswerId
    // q.Answer
}
```

### SendAnswers

```csharp
QuestionList list; // цей список можна отримати з методу GetQuestionList, як змінну 'questionList' вище.
await questionFlow.SendAnswers(list, "accessToken");
```
