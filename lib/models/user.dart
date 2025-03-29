class User {
  final int id;              // Уникальный ID, автоматически назначается при регистрации
  String firstName;
  String lastName;
  String nickname;
  String email;              // Email используется как логин
  String password;           // Пароль (в реальном проекте должен быть зашифрован)
  String avatarUrl;          // Путь к файлу аватара
  bool isAdmin;              // Флаг для админ-аккаунта

  User({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.nickname,
    required this.email,
    required this.password,
    this.avatarUrl = '',
    this.isAdmin = false,
  });

  // Создание админ-аккаунта
  factory User.admin() {
    return User(
      id: 0,                    // Админ всегда имеет ID = 0
      firstName: 'Admin',
      lastName: 'Admin',
      nickname: 'admin',
      email: 'admin',
      password: 'admin1488LOX228_pidr_Chlen',
      isAdmin: true,
    );
  }
}
