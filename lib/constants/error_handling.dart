import 'dart:convert';

import 'package:ec/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle({
  required http.Response response,
  required BuildContext context,
  required VoidCallback onSuccess, // VoidCallback 等於 Function()?
}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackBar(
        context,
        jsonDecode(response.body)['msg'], // 後端錯誤message 的 key值為 msg
      );
      break;
    case 500:
      showSnackBar(
        context,
        jsonDecode(response.body)['error'],
      );
      break;

    default:
      showSnackBar(
        context,
        jsonDecode(response.body),
      );
      break;
  }
}
