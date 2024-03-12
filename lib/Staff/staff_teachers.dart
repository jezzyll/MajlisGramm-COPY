import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Define a simple data model for staff members
class StaffMember {
  final String id;
  final String name;
  final String mobileNo;
  final String photoUrl;

  StaffMember({
    required this.id,
    required this.name,
    required this.mobileNo,
    required this.photoUrl,
  });
}

class StaffTeachersPage extends StatefulWidget {
  @override
  _StaffTeachersPageState createState() => _StaffTeachersPageState();
}

class _StaffTeachersPageState extends State<StaffTeachersPage> {
  final CollectionReference staffTeachersCollection =
      FirebaseFirestore.instance.collection('StaffTeachers');

  late TextEditingController nameController;
  late TextEditingController mobileController;
  late TextEditingController photoUrlController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    mobileController = TextEditingController();
    photoUrlController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    photoUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Details'),
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: staffTeachersCollection.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Something went wrong');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                }

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data() as Map<String, dynamic>;
                    return _buildStaffCard(
                      context,
                      StaffMember(
                        id: document.id,
                        name: data['name'],
                        mobileNo: data['mobileNo'],
                        photoUrl: data['photoUrl'],
                      ),
                    );
                  }).toList(),
                );
              },
            ),
          ),
          ElevatedButton(
            onPressed: () => _showAddStaffDialog(context),
            child: Text('Add Staff'),
          ),
        ],
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
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _deleteStaff(staffMember.id),
        ),
      ),
    );
  }

  void _showAddStaffDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Staff'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: mobileController,
                decoration: InputDecoration(labelText: 'Mobile No.'),
              ),
              TextField(
                controller: photoUrlController,
                decoration: InputDecoration(labelText: 'Photo URL'),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addStaff();
                Navigator.of(context).pop();
              },
              child: Text('Add'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _addStaff() {
    return staffTeachersCollection.add({
      'name': nameController.text,
      'mobileNo': mobileController.text,
      'photoUrl': photoUrlController.text,
    }).then((value) {
      nameController.clear();
      mobileController.clear();
      photoUrlController.clear();
    }).catchError((error) => print('Failed to add staff: $error'));
  }

  Future<void> _deleteStaff(String id) {
    return staffTeachersCollection
        .doc(id)
        .delete()
        .then((value) => print('Staff deleted'))
        .catchError((error) => print('Failed to delete staff: $error'));
  }
}

void main() {
  runApp(MaterialApp(
    home: StaffTeachersPage(),
    theme: ThemeData(
      primaryColor: Colors.blue,
      hintColor: Colors.blueAccent,
      fontFamily: 'Roboto',
    ),
  ));
}
