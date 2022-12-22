import 'package:ec/features/account/widgets/account_button.dart';
import 'package:flutter/material.dart';

class TopButtons extends StatefulWidget {
  const TopButtons({super.key});

  @override
  State<TopButtons> createState() => _TopButtonsState();
}

class _TopButtonsState extends State<TopButtons> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            AccountButton(text: '您的訂單', onTap: () {}),
            AccountButton(text: '前往賣場', onTap: () {}),
          ],
        ),
        SizedBox(height: 10.0),
        Row(
          children: [
            AccountButton(text: '登出', onTap: () {}),
            AccountButton(text: '願望清單', onTap: () {}),
          ],
        )
      ],
    );
  }
}
