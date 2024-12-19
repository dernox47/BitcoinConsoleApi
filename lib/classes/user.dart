import 'package:intl/intl.dart';

class User {
  final int? _id;
  String? _name;
  String? _dateOfBirth;
  String? _role;
  int? _money;

  int get id => _id!;

  String get name => _name!;
  set name(String v) {
    _name = v;
  }

  String get dateOfBirth => _dateOfBirth!;
  set dateOfBirth(String v) {
    _dateOfBirth = v;
  }

  String get role => _role!;
  set role(String v) {
    _role = v;
  }

  int get money => _money!;
  set money(int v) {
    v < 0 ? _money = 0 : _money = v;
  }

  User(this._id, this._name, this._dateOfBirth, this._role, this._money);

  int age() {
    return DateTime.now().year - DateFormat.yMd().parse(_dateOfBirth!).year;
  }

  @override
  String toString() {
    return 
      'id: $id\n' 
      'name: $name\n'
      'dateOfBirth: $dateOfBirth\n'
      'age: $age()\n'
      'role: $role\n'
      'money: $money';
  }
}
