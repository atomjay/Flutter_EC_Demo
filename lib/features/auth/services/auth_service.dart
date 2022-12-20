import 'dart:convert';
import 'package:ec/constants/error_handling.dart';
import 'package:ec/constants/global_variables.dart';
import 'package:ec/constants/utils.dart';
import 'package:ec/features/home/screen/home_screen.dart';
import 'package:ec/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ec/providers/user_provider.dart';

class AuthService {
  // sign up user
  void signUpUser({
    required String email,
    required String password,
    required String name,
    required BuildContext context,
  }) async {
    try {
      User user = User(
          id: '',
          name: name,
          email: email,
          password: password,
          address: '',
          type: '',
          token: '');

      http.Response res = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(),
        //因後端使用 express.json(), headers 增加如下
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );
      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () {
          showSnackBar(context, '帳戶建立完成');
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // sign in user
  void signInUser({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/api/signin'),
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
        //因後端使用 express.json(), headers 增加如下
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
        },
      );

      httpErrorHandle(
        response: res,
        context: context,
        onSuccess: () async {
          SharedPreferences prefs = await SharedPreferences.getInstance();
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          //將 jwt 的 token 存在全局變舉中
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          print(res.body);
          Navigator.pushNamedAndRemoveUntil(
            context,
            HomeScreen.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
