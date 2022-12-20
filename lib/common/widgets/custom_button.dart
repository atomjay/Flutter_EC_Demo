// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final String btnText;
  final VoidCallback onTab;
  const CustomButton({
    Key? key,
    required this.btnText,
    required this.onTab,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
        onPressed: onTab,
        child: Text(
          btnText,
        ),
        style: ElevatedButton.styleFrom(
          minimumSize: Size(double.infinity, 50.0),
        ));
  }
}
