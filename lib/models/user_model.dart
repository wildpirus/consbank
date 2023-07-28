import 'dart:convert';

User userFromJson(String str) => User.fromJson(json.decode(str) as Map<String, dynamic>);
String userToJson(User user) => json.encode(user.toJson());

class User {
  User({
    this.id,
    required this.email,
    required this.name,
    required this.idNumber,
    required this.password,
    this.registerDate,
  });

  int? id;
  final String name;
  final String email;
  final String idNumber;
  final String password;
  final String? registerDate;

  User copywith({
    int? id,
    String? name,
    String? email,
    String? idNumber,
    String? password,
    String? registerDate,
  }) =>
      User(
        id: id ?? this.id,
        name: name ?? this.name,
        email: email ?? this.email,
        idNumber: idNumber ?? this.idNumber,
        password: password ?? this.password,
        registerDate: registerDate ?? this.registerDate,
      );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'email': email,
      'name': name,
      'password': password,
      'registerDate': registerDate,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json["id"] is int || json["id"] == null ? json["id"] : int.parse(json["id"]),
      email: json["email"],
      name: json["name"],
      idNumber: json["idNumber"],
      password: json['password'],
      registerDate: json["registerDate"],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['name'] = name;
    data['idNumber'] = idNumber;
    data['password'] = password;
    data['registerDate'] = DateTime.now().toString();
    return data;
  }
}
