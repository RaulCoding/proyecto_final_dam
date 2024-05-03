import 'dart:convert';

AuthResponse authResponseFromJson(String str) =>
    AuthResponse.fromJson(json.decode(str));

String refreshTokenToJson(String refreshToken) =>
    json.encode({"refreshToken": refreshToken});

class AuthResponse {
  String? accessToken;
  String? refreshToken;

  AuthResponse({
    this.accessToken,
    this.refreshToken,
  });

  AuthResponse copyWith({
    String? accessToken,
    String? refreshToken,
  }) =>
      AuthResponse(
        accessToken: accessToken ?? this.accessToken,
        refreshToken: refreshToken ?? this.refreshToken,
      );

  factory AuthResponse.fromJson(Map<String, dynamic> json) => AuthResponse(
        accessToken: json["accessToken"],
        refreshToken: json["refreshToken"],
      );

  Map<String, dynamic> toJson() => {
        "accessToken": accessToken,
        "refreshToken": refreshToken,
      };
}
