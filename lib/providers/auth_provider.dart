import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:maarad_app/models/http_Exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:jwt_decode/jwt_decode.dart';

class Auth with ChangeNotifier {
  String? _username;
  String? _token;
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  String? getToken() {
    return _token;
  }

  bool get isAuth {
    return _token != null;
  }

  void setUser(String user) {
    _username = user;
  }

  Future<String?> get userName async {
    final prefs = await _prefs;
    _username = prefs.getString('UserName');
    return _username;
  }

  Future<void> login(String username, String password) async {
    final url = Uri.parse('http://82.137.255.183:3939/auth/jwt/create');
    Map userData = {"username": username, "password": password};
    final SharedPreferences prefs = await _prefs;
    try {
      final request = await http.post(url, body: userData);
      if (request.statusCode != 200) {
        final response = json.decode(request.body);
        if (response.toString().contains('detail')) {
          throw HTTPException(message: 'Please Check your credentials');
        }
      } else {
        final respone = json.decode(request.body);
        prefs.setString('Access', respone['access']);
        prefs.setString('Refresh', respone['refresh']);
        prefs.setString('UserName', username);
        _token = prefs.getString('Access');
        notifyListeners();
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> signup(String username, String password) async {
    final url = Uri.parse('http://82.137.255.183:3939/auth/users/');
    Map userData = {"username": username, "password": password};
    try {
      final request = await http.post(url, body: userData);
      if (request.statusCode > 201) {
        final response = json.decode(request.body);

        if (response['username'] != null) {
          throw HTTPException(message: 'Username already exist!');
        } else if (response['password'] != null) {
          throw HTTPException(message: 'password must be complex');
        }
      }
    } catch (e) {
      rethrow;
    }
  }

  Future<void> logout() async {
    final prefs = await _prefs;
    await prefs.clear();
    _token = null;
    _username = null;
    notifyListeners();
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('Access')) {
      return false;
    }
    final jwtinfo = Jwt.parseJwt(prefs.getString('Access')!);
    final expireDate =
        DateTime.fromMillisecondsSinceEpoch(jwtinfo['exp'] * 1000);
    if (expireDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = prefs.getString('Access');
    notifyListeners();
    autoLogout();
    return true;
  }

  void autoLogout() async {
    Map<String, dynamic> jwtInfo = Jwt.parseJwt(_token!);
    var date = DateTime.fromMillisecondsSinceEpoch(jwtInfo['exp'] * 1000);
    final timetoExpire = date.difference(DateTime.now()).inSeconds;
    Timer(Duration(seconds: timetoExpire), logout);
  }
}
