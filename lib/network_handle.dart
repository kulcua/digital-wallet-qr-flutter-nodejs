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

  Future<http.Response> post(String url, Map<String, dynamic> body) async {
    url = formater(url);
    log.d(body);
    var response = await http.post(
      url,
      headers: {"Content-type": "application/json"},
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> patch(String url, Map<String, int> body) async {
    url = formater(url);
    log.d(body);
    var response = await http.patch(
      url,
      headers: {"Content-type": "application/json"},
      body: json.encode(body),
    );
    return response;
  }

  Future<http.Response> delete(String url, String id) async {
    url = formater(url);
    var response = await http.delete(
      '$baseurl/delete/$id',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
    );
    return response;
  }

  Future<User> getUser(String phone) async {
    final response = await http.get(
      '$baseurl/user/$phone',
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      print(response.statusCode);
      print(response.body);
      return User.fromJson(json.decode(response.body));
    } else {
      print(response.statusCode);
      throw Exception("Error");
    }
  }

  Future<User> getUserwithId(String id) async {
    final response = await http.get(
      '$baseurl/user/id/$id',
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
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
