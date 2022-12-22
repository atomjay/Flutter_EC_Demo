import 'package:ec/constants/global_variables.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  //temp order list
  List list = [
    'image':'https://www.pexels.com/zh-tw/photo/7948965/',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding: EdgeInsets.only(left: 15.0),
              child: Text('您的訂單',
                  style:
                      TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold)),
            ),
            Container(
              padding: EdgeInsets.only(right: 15.0),
              child: Text(
                '檢視全部',
                style: TextStyle(
                  color: GlobalVariables.selectedNavBarColor,
                ),
              ),
            ),
          ],
        ),
        // order list
        Container(
          height: 170.0,
          padding: EdgeInsets.only(
            left: 10.0,
            top: 20.0,
            right: 0.0,
          ),
          child: ListView.builder(
            itemCount: 3,
            itemBuilder: (context, index) {},
          ),
        ),
      ],
    );
  }
}
