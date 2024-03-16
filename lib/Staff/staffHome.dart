import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Offiice/office_non_staff.dart';
import 'package:flutter_application_111_copy/Offiice/office_staff.dart';
import 'package:flutter_application_111_copy/Offiice/office_stock.dart';
import 'package:flutter_application_111_copy/Offiice/office_student.dart';

class StaffHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Majlis Staff'),
        backgroundColor: Colors.green,
      ),
      
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildCard(context, 'Staff', '/staff', Icons.people, Color.fromARGB(255, 12, 62, 22)),
          _buildCard(context, 'Non-Staff', '/nonStaff', Icons.person, Color.fromARGB(255, 12, 62, 22)),
          _buildCard(context, 'Stock', '/stock', Icons.inventory, Color.fromARGB(255, 12, 62, 22)),
          _buildCard(context, 'Student', '/student', Icons.school, Color.fromARGB(255, 12, 62, 22)),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String route, IconData iconData, Color color) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        margin: EdgeInsets.all(16.0),
        color: color,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              iconData,
              size: 50.0,
              color: Colors.white,
            ),
            SizedBox(height: 10.0),
            Text(
              title,
              style: TextStyle(fontSize: 20.0, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
