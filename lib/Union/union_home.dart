import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Union/SubCommittee/union_sub_committee.dart';
import 'package:flutter_application_111_copy/Union/union_activity.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class unionHomePage extends StatefulWidget {
  const unionHomePage({Key? key}) : super(key: key);

  @override
  _UnionExecutiveCommitteeState createState() =>
      _UnionExecutiveCommitteeState();
}

class _UnionExecutiveCommitteeState extends State<unionHomePage> {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Union"),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
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
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(imageUrl),
                      ),
                      title: Text(name),
                      subtitle: Text(bio),
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
                      content: Container(
                        width: double.maxFinite,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircleAvatar(
                              backgroundImage:
                                  _imageFile != null ? FileImage(_imageFile!) : null,
                              radius: 50,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                _getImage(ImageSource.gallery);
                              },
                              child: Text('Select Image'),
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
                      actions: [
                        TextButton(
                          onPressed: () async {
                            if (_imageFile != null) {
                              String imageUrl = await _uploadImage(_imageFile!);
                              setState(() {
                                _imageUrl = imageUrl;
                              });
                              await _addToFirestore(imageUrl);
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
              child: Text('Add Member'),
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
                    child: Text('Sub-committee'),
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
                  child: Text('Activities'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
