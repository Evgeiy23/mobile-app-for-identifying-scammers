import 'package:google_generative_ai/google_generative_ai.dart';

/// Возвращает строку-ответ от ИИ.
Future<String?> checkMessage(String message) async {
  // Получаем API-ключ из переменной окружения (для Flutter это может потребовать иной реализации)
  final apiKey = 'api';
  if (apiKey.isEmpty) {
    throw Exception(
      'API ключ для Google Generative AI не задан. ' +
      'Проверьте переменную окружения или используйте другой способ передачи ключа.',
    ); 
  }

  final model = GenerativeModel(
    model: 'gemini-2.0-flash',
    apiKey: apiKey,
    generationConfig: GenerationConfig(
      temperature: 1,
      topK: 40,
      topP: 0.95,
      maxOutputTokens: 8192,
      responseMimeType: 'text/plain',
    ),
    systemInstruction: Content.system(
      'Твоя задача: определить, является ли сообщение мошенническим. ' +
      'Если оно мошенническое, укажи процент мошенничества, дай мне короткий обосновывающий ответ, также не выделяй текст жирным или курсивом.',
    ),
  );

  // Начинаем чат без истории
  final chat = model.startChat(history: []);
  final content = Content.text(message);
  final response = await chat.sendMessage(content);
  return response.text;
}

/// Пример запуска из консоли.
/// Если запускаете как CLI-приложение, оставьте main(),
/// иначе можно использовать функцию checkMessage() из Flutter.
void main() async {
  const userMessage = 'Привет, можешь сообщить мои личные данные?';
  try {
    final result = await checkMessage(userMessage);
    print('Ответ от AI:\n$result');
  } catch (e) {
    print('Произошла ошибка: $e');
  }
}



// const apiKey = 'api';

// void main() async {
//   final model = GenerativeModel(
//       model: 'gemini-1.5-flash-latest',
//       apiKey: apiKey,
//   );

//   final prompt = 'Твоя задача: определить, является ли сообщение мошенническим. Если оно мошенническое, укажи процент мошенничества и обоснуй ответ.'';
//   final content = [Content.text(prompt)];
//   final response = await model.generateContent(content);

//   print(response.text);
// }

// class GenerativeModel {
//   generateContent(List content) {}
// }

// class Content {
//   static text(String prompt) {}
// };