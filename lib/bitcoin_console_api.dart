import 'dart:io';

import 'package:bitcoin_console_api/classes/user.dart';
import 'package:bitcoin_console_api/enums.dart';

void main() {
  User user = User(1, 'asd', '1998-03-12', 'user');
  print('run');
  print(user);
  stdin.readLineSync();
}
