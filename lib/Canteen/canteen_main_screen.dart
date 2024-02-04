import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Canteen/canteen_home.dart';
import 'package:flutter_application_111_copy/Canteen/canteen_menu.dart';
import 'package:flutter_application_111_copy/Canteen/canteen_order.dart';

class CanteenMainScreen extends StatelessWidget {
  const CanteenMainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Canteen App'),
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home_mini_rounded), text: 'Home'),
              Tab(icon: Icon(Icons.fastfood_rounded), text: 'Menu'),
              Tab(icon: Icon(Icons.book_rounded), text: 'Orders'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CanteenHome(),
            CanteenFoodMenu(),
            CanteenOrderFood(),
          ],
        ),
      ),
    );
  }
}
