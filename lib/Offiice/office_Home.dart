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
      ),
      
      body: GridView.count(
        crossAxisCount: 2,
        children: [
          
          _buildCard(context, 'OfficeStaff', '/officestaff'),
          _buildCard(context, 'Non-Staff', '/nonStaff'),
          _buildCard(context, 'New Admission', '/newAdmission'),
          _buildCard(context, 'Fee Details', '/feeDetails'),
          _buildCard(context, 'Stock', '/stock'),
        ],
      ),
    );
  }

  Widget _buildCard(BuildContext context, String title, String route) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(context, route);
      },
      child: Card(
        margin: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            title,
            style: TextStyle(fontSize: 20.0),
          ),
        ),
      ),
    );
    
}
}

