import 'package:ec/constants/global_variables.dart';
import 'package:ec/features/account/widgets/below_app_bar.dart';
import 'package:ec/features/account/widgets/orders.dart';
import 'package:ec/features/account/widgets/top_buttons.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatelessWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(50.0),
          child: AppBar(
            flexibleSpace: Container(
              decoration: BoxDecoration(
                // gradient: GlobalVariables.appBarGradient,
                color: Colors.white,
              ),
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  child: Image.asset(
                    'lib/assets/images/amazon_in.png',
                    width: 120.0,
                    height: 45.0,
                    color: Colors.black,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(left: 15.0, right: 15.0),
                  child: Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 15),
                        child: Icon(Icons.notifications_outlined),
                      ),
                      Icon(Icons.notifications_outlined)
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Column(
          children: [
            BelowAppBar(),
            SizedBox(
              height: 10.0,
            ),
            TopButtons(),
            SizedBox(
              height: 20.0,
            ),
            Orders(),
          ],
        ));
  }
}
