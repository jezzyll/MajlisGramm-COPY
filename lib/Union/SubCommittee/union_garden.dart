import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UnionGarden extends StatelessWidget {
  const UnionGarden({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "UnionGarden",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
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
  File? _assistImageFile; // Nullable File
  final TextEditingController _chiefNameController = TextEditingController();
  final TextEditingController _assistNameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _chiefImageFile = File('');
    _assistImageFile = null; // Initialize as null
    _loadPersistedImages();
  }

  Future<void> _loadPersistedImages() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? chiefImagePath = prefs.getString('chiefImage');
    String? assistImagePath = prefs.getString('assistImage');
    if (chiefImagePath != null) {
      setState(() {
        _chiefImageFile = File(chiefImagePath);
      });
    }
    if (assistImagePath != null) {
      setState(() {
        _assistImageFile = File(assistImagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildSectionTitle('Leading Member'),
        _buildMemberSection(
          _chiefImageFile,
          _chiefNameController,
          isChief: true,
        ),
        SizedBox(height: 20),
        _buildSectionTitle('Assistant Member'),
        _buildMemberSection(
          _assistImageFile,
          _assistNameController,
          isChief: false,
        ),
        SizedBox(height: 20),
        _buildSectionTitle('Members'),
        _buildMembersList(),
      ],
    );
  }

  Widget _buildSectionTitle(String title) {
    return Container(
      color: Colors.teal,
      padding: const EdgeInsets.all(8.0),
      child: Text(
        title,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    );
  }

  Widget _buildMemberSection(
    File? imageFile,
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
            child: Text(
              isChief ? 'Choose Image of Leading Member' : 'Choose Image of Assistant Member',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 5),
          ElevatedButton(
            onPressed: () {
              _showAddMemberDialog(context, nameController, isChief: isChief);
            },
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
            child: Text(
              isChief ? 'Add Leading Member' : 'Add Assistant Member',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 5),
          // Display the entered name
          Text(
            nameController.text,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMembersList() {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('garden_members').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Something went wrong');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        return Column(
          children: snapshot.data!.docs.map((DocumentSnapshot document) {
            Map<String, dynamic> data = document.data() as Map<String, dynamic>;
            String memberId = document.id;
            return Card(
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(data['image_url']),
                ),
                title: Text(data['name']),
                trailing: IconButton(
                  icon: Icon(Icons.delete),
                  onPressed: () {
                    _deleteMember(memberId);
                  },
                ),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Future<void> _deleteMember(String memberId) async {
    await FirebaseFirestore.instance.collection('garden_members').doc(memberId).delete();
  }

  Future<void> _getImage(ImageSource source, {required bool isChief}) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile != null) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      String imagePath = pickedFile.path;
      setState(() {
        if (isChief) {
          _chiefImageFile = File(imagePath);
          prefs.setString('chiefImage', imagePath);
        } else {
          _assistImageFile = File(imagePath); // Update nullable file
          prefs.setString('assistImage', imagePath);
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
          title: Text(isChief ? 'Add Leading Member' : 'Add Assistant Member'),
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
                String imageUrl = await _uploadImage(isChief ? _chiefImageFile! : _assistImageFile!);
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
