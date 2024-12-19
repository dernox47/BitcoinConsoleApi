import 'dart:io';

import 'package:bitcoin_console_api/classes/file_handler.dart';
import 'package:bitcoin_console_api/classes/user.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';


List<User> users = FileHandler('users.json').getDataFromJson();
late User selectedUser;

String inputCheck(String inputText) {
  String variable;
  do {
    stdout.write(inputText);
    variable = stdin.readLineSync()!;
  } while (variable == "");
  return variable;
}

void loginFrame() {
  print('Login');
  String? usernameInput = inputCheck('\tEnter your username: ').toLowerCase();
  var findUser = users.firstWhereOrNull((x) => x.username == usernameInput);

  if (findUser == null) {
    do {
      print('User with this username does not exist.');
      usernameInput = inputCheck('\tEnter your username: ').toLowerCase();
    } while (findUser == null);
  }
  String? passwordInput = inputCheck('\tEnter your password: ');
  var correctPassword = findUser.password;

  if (correctPassword != passwordInput) {
    do {
      print('Incorrect password.');
      passwordInput = inputCheck('\tEnter your password: ');
    } while (correctPassword != passwordInput);
  }
  selectedUser = findUser;
}

void main() {
  bool appRunning = true;
  bool authTypeWaiting = true;
  while (appRunning) {
    while (authTypeWaiting) {
      stdout.write('Login or register? (l/r): ');
      String authType = stdin.readLineSync()!.toLowerCase();
      switch (authType) {
        // Login
        case 'l':
          loginFrame();

          authTypeWaiting = false;
          break;
        // Registration
        case 'r':
          print('Enter registration informations');
          String usernameInput = inputCheck('\tUsername: ');
          String nameInput = inputCheck('\tName: ');

          // Date format check
          String dateOfBirthInput =
              inputCheck('\tDate of birth (1999-01-01): ');
          bool correctFormat =
              DateFormat('yyyy-MM-dd').tryParseStrict(dateOfBirthInput) != null;
          if (!correctFormat) {
            do {
              print('Wrong date format!');
              dateOfBirthInput = inputCheck('\tDate of birth (1999-01-01): ');
              correctFormat =
                  DateFormat('yyyy-MM-dd').tryParseStrict(dateOfBirthInput) !=
                      null;
            } while (!correctFormat);
          }

          String passwordInput = inputCheck('\tPassword: ');
          var nextId = users.sortedBy((x) => x.id.toString()).last.id + 1;
          User user1 = User(
            id: nextId,
            name: nameInput,
            dateOfBirth: dateOfBirthInput,
            role: 'user',
            username: usernameInput,
            password: passwordInput
          );

          if (user1.age() < 18) {
            print('The age requirement is 18.');
            break;
          } else {
            users.add(user1);
            FileHandler('users.json').loadDataToJson(users);
          }

          loginFrame();

          authTypeWaiting = false;
          break;
        default:
          print('Enter one of the options!');
      }
    }
    print("\x1B[2J\x1B[0;0H");
    print('Welcome ${selectedUser.name}!\n'
          '(${selectedUser.age()} years old)');
    break;
  }
}
