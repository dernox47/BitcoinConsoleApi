import 'dart:io';

import 'package:bitcoin_console_api/classes/user.dart';
import 'package:intl/intl.dart';

List<User> users = [];
Map<String, String> loginCombinations = {};
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
  if (!loginCombinations.keys.contains(usernameInput)) {
    do {
      print('User with this username does not exist.');
      usernameInput = inputCheck('\tEnter your username: ').toLowerCase();
    } while (!loginCombinations.keys.contains(usernameInput));
  }
  String? passwordInput = inputCheck('\tEnter your password: ');
  if (loginCombinations[usernameInput] != passwordInput) {
    do {
      print('Incorrect password.');
      passwordInput = inputCheck('\tEnter your password: ');
    } while (loginCombinations[usernameInput] != passwordInput);
  }
  selectedUser = users.firstWhere((x) => x.username == usernameInput);
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

          User user1 = User(
            id: 0,
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
            loginCombinations[usernameInput] = passwordInput;
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
