import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Canteen/menuitems_daily.dart';

class CanteenFoodMenu extends StatelessWidget {
  const CanteenFoodMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Food Menu"),
      backgroundColor: const Color.fromARGB(77, 206, 145, 145),),

      body: ListView.builder(
        itemCount: 7,
        itemBuilder: (context, index) {
          final today = DateTime.now();
          final day = today.add(Duration(days: index));

          return ListTile(
            title: Text(_getDayName(day.weekday)),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MenuItemsPage(day: _getDayName(day.weekday)),
                ),
              );
            },
          );
        },
      ),
    );
  }

  String _getDayName(int day) {
    switch (day) {
      case DateTime.sunday:
        return 'Sunday';
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      default:
        return '';
    }
  }

}