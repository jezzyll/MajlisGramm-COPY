import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class UnionGarden extends StatelessWidget {
  const UnionGarden({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "UnionGarden",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Center(child: Text("Garden")),
        ),
        body: SingleChildScrollView(
          child: Center(
            child: Body(),
          ),
        ),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late File _chiefImageFile;
  late File _assistImageFile;
  final TextEditingController _chiefNameController = TextEditingController();
  final TextEditingController _assistNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _chiefImageFile = File(''); // Initialize _chiefImageFile with an empty file path
    _assistImageFile = File(''); // Initialize _assistImageFile with an empty file path
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildMemberSection(
          _chiefImageFile,
          _chiefNameController,
          isChief: true,
        ),
        SizedBox(height: 20),
        _buildMemberSection(
          _assistImageFile,
          _assistNameController,
          isChief: false,
        ),
      ],
    );
  }

  Widget _buildMemberSection(
    File imageFile,
    TextEditingController nameController, {
    required bool isChief,
  }) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          CircleAvatar(
            radius: 70,
            backgroundImage: imageFile != null
                ? FileImage(imageFile)
                : AssetImage('assets/images/placeholder.jpg') as ImageProvider,
          ),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              _getImage(ImageSource.gallery, isChief: isChief);
            },
            child: Text('Choose Image'),
          ),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              _showAddMemberDialog(context, nameController, isChief: isChief);
            },
            child: Text('Add Member'),
          ),
        ],
      ),
    );
  }

  Future<void> _getImage(ImageSource source, {required bool isChief}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      setState(() {
        if (isChief) {
          _chiefImageFile = File(pickedFile.path);
        } else {
          _assistImageFile = File(pickedFile.path);
        }
      });
    }
  }

  Future<void> _showAddMemberDialog(
    BuildContext context,
    TextEditingController nameController, {
    required bool isChief,
  }) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Member'),
          content: SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                  ),
                ),
                SizedBox(height: 10),
                // Add more fields for additional member details if needed
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () async {
                String imageUrl = await _uploadImage(isChief ? _chiefImageFile : _assistImageFile);
                await _addToFirestore(imageUrl, nameController.text);
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<String> _uploadImage(File imageFile) async {
    firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('profile_images')
        .child(DateTime.now().millisecondsSinceEpoch.toString() + '.jpg');

    firebase_storage.UploadTask uploadTask = storageRef.putFile(imageFile);

    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask;

    String imageUrl = await taskSnapshot.ref.getDownloadURL();
    return imageUrl;
  }

  Future<void> _addToFirestore(String imageUrl, String name) async {
    await FirebaseFirestore.instance.collection('garden_members').add({
      'name': name,
      'image_url': imageUrl,
    });
  }
}

void main() {
  runApp(UnionGarden());
}
