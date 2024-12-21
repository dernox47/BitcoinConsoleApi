import 'dart:convert';

import 'package:http/http.dart' as http;

class BitcoinApiHandler {
  static Uri url = Uri.parse('https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest');
  static Map<String, String> requestHeaders = {
    'Content-type': 'application/json',
    'X-CMC_PRO_API_KEY': 'ed27720a-6a74-4589-8e91-e4ba2bad5012'
  };

  static Future<Map<String, dynamic>> getCurrentData() async {
    try {
      final response = await http.get(url, headers: requestHeaders);
      final data = jsonDecode(response.body);
      return data;
    } catch (e) {
      throw e.toString();
    }
  }
}