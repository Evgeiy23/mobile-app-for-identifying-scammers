import 'package:flutter/material.dart';
import '../models/user.dart';
import '../fake_database.dart';
import '../services/email_service.dart';

class AuthProvider extends ChangeNotifier {
  bool _isLoggedIn = false;
  bool _isAdmin = false;
  
  // Данные о пользователе
  User? _currentUser;
  int _nextUserId = 1; // ID для новых пользователей

  bool get isLoggedIn => _isLoggedIn;
  bool get isAdmin => _isAdmin;
  String get username => _currentUser?.nickname ?? '';
  User? get currentUser => _currentUser;

  /// Регистрация нового пользователя. Возвращает true, если регистрация прошла успешно.
  Future<bool> register({
    required String email,
    required String password,
    required String firstName,
    required String lastName,
    required String nickname,
  }) async {
    // Проверяем, существует ли пользователь с таким email
    if (FakeDatabase.findByLogin(email) != null) {
      return false; // Пользователь уже существует
    }
    
    // Создаем нового пользователя
    final newUser = User(
      id: _nextUserId++,
      firstName: firstName,
      lastName: lastName,
      nickname: nickname.isNotEmpty ? nickname : email,
      email: email,
      password: password,
    );
    
    // Добавляем пользователя в базу данных
    FakeDatabase.addUser(newUser);
    
    // Устанавливаем текущего пользователя
    _currentUser = newUser;
    _isLoggedIn = true;
    notifyListeners();
    
    // Отправляем уведомление на почту пользователя
    _sendRegistrationEmail(email, firstName);
    
    return true;
  }

  /// Логин пользователя. Возвращает true, если логин успешен.
  Future<bool> login(String email, String password) async {
    // Ищем пользователя в базе данных
    final user = FakeDatabase.findByLogin(email);
    
    // Проверяем пароль
    if (user != null && user.password == password) {
      _currentUser = user;
      _isLoggedIn = true;
      _isAdmin = user.isAdmin;
      notifyListeners();
      return true;
    } else {
      return false;
    }
  }

  /// Выход из аккаунта
  Future<void> logout() async {
    _isLoggedIn = false;
    _isAdmin = false;
    _currentUser = null;
    notifyListeners();
  }

  /// Установить пользователя как админа
  void makeAdmin() {
    if (_currentUser != null) {
      _currentUser!.isAdmin = true;
      _isAdmin = true;
      notifyListeners();
    }
  }

  /// Обновление никнейма пользователя
  Future<bool> updateNickname(String newNickname) async {
    try {
      if (_currentUser != null && newNickname.isNotEmpty) {
        _currentUser!.nickname = newNickname;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
  
  /// Обновление имени пользователя
  Future<bool> updateName(String firstName, String lastName) async {
    try {
      if (_currentUser != null) {
        _currentUser!.firstName = firstName;
        _currentUser!.lastName = lastName;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
  
  /// Обновление пароля пользователя
  Future<bool> updatePassword(String oldPassword, String newPassword) async {
    try {
      if (_currentUser != null && _currentUser!.password == oldPassword) {
        _currentUser!.password = newPassword;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
  
  /// Обновление аватара пользователя
  Future<bool> updateAvatar(String avatarUrl) async {
    try {
      if (_currentUser != null) {
        _currentUser!.avatarUrl = avatarUrl;
        notifyListeners();
        return true;
      }
      return false;
    } catch (e) {
      return false;
    }
  }
  
  /// Отправка уведомления о регистрации на почту пользователя
  Future<void> _sendRegistrationEmail(String email, String firstName) async {
    try {
      await EmailService.sendRegistrationConfirmation(email, firstName);
    } catch (e) {
      print('Ошибка при отправке уведомления о регистрации: $e');
    }
  }
}
