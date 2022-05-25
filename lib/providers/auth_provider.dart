import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  Future<void> login(String username, String password) async {
    final url = Uri.parse('http://82.137.255.183:3939/auth/jwt/create');
    Map userData = {"username": username, "password": password};
    final request = await http.post(url, body: userData);

    if (request.statusCode == 200) {
      print(json.decode(request.body));
      var loginArr = json.decode(request.body);
      print(loginArr);
    } else {
      print("Login Error, Please Chcek your Credentials");
    }
  }
}
