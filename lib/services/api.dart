import 'dart:convert';
import "package:http/http.dart" as http;
import 'package:moneymangement/models/user_model.dart';

class Api {
  final String _baseUrl = "http://e-wallet-qr.herokuapp.com";

  // Get Single Editor
  Future<User> getUser(String phone) async {
    print('$phone');
    final response = await http.post(
      '$_baseUrl/user/$phone',
      body: json.encode(
        {'username': '$phone'},
      ),
      headers: {'Content-Type': "application/json"},
    );
    if (response.statusCode == 200 || response.statusCode == 201) {
      final parsed = User.fromJson(json.decode(response.body));
      return parsed;
    } else {
      throw Exception("Error");
    }
  }
}
