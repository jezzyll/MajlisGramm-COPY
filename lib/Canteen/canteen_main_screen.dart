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
          title: Text('Majlis Canteen '),
          backgroundColor: Colors.green,
          bottom: TabBar(
            tabs: [
              Tab(
                icon: Icon(Icons.home_mini_rounded, color: Colors.black), // Set icon color to black
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.fastfood_rounded, color: Colors.black), // Set icon color to black
                text: 'Menu',
              ),
              Tab(
                icon: Icon(Icons.book_rounded, color: Colors.black), // Set icon color to black
                text: 'Orders',
              ),
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
