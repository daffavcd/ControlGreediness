class UserModel {
  final String username;
  final String password;

  UserModel({
    required this.username,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      "username": username,
      "password": password,
    };
  }

  @override
  String toString() {
    return 'UserModel{username: $username, password: $password}';
  }
}
