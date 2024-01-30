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

class OfficeStaffPage extends StatelessWidget {
  //  data for staff members 
  final List<StaffMember> staffMembers = [
    StaffMember(
      name: 'FAIZAL WAFY',
      mobileNo: '9567464757',
      photoUrl: 'https://t3.ftcdn.net/jpg/02/43/12/34/360_F_243123463_zTooub557xEWABDLk0jJklDyLSGl2jrr.jpg', 
    ),
    StaffMember(
      name: 'BASITH WAFY',
      mobileNo: '8757695864',
      photoUrl: 'https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg', 
    ),
    StaffMember(
      name: 'VASIH WAFY',
      mobileNo: '8757695864',
      photoUrl: 'https://images.pexels.com/photos/220453/pexels-photo-220453.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500', 
    ),
    StaffMember(
      name: 'SHAFEEQ WAFY',
      mobileNo: '8757695864',
      photoUrl: 'https://img.freepik.com/premium-photo/thoughtful-male-employee-thinking-idea-while-sitting-desk-office_709984-7245.jpg?size=626&ext=jpg&ga=GA1.1.1413502914.1696723200&semt=ais', 
    ),
    StaffMember(
      name: 'ASHRAF WAFY',
      mobileNo: '8757695864',
      photoUrl: 'https://t3.ftcdn.net/jpg/03/02/88/46/360_F_302884605_actpipOdPOQHDTnFtp4zg4RtlWzhOASp.jpg', 
    ),
    StaffMember(
      name: 'SAEED HUDAWI',
      mobileNo: '8757695864',
      photoUrl: 'https://st4.depositphotos.com/1591576/20942/i/450/depositphotos_209420114-stock-photo-close-horizontal-portrait-stubble-bearded.jpg', 
    ),
    StaffMember(
      name: 'RAHOOF HUDAWI',
      mobileNo: '8757695864',
      photoUrl: 'https://img.freepik.com/premium-photo/i-am-going-catch-you-stylish-beard-mustache-care-happy-face-beard-fashion-barber-handsome-smiling-guy-close-up-masculinity-concept-man-bearded-hipster-stylish-beard-grey-background_474717-91646.jpg?size=626&ext=jpg&ga=GA1.1.1826414947.1698883200&semt=ais', 
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
          return _buildStaffContainer(context, staffMember);
        },
      ),  
    );
  }

  Widget _buildStaffContainer(BuildContext context, StaffMember staffMember) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundImage: NetworkImage(staffMember.photoUrl),
      ),
      title: Text(staffMember.name),
      subtitle: Text(staffMember.mobileNo),
      onTap: () {
        _showImageDialog(context, staffMember.photoUrl);
      },
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
