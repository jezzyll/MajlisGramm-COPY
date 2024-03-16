import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Canteen/menuitems_daily.dart';

class CanteenFoodMenu extends StatelessWidget {
  const CanteenFoodMenu({Key? key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Food Menu"),
        backgroundColor: Color.fromARGB(0, 28, 217, 88),
      ),
      body: ListView.separated(
        itemCount: 7,
        separatorBuilder: (context, index) => Divider(color: Colors.white), // Set divider color to white
        itemBuilder: (context, index) {
          final today = DateTime.now();
          final day = today.add(Duration(days: index));

          return ClipRRect(
            borderRadius: BorderRadius.circular(15), // Set border radius for curved edges
            child: Container(
              color: Colors.green[100], // Set background color to green-matched color
              child: ListTile(
                title: Text(
                  _getDayName(day.weekday),
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => MenuItemsPage(day: _getDayName(day.weekday)),
                    ),
                  );
                },
              ),
            ),
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
