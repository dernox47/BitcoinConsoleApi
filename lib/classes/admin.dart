import 'package:bitcoin_console_api/classes/user.dart';

class Admin extends User {
  Admin(
      {required super.id,
      required super.name,
      required super.dateOfBirth,
      required super.role,
      required super.username,
      required super.password});
}
