import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class EmailService {
  // Константы для настройки SMTP сервера
  static const String _smtpHost = 'smtp.yandex.ru';
  static const int _smtpPort = 465;
  static const String _username = 'unfraud.help@yandex.ru';
  static const String _password = 'admin1488LOX228_pidr_Chlen';
  
  // Метод для отправки уведомления о регистрации
  static Future<bool> sendRegistrationConfirmation(String recipientEmail, String recipientName) async {
    try {
      // Настройка SMTP сервера Яндекса
      final smtpServer = SmtpServer(
        _smtpHost,
        port: _smtpPort,
        ssl: true,
        username: _username,
        password: _password,
      );
      
      // Создание сообщения
      final message = Message()
        ..from = Address(_username, 'UnFraud AI')
        ..recipients.add(recipientEmail)
        ..subject = 'Спасибо за регистрацию в UnFraud AI'
        ..html = '''
        <h1>Здравствуйте, ${recipientName}!</h1>
        <p>Спасибо за регистрацию в нашем приложении UnFraud AI.</p>
        <p>Теперь вы можете использовать все возможности нашего сервиса для защиты от мошенничества.</p>
        <p>Если у вас возникнут вопросы, не стесняйтесь обращаться в службу поддержки.</p>
        <p>С уважением,<br>Команда UnFraud AI</p>
        ''';
      
      // Отправка сообщения
      final sendReport = await send(message, smtpServer);
      print('Сообщение отправлено: ${sendReport.toString()}');
      return true;
    } catch (e) {
      print('Ошибка при отправке email: $e');
      return false;
    }
  }
}