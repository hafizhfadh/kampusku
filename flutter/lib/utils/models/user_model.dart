import 'dart:convert';

class UserRequest {
  UserRequest({
    this.email,
    this.password,
  });

  String email;
  String password;

  factory UserRequest.fromRawJson(String str) =>
      UserRequest.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserRequest.fromJson(Map<String, dynamic> json) => UserRequest(
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "password": password,
      };
}

class UserResponse {
  UserResponse({
    this.id,
    this.name,
    this.email,
    this.createdAt,
    this.updatedAt,
    this.token,
  });

  int id;
  String name;
  String email;
  DateTime createdAt;
  DateTime updatedAt;
  String token;

  factory UserResponse.fromRawJson(String str) =>
      UserResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory UserResponse.fromJson(Map<String, dynamic> json) => UserResponse(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "token": token,
      };
}
