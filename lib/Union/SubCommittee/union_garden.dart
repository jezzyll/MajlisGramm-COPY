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
  late File _chiefImageFile = File(''); // Initialize _chiefImageFile with an empty file path
  late File _assistImageFile = File(''); // Initialize _assistImageFile with an empty file path
  final TextEditingController _chiefNameController = TextEditingController();
  final TextEditingController _assistNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Chief Member",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _chiefImageFile != null
                  ? CircleAvatar(
                      radius: 70,
                      backgroundImage: FileImage(_chiefImageFile),
                    )
                  : CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/images/placeholder.jpg'),
                    ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  _getImage(ImageSource.gallery, isChief: true);
                },
                child: Text('Choose Image'),
              ),
              SizedBox(height: 5),
              TextField(
                controller: _chiefNameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  String imageUrl = await _uploadImage(_chiefImageFile);
                  await _addToFirestore(imageUrl, _chiefNameController.text);
                },
                child: Text('Add Member'),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Assistant Member",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              _assistImageFile != null
                  ? CircleAvatar(
                      radius: 70,
                      backgroundImage: FileImage(_assistImageFile),
                    )
                  : CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/images/placeholder.jpg'),
                    ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  _getImage(ImageSource.gallery, isChief: false);
                },
                child: Text('Choose Image'),
              ),
              SizedBox(height: 5),
              TextField(
                controller: _assistNameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () async {
                  String imageUrl = await _uploadImage(_assistImageFile);
                  await _addToFirestore(imageUrl, _assistNameController.text);
                },
                child: Text('Add Member'),
              ),
            ],
          ),
        ),
      ],
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

  Future<String> _uploadImage(File imageFile) async {
    firebase_storage.Reference storageRef = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('profile_images')
        .child(DateTime.now().millisecondsSinceEpoch.toString() + '.jpg');

    firebase_storage.UploadTask uploadTask = storageRef.putFile(imageFile);

    firebase_storage.TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);

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
