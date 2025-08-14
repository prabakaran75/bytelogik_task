class UserModel {
  final int? userId;
  final String? userName;
  final String email;
  final String password;

  UserModel({
    this.userId,
    this.userName,
    required this.email,
    required this.password,
  });

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map["userId"],
      userName: map["userName"],
      email: map["email"],
      password: map["password"],
    );
  }

  Map<String, dynamic> toMap() => {
    "userId": userId,
    "userName": userName,
    "email": email,
    "password": password,
  };
}
