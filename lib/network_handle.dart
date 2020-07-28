import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

import 'models/user_model.dart';

class NetworkHandler {
  String baseurl = "http://e-wallet-qr.herokuapp.com";
  var log = Logger();

  Future<dynamic> get(String url) async {
    url = formater(url);
    // /user/register
    var response = await http.get(url);
    if (response.statusCode == 200 || response.statusCode == 201) {
      log.i(response.body);

      return json.decode(response.body);
    }
    log.i(response.body);
    log.i(response.statusCode);
  }

  Future<http.Response> post(String url, Map<String, String> body) async {
    url = formater(url);
    log.d(body);
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json"},
      body: json.encode(body),
    );
    return response;
  }

  Future<User> getUser(String phone) async {
    //print('$phone');
    //print("token ne $authToken");
    final response = await http.get(
      '$baseurl/user/$phone',
    );
    //headers: {'Authorization': 'Bearer' + authToken});

    if (response.statusCode == 200 || response.statusCode == 201) {
      // final parsed = User.fromJson(json.decode(response.body));
      print(response.statusCode);
      print(response.body);
      return User.fromJson(json.decode(response.body));
    } else {
      print(response.statusCode);
      throw Exception("Error");
    }
  }

  Future<User> getUserwithId(String id) async {
    //print('$phone');
    //print("token ne $authToken");
    final response = await http.get(
      '$baseurl/user/id/$id',
    );
    //headers: {'Authorization': 'Bearer' + authToken});

    if (response.statusCode == 200 || response.statusCode == 201) {
      // final parsed = User.fromJson(json.decode(response.body));
      print(response.statusCode);
      print(response.body);
      return User.fromJson(json.decode(response.body));
    } else {
      print(response.statusCode);
      throw Exception("Error");
    }
  }

  String formater(String url) {
    return baseurl + url;
  }
}
