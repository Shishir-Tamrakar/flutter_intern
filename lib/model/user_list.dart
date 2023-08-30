class User {
  int id;
  String username;
  String email;
  String password;
  User(
      {required this.id,
      required this.username,
      required this.email,
      required this.password});
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'password': password
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
    );
  }
}

// List<User> userList = [];
