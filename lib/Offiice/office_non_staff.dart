import 'dart:io';

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

// Define a simple data model for non-staff members
class NonStaffMember {
  final String id;
  final String name;
  final String mobileNo;
  final String photoUrl;

  NonStaffMember({
    required this.id,
    required this.name,
    required this.mobileNo,
    required this.photoUrl,
  });
}

class OfficeNonStaffPage extends StatefulWidget {
  @override
  _OfficeNonStaffPageState createState() => _OfficeNonStaffPageState();
}

class _OfficeNonStaffPageState extends State<OfficeNonStaffPage> {
  final CollectionReference nonStaffCollection =
      FirebaseFirestore.instance.collection('NonStaff');

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
        FirebaseStorage.instance.ref().child('nonstaff_photos/${_image.path}');
    UploadTask uploadTask = storageReference.putFile(_image);
    await uploadTask.whenComplete(() => null);
    return storageReference.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Non-Staff Details'),
        backgroundColor: Colors.blue, // Changing color to blue
      ),
      body: Column(
        children: [
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: nonStaffCollection.snapshots(),
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
                    return _buildNonStaffCard(
                      context,
                      NonStaffMember(
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
                      _showAddNonStaffDialog(context, url);
                    });
                  }
                });
              },
              child: Text('Add Non-Staff'),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.blue, // Changing color to blue
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

  Widget _buildNonStaffCard(BuildContext context, NonStaffMember nonStaffMember) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      color: Colors.blue[100], // Changing color to blue
      child: ListTile(
        contentPadding: EdgeInsets.all(12),
        leading: CircleAvatar(
          radius: 30,
          backgroundImage: nonStaffMember.photoUrl.isNotEmpty
              ? NetworkImage(nonStaffMember.photoUrl)
              : null,
        ),
        title: Text(
          nonStaffMember.name,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        subtitle: Text(
          'Mobile: ${nonStaffMember.mobileNo}',
          style: TextStyle(
            fontSize: 14,
          ),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete),
          onPressed: () => _deleteNonStaff(nonStaffMember.id),
        ),
      ),
    );
  }

  void _showAddNonStaffDialog(BuildContext context, String photoUrl) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Non-Staff'),
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
                _addNonStaff(photoUrl);
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

  Future<void> _addNonStaff(String photoUrl) {
    return nonStaffCollection.add({
      'name': nameController.text,
      'mobileNo': mobileController.text,
      'photoUrl': photoUrl,
    }).then((value) {
      nameController.clear();
      mobileController.clear();
      setState(() {
        _image = null;
      });
    }).catchError((error) => print('Failed to add non-staff: $error'));
  }

  Future<void> _deleteNonStaff(String id) {
    return nonStaffCollection
        .doc(id)
        .delete()
        .then((value) => print('Non-Staff deleted'))
        .catchError((error) => print('Failed to delete non-staff: $error'));
  }
}

void main() {
  runApp(MaterialApp(
    home: OfficeNonStaffPage(),
    theme: ThemeData(
      primaryColor: Colors.blue,
      hintColor: Colors.blueAccent,
      fontFamily: 'Roboto',
    ),
  ));
}
