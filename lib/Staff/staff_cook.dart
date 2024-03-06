import 'package:flutter/material.dart';

// Define a simple data model for staff members
class StaffMember {
  final String name;
  final String mobileNo;
  final String photoUrl;

  StaffMember({
    required this.name,
    required this.mobileNo,
    required this.photoUrl,
  });
}

class StaffCookPage extends StatelessWidget {
  //  data for staff members
  final List<StaffMember> staffMembers = [
    StaffMember(
      name: 'RAFEEQ',
      mobileNo: '9567464757',
      photoUrl: 'https://st4.depositphotos.com/2796781/21160/i/450/depositphotos_211605244-stock-photo-portrait-cheerful-amazed-african-american.jpg',
    ),
    // Add more staff members as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Details'),
      ),
      body: ListView.builder(
        itemCount: staffMembers.length,
        itemBuilder: (BuildContext context, int index) {
          final staffMember = staffMembers[index];
          return _buildStaffCard(context, staffMember);
        },
      ),
    );
  }

  Widget _buildStaffCard(BuildContext context, StaffMember staffMember) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: ListTile(
        contentPadding: EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: NetworkImage(staffMember.photoUrl),
        ),
        title: Text(
          staffMember.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Mobile: ${staffMember.mobileNo}',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        onTap: () => _showImageDialog(context, staffMember.photoUrl),
      ),
    );
  }

  void _showImageDialog(BuildContext context, String imageUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
        );
      },
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: StaffCookPage(),
    theme: ThemeData(
      primaryColor: Colors.blue,
      hintColor: Colors.blueAccent,
      fontFamily: 'Roboto',
    ),
  ));
}
