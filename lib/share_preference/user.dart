import 'dart:convert';

class User {
  final int id;
  final String name;
  final int age;

  User({this.id, this.name, this.age});
  factory User.fromJson(Map<String, dynamic> json) =>
      User(id: json["id"], name: json["name"], age: json["age"]);
  Map<String, dynamic> toJson() => {"id": id, "name": name, "age": age};
  static String encodeUserList(List<User> users) => json.encode(
      users.map<Map<String, dynamic>>((user) => user.toJson()).toList());
  static List<User> decodeUserList(String userList) =>
      (json.decode(userList) as List<dynamic>)
          .map<User>((user) => User.fromJson(user))
          .toList();
}
