import 'dart:io';
import 'package:flutter_application_111_copy/Auth/home_screen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:firebase_auth/firebase_auth.dart';

class UserProfilePage extends StatefulWidget {
  final String userId;

  const UserProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late Future<DocumentSnapshot> _userFuture;
  String? _imageUrl;

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    _userFuture = _fetchUser();
  }

  Future<DocumentSnapshot> _fetchUser() async {
    return await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
        actions: [
          IconButton(
            onPressed: () {
              _auth.signOut();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => HomeScreen()),
              );
            },
            icon: Icon(Icons.logout),
          ),
        ],
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: _userFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Center(child: Text('No data found'));
          }

          var userData = snapshot.data!.data() as Map<String, dynamic>;
          _imageUrl ??= userData['profileImageUrl']; // Set _imageUrl if not set

          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () => _showImageSource(context),
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageUrl != null ? NetworkImage(_imageUrl!) : null,
                      child: _imageUrl == null ? Icon(Icons.camera_alt) : null,
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Hi, it's me ${userData['name']}",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: 300,
                    child: Column(
                      children: [
                        _buildInfoCard('Name', userData['name']),
                        SizedBox(height: 10),
                        _buildInfoCard('Age', userData['age'].toString()),
                        SizedBox(height: 10),
                        _buildInfoCard('Email', userData['email']),
                        SizedBox(height: 10),
                        _buildInfoCard('Blood Group', userData['blood']),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _showImageSource(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ListTile(
                leading: Icon(Icons.camera_alt),
                title: Text('Take Photo'),
                onTap: () {
                  Navigator.pop(context);
                  _uploadImage(ImageSource.camera);
                },
              ),
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('Choose from Gallery'),
                onTap: () {
                  Navigator.pop(context);
                  _uploadImage(ImageSource.gallery);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _uploadImage(ImageSource source) async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: source);

    if (image == null) return;

    String imageUrl = await uploadImageToFirestoreStorage(image);

    setState(() {
      _imageUrl = imageUrl;
    });

    // Update Firestore with the new image URL
    await FirebaseFirestore.instance.collection('users').doc(widget.userId).update({
      'profileImageUrl': _imageUrl,
    });
  }

  Future<String> uploadImageToFirestoreStorage(XFile image) async {
    final String fileName = basename(image.path);
    final Reference storageReference = FirebaseStorage.instance.ref().child('images/$fileName');

    final UploadTask uploadTask = storageReference.putFile(File(image.path));
    final TaskSnapshot downloadUrl = await uploadTask.whenComplete(() => null);
    final String url = await downloadUrl.ref.getDownloadURL();

    return url;
  }

  Widget _buildInfoCard(String title, String value) {
    return Container(
      width: double.infinity,
      child: Card(
        elevation: 3.0,
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5.0),
              Text(value),
            ],
          ),
        ),
      ),
    );
  }
}
