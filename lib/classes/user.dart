import 'package:bitcoin_console_api/enums.dart';
import 'package:intl/intl.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  // Properties
  int id;
  String name;
  String dateOfBirth;
  String username;
  String password;
  late Map<String, double> balance;
  late Role _role;

  // Getters
  Role get role => _role;

  // Setters
  set role(v) => v == 'user' ? _role = Role.user : _role = Role.admin;

  User({
    required this.id,
    required this.name,
    required this.dateOfBirth,
    required this.username,
    required this.password,
    required String role,
  }) {
    balance = {
      'USD': 0,
      'BTC': 0
    };
    this.role = role;
  }

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  Map<String, dynamic> toJson() => _$UserToJson(this);

  int age() {
    return DateTime.now().year -
        DateFormat('yyyy-MM-dd').parse(dateOfBirth).year;
  }

  @override
  String toString() {
    return 'id: $id\n'
        'name: $name\n'
        'dateOfBirth: $dateOfBirth\n'
        'age: ${age()}\n'
        'role: $role\n'
        'money: $balance\n'
        'username: $username\n'
        'password: $password';
  }
}
