import 'dart:io';
import 'dart:math';

import 'package:bitcoin_console_api/classes/bitcoin_api_handler.dart';
import 'package:bitcoin_console_api/classes/exchange.dart';
import 'package:bitcoin_console_api/classes/file_handler.dart';
import 'package:bitcoin_console_api/classes/user.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

late List<User> users;
late User selectedUser;

void main() async {
  users = await FileHandler('users.json').getDataFromJson();
  var currentData = await BitcoinApiHandler.getCurrentData();
  var currentBitcoinData = currentData['data'][0];

  bool appRunning = true;
  bool authTypeWaiting = true;

  while (appRunning) {
    while (authTypeWaiting) {
      stdout.write('Login or register? (l/r): ');
      String authType = stdin.readLineSync()!.toLowerCase();
      switch (authType) {
        // Login
        case 'l':
          selectedUser = loginFrame();

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
          User testUser = User(
              id: nextId,
              name: nameInput,
              dateOfBirth: dateOfBirthInput,
              role: 'user',
              username: usernameInput,
              password: passwordInput);

          if (testUser.age() < 18) {
            print('The age requirement is 18.');
            break;
          } else {
            users.add(testUser);
            FileHandler('users.json').loadDataToJson(users);
          }

          selectedUser = loginFrame();

          authTypeWaiting = false;
          break;
        default:
          print('Enter one of the options!');
      }
    }
    Exchange exchange = Exchange(user: selectedUser);
    var currentBitcoinPrice =
        truncateToDecimalPlaces(currentBitcoinData['quote']['USD']['price'], 2);

    clearConsole();
    print('Welcome ${selectedUser.name}!\n'
        '(${selectedUser.age()} years old)');

    print(DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()));

    print('Balance:\n'
          '${selectedUser.balance['USD']} USD\n'
          '${selectedUser.balance['BTC']} BTC');
    print('----------------------');
    print('Current ${currentBitcoinData['name']} pirce\t$currentBitcoinPrice USD');
    print('--------------');

    print('Actions: buy(b), sell(s), refresh price(r), quit(q)');
    var action = inputCheck('');
    switch (action) {
      case 'b':
        var amount = inputCheck('Enter the amount of BTC: ');
        exchange.buy(currentBitcoinPrice, double.parse(amount));
        break;
      case 's': 
        var amount = inputCheck('Enter the amount of BTC: ');
        exchange.sell(currentBitcoinPrice, double.parse(amount));
        break;
      case 'r':
        currentData = await BitcoinApiHandler.getCurrentData();
        currentBitcoinData = currentData['data'][0];
        currentBitcoinPrice = truncateToDecimalPlaces(
            currentBitcoinData['quote']['USD']['price'], 2);
        print(currentBitcoinPrice);
      default:
        print('Enter one of the options!');
    }
    
    

    break;
  }
}

String inputCheck(String inputText) {
  String variable;
  do {
    stdout.write(inputText);
    variable = stdin.readLineSync()!;
  } while (variable == "");
  return variable;
}

User loginFrame() {
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
  return findUser;
}

double truncateToDecimalPlaces(num value, int fractionalDigits) =>
    (value * pow(10, fractionalDigits)).truncate() / pow(10, fractionalDigits);

void clearConsole() => print("\x1B[2J\x1B[0;0H");
