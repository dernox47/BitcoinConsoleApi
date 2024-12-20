import 'dart:convert';
import 'dart:io';

import 'package:bitcoin_console_api/classes/user.dart';

class FileHandler {
  late File file;

  FileHandler(String fileName) {
    file = File(fileName);
  }

  Future<List<User>> getDataFromJson() async {
    return await Future.delayed(Duration(seconds: 2), () {
      List<dynamic> data = jsonDecode(file.readAsStringSync());
      List<User> users = data.map((data) => User.fromJson(data)).toList();
      return users;
    });
  }

  void loadDataToJson(List<User> list) {
    List<dynamic> data = list.map((x) => x.toJson()).toList();
    file.writeAsStringSync(jsonEncode(data));
  }
}
