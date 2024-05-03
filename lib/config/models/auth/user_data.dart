import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

/// For Register User
String allUserDataToJson(UserData data) =>
    json.encode(data.allUserDataToJson());

/// For Login User
String loginDataToJson(UserData data) => json.encode(data.loginDataToJson());

class UserData {
  String? name;
  String? email;
  String? password;

  UserData({
    this.name,
    this.email,
    this.password,
  });

  UserData copyWith({
    String? name,
    String? email,
    String? password,
  }) =>
      UserData(
        name: name ?? this.name,
        email: email ?? this.email,
        password: password ?? this.password,
      );

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        name: json["name"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> allUserDataToJson() => {
        "name": name,
        "email": email,
        "password": password,
      };

  Map<String, dynamic> loginDataToJson() => {
        "email": email,
        "password": password,
      };
}
