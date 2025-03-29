import 'package:antifraud_ai/screens/ai.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import 'package:flutter/services.dart';

// Импорт функции проверки сообщения из ai.dart.
// Замените путь на актуальный в вашем проекте.

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  
  // Вспомогательный метод для создания карточек новостей
  static Widget _buildNewsCard(String title, String content, IconData icon) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: Colors.deepPurple),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              content,
              style: const TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'ikonka.jpeg',
              height: 32,
              width: 32,
            ),
            const SizedBox(width: 8),
            const Text('Anti-Fraud AI'),
          ],
        ),
        centerTitle: true,
        actions: [
          // TextButton(
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) => const AboutFraudScreen(),
          //       ),
          //     );
          //   },
          //   child: const Text(''),
          // ),
        ],
      ),
      body: Stack(
        children: [
          // Фоновое изображение с градиентом
          Positioned.fill(
            child: Stack(
              children: [
                Opacity(
                  opacity: 0.15, // Прозрачность для лучшей читаемости текста
                  child: Image.asset(
                    'foto.png',
                    fit: BoxFit.cover,
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white.withOpacity(0.1),
                        const Color.fromARGB(255, 139, 35, 168).withOpacity(0.05),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          // Верхняя часть: кнопки профиля и админ-панели
          Align(
            alignment: Alignment.topLeft,
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (auth.isAdmin)
                    ElevatedButton(
                      onPressed: () => Navigator.pushNamed(context, '/admin'),
                      child: const Text('Admin Panel'),
                    ),
                ],
              ),
            ),
          ),
          // Центральный блок: новости
          Padding(
            padding: const EdgeInsets.only(top: 80.0, bottom: 80.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  // Заголовок новостей
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: const Row(
                      children: [
                        Icon(Icons.newspaper, color: Colors.deepPurple),
                        SizedBox(width: 8),
                        Text(
                          'Последние новости',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.deepPurple,
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Карточка новости 1
                  _buildNewsCard(
                    'Фишинг и социальная инженерия',
                    'Использование поддельных электронных писем, сайтов и мессенджеров для получения личных данных и финансовой информации.',
                    Icons.phishing,
                  ),
                  // Карточка новости 2
                  _buildNewsCard(
                    'Телефонное мошенничество',
                    'Звонки от «представителей» банков или госучреждений, требующие перевода средств или предоставления конфиденциальных данных.',
                    Icons.phone_android,
                  ),
                  // Карточка новости 3
                  _buildNewsCard(
                    'Мошенничество в онлайн-торговле',
                    'Фальшивые интернет-магазины и объявления в соцсетях, где после оплаты заказ не доставляют.',
                    Icons.shopping_cart,
                  ),
                  // Предупреждение
                  Container(
                    margin: const EdgeInsets.all(16),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.amber.shade100,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.amber.shade700),
                    ),
                    child: const Row(
                      children: [
                        Icon(Icons.warning_amber, color: Colors.amber),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Будьте бдительны! Всегда проверяйте информацию перед совершением финансовых операций.',
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Нижняя часть: кнопка для перехода к экрану проверки сообщения
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Colors.transparent,
                    Colors.white.withOpacity(0.9),
                  ],
                ),
              ),
              child: ElevatedButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const AIChatScreen()),
                  );
                },
                icon: const Icon(Icons.security),
                label: const Text('Проверить сообщение на мошенничество'),
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  backgroundColor: Colors.deepPurple,
                  foregroundColor: Colors.white,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Экран для проверки сообщения на мошенничество с использованием ИИ.
class AIChatScreen extends StatefulWidget {
  const AIChatScreen({super.key});

  @override
  State<AIChatScreen> createState() => _AIChatScreenState();
}

class _AIChatScreenState extends State<AIChatScreen> {
  final TextEditingController _controller = TextEditingController();
  bool _isLoading = false;
  String _aiResponse = '';

  Future<void> _onCheckMessage() async {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _isLoading = true;
      _aiResponse = '';
    });

    try {
      // Вызов функции проверки сообщения из ai.dart
      final result = await checkMessage(text);
      setState(() {
        _aiResponse = result!;
      });
    } catch (e) {
      setState(() {
        _aiResponse = 'Ошибка: $e';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Проверка сообщения'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              maxLines: 5,
              decoration: const InputDecoration(
                hintText: 'Введите сообщение для проверки...',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            _isLoading
                ? const CircularProgressIndicator()
                : ElevatedButton(
                    onPressed: _onCheckMessage,
                    child: const Text('Проверить'),
                  ),
            const SizedBox(height: 16),
            Expanded(
              child: SingleChildScrollView(
                child: Text(_aiResponse, style: const TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
