import 'package:ec/constants/global_variables.dart';
import 'package:ec/features/account/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({super.key});

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  //temp order list
  List list = [
    'https://images.pexels.com/photos/14683126/pexels-photo-14683126.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/14683126/pexels-photo-14683126.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/14683126/pexels-photo-14683126.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
    'https://images.pexels.com/photos/14683126/pexels-photo-14683126.jpeg?auto=compress&cs=tinysrgb&w=1260&h=750&dpr=2',
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
            scrollDirection: Axis.horizontal,
            itemCount: list.length,
            itemBuilder: (context, index) {
              return SingleProduct(
                image: list[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
