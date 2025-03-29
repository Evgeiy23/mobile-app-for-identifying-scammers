import 'models/user.dart';

class FakeDatabase {
  // Список всех пользователей
  static final List<User> _users = [];
  static User? findByLogin(String login) {
    try {
      return _users.firstWhere((u) => u.email == login);
    } catch (e) {
      return null;
    }
  }

  static void addUser(User user) {
    _users.add(user);
  }

  static List<User> getAllUsers() {
    return List.unmodifiable(_users);
  }
}
