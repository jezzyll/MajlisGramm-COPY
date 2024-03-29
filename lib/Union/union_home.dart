import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Union/SubCommittee/union_sub_committee.dart';
import 'package:flutter_application_111_copy/Union/union_activity.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class UnionHomePage extends StatefulWidget {
  const UnionHomePage({Key? key}) : super(key: key);

  @override
  _UnionHomePageState createState() => _UnionHomePageState();
}

class _UnionHomePageState extends State<UnionHomePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  late String _imageUrl = '';

  File? _imageFile;

  Future<void> _getImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
      });
    }
  }

  Future<String> _uploadImage(File imageFile) async {
    firebase_storage.Reference storageRef =
        firebase_storage.FirebaseStorage.instance.ref().child('profile_images').child(
            DateTime.now().millisecondsSinceEpoch.toString() + '.jpg');

    firebase_storage.UploadTask uploadTask = storageRef.putFile(imageFile);

    firebase_storage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => null);

    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<void> _addToFirestore(String imageUrl) async {
    await FirebaseFirestore.instance.collection('executive_committee').add({
      'name': _nameController.text,
      'bio': _bioController.text,
      'image_url': imageUrl,
    });
  }

  Future<void> _deleteMember(String memberId) async {
    await FirebaseFirestore.instance.collection('executive_committee').doc(memberId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Column(
          children: [
            Text(
              'College Union',
              style: TextStyle(fontSize: 18),
            ),
            Text(
              'Executive Committee',
              style: TextStyle(fontSize: 14),
            ),
          ],
        ),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Display Executive Committee members from Firestore
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('executive_committee')
                  .snapshots(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
                final committeeMembers = snapshot.data!.docs;
                return Column(
                  children: committeeMembers.map((member) {
                    final name = member['name'];
                    final bio = member['bio'];
                    final imageUrl = member['image_url'];
                    return Card(
  color: Color.fromARGB(255, 21, 106, 24), // Set background color to green
  child: Column(
    children: [
      ListTile(
        contentPadding: EdgeInsets.symmetric(horizontal: 16.0), // Adjust padding
        title: Text(name, style: TextStyle(color: Colors.white)), // Set text color to white
        subtitle: Text(bio, style: TextStyle(color: Colors.white)), // Set text color to white
        leading: CircleAvatar(
          radius: 30, // Increase circle avatar size
          backgroundImage: NetworkImage(imageUrl),
        ),
        trailing: IconButton(
          icon: Icon(Icons.delete, color: Colors.white), // Set icon color to white
          onPressed: () {
            _deleteMember(member.id); // Pass the document ID to delete
          },
        ),
      ),
      Divider(
        color: Colors.white, // Set divider color to white
        thickness: 1.5, // Increase divider thickness
        height: 0, // Set height to 0 to get default height
      ),
    ],
  ),
);

                  }).toList(),
                );
              },
            ),
            ElevatedButton( 
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('Add Member'),
                      content: SingleChildScrollView(
                        child: Container(
                          width: double.maxFinite,
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              _imageFile != null
                                  ? CircleAvatar(
                                backgroundImage: FileImage(_imageFile!),
                                radius: 50,
                              )
                                  : Container(),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Flexible( // Wrap with Flexible
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _getImage(ImageSource.camera);
                                      },
                                      child: Text('Take Photo'),
                                    ),
                                  ),
                                  SizedBox(width: 16),
                                  Flexible( // Wrap with Flexible
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _getImage(ImageSource.gallery);
                                      },
                                      child: Text('Choose from Gallery'),
                                    ),
                                  ),
                                ],
                              ),
                              TextField(
                                controller: _nameController,
                                decoration: InputDecoration(
                                  labelText: 'Name',
                                ),
                              ),
                              TextField(
                                controller: _bioController,
                                decoration: InputDecoration(
                                  labelText: 'Bio',
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      actions: [
                        TextButton(
                          onPressed: () async {
                            if (_imageFile != null) {
                              String imageUrl =
                              await _uploadImage(_imageFile!);
                              setState(() {
                                _imageUrl = imageUrl;
                              });
                              await _addToFirestore(imageUrl);
                              // Clear the text fields and image selection after adding to Firestore
                              _nameController.clear();
                              _bioController.clear();
                              setState(() {
                                _imageFile = null;
                              });
                            }
                            Navigator.of(context).pop();
                          },
                          child: Text('OK'),
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
              },
              style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                          ),
              child: Text('Add Member',
              style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UnionSubcommittee(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                          ),
                    child: Text('Sub-committee',
                    style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UnionActivity(),
                      ),
                    ).then((value) {
                      setState(() {});
                    });
                  },
                  style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.green,
                            elevation: 5,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 15, horizontal: 30),
                          ),
                  child: Text('Activities',
                  style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
