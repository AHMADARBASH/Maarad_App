import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  Future<void> login(String username, String password) async {
    final url = Uri.parse('http://82.137.255.183:3939/auth/jwt/create');
    Map userData = {"username": username, "password": password};
    final SharedPreferences prefs = await _prefs;
    try {
      final request = await http.post(url, body: userData);

      if (request.statusCode == 200) {
        final respone = json.decode(request.body);
        prefs.setString('Access', respone['access']);
        prefs.setString('Refresh', respone['refresh']);
      }
    } catch (e) {
      rethrow;
    }
  }

  void logout() async {
    final SharedPreferences prefs = await _prefs;
    prefs.clear();
  }
}
