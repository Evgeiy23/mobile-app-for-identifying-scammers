import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ignore: unused_local_variable
    final auth = Provider.of<AuthProvider>(context);

    return Scaffold(
      // AppBar удалён, чтобы оставить кнопку входа/регистрации только в main.dart
      body: Stack(
        children: [
          // Здесь остается основной контент главного экрана (новости, кнопка "Проверить сообщение на мошенничество" и т.д.)
        ],
      ),
    );
  }
}
