import 'package:bitcoin_console_api/enums.dart';
import 'package:intl/intl.dart';

 class User {
  // Properties
  final int _id;
  String name;
  String dateOfBirth;
  late Role _role;
  late int _money;

  // Getters
  int get id => _id;
  Role get role => _role;
  int get money => _money;

  // Setters
  set role(v) => v == 'user' ? _role = Role.user : _role = Role.admin;
  set money(int v) => v < 0 ? _money = 0 : _money = v;

  User(this._id, this.name, this.dateOfBirth, String role, {int money = 0}) {
    this.role = role;
    _money = money;
  }

  int age() {
    return DateTime.now().year - DateFormat('yyyy-MM-dd').parse(dateOfBirth).year;
  }

  @override
  String toString() {
    return 
      'id: $id\n' 
      'name: $name\n'
      'dateOfBirth: $dateOfBirth\n'
      'age: ${age()}\n'
      'role: $role\n'
      'money: $money';
  }
}
