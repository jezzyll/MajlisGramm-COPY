import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Offiice/office_non_staff.dart';
import 'package:flutter_application_111_copy/Offiice/office_staff.dart';
import 'package:flutter_application_111_copy/Offiice/office_stock.dart';
import 'package:flutter_application_111_copy/Offiice/office_student.dart';

class OfficeHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Majlis Office'),
        backgroundColor: Colors.green,
      ),
      
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          _buildCard(context, 'Office Staff', Icons.people, '/officestaff', Colors.teal),
          _buildCard(context, 'Non-Staff', Icons.person, '/nonStaff', Colors.teal),
          _buildCard(context, 'New Admission', Icons.add, '/newAdmission', Colors.teal),
          _buildCard(context, 'Fee Details', Icons.attach_money, '/feeDetails', Colors.teal),
          _buildCard(context, 'Stock', Icons.inventory, '/stock', Colors.teal),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, IconData iconData, String route, Color color) {
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
