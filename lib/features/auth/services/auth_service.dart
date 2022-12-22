import 'dart:convert';
import 'package:ec/common/widgets/button_bar.dart';
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
          // Consumer 當 notifyListeners 被調用的時候，並不會使 widget 被重構。
          Provider.of<UserProvider>(context, listen: false).setUser(res.body);
          //將 jwt 的 token 存在全局變舉中
          await prefs.setString('x-auth-token', jsonDecode(res.body)['token']);
          //彈出新路由之前，刪除路由棧中的所有路由，
          //那可以使用這種寫法，(Route route) => false，
          //這樣能保證把之前所有的路由都進行刪除，然後才push新的路由
          Navigator.pushNamedAndRemoveUntil(
            context,
            BottomBar.routeName,
            (route) => false,
          );
        },
      );
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }

  // get user data
  void getUserData({
    required BuildContext context,
  }) async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String? token = prefs.getString('x-auth-token');

      if (token == null) {
        prefs.setString('x-auth-token', '');
      }

      var tokenRes = await http.post(
        Uri.parse('$uri/tokenIsValid'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=utf-8',
          'x-auth-token': token!
        },
      );

      var response = jsonDecode(tokenRes.body);

      if (response == true) {
        // get user data
        http.Response userResponse = await http.get(
          Uri.parse('$uri/'),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=utf-8',
            'x-auth-token': token
          },
        );

        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userResponse.body);
      }
    } catch (e) {
      showSnackBar(context, e.toString());
    }
  }
}
