import 'package:ec/constants/error_handling.dart';
import 'package:ec/constants/global_variables.dart';
import 'package:ec/constants/utils.dart';
import 'package:ec/models/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
}
