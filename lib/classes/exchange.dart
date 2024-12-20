import 'package:bitcoin_console_api/classes/user.dart';

class Exchange {
  User user;

  Exchange({required this.user});

  void buy(double currentPrice, double amount) {
    double totalPrice = currentPrice * amount;
    if (user.balance['USD']! >= totalPrice) {
      user.balance['USD'] = user.balance['USD']! - totalPrice;
      user.balance['BTC'] = user.balance['BTC']! + amount;
    } 
    else {
      print('Not enough USD');
    }
  }

  void sell(double currentPrice, double amount) {
    double totalPrice = currentPrice * amount;
    if (user.balance['BTC']! >= amount) {
      user.balance['BTC'] = user.balance['BTC']! - amount;
      user.balance['USD'] = user.balance['USD']! + totalPrice;
    }
    else {
      print('Not enough BTC');
    }
  }
}