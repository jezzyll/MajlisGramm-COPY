import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

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
  late File? _image;
  final picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    mobileController = TextEditingController();
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileController.dispose();
    super.dispose();
  }

  Future<void> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  Future uploadImage(File _image) async {
    Reference storageReference =
        FirebaseStorage.instance.ref().child('staff_photos/${_image.path}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete(() => null);
    return storageReference.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Staff Details'),
        backgroundColor: Colors.green,
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
          Padding(
            padding: const EdgeInsets.only(bottom: 70.0),
            child: ElevatedButton(
              onPressed: () {
                getImage().then((_) {
                  if (_image != null) {
                    uploadImage(_image!).then((url) {
                      _showAddStaffDialog(context, url);
                    });
                  }
                });
              },
              child: Text('Add Staff'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                elevation: 30,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStaffCard(BuildContext context, StaffMember staffMember) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.green[100],
      child: ListTile(
        contentPadding: EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: staffMember.photoUrl.isNotEmpty
              ? NetworkImage(staffMember.photoUrl)
              : null,
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

  void _showAddStaffDialog(BuildContext context, String photoUrl) {
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
              _image != null
                  ? CircleAvatar(
                      radius: 30,
                      backgroundImage: FileImage(_image!),
                    )
                  : SizedBox(),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                _addStaff(photoUrl);
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

  Future<void> _addStaff(String photoUrl) {
    return staffTeachersCollection.add({
      'name': nameController.text,
      'mobileNo': mobileController.text,
      'photoUrl': photoUrl,
    }).then((value) {
      nameController.clear();
      mobileController.clear();
      setState(() {
        _image = null;
      });
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
