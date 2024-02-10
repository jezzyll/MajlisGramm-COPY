import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class UserProfilePage extends StatefulWidget {
  final String userId;

  const UserProfilePage({Key? key, required this.userId}) : super(key: key);

  @override
  _UserProfilePageState createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  late Future<DocumentSnapshot> _userFuture;
  late String _imageUrl;

  @override
  void initState() {
    super.initState();
    _userFuture = _fetchUser();
    _imageUrl = ''; // Initialize imageUrl
  }

  Future<DocumentSnapshot> _fetchUser() async {
    return await FirebaseFirestore.instance.collection('users').doc(widget.userId).get();
  }

  Future<void> _uploadImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery); // You can change this to ImageSource.camera for capturing a new image.

    if (image == null) return;

    // Upload image to Firestore Storage
    // Code to upload the image and get the URL
    // For demonstration purposes, let's assume you have a function to upload the image and return the URL.
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
  final TaskSnapshot downloadUrl = (await uploadTask);
  final String url = await downloadUrl.ref.getDownloadURL();

  return url;
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
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

          return Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: _uploadImage, // Function to open image picker
                    child: CircleAvatar(
                      radius: 50,
                      backgroundImage: _imageUrl.isNotEmpty ? NetworkImage(_imageUrl) : null, // Show the selected image if available
                      child: _imageUrl.isEmpty ? Icon(Icons.camera_alt) : null, // Show camera icon if no image
                    ),
                  ),
                  SizedBox(height: 20.0),
                  Text(
                    "Hi, it's me ${userData['name']}",
                    style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20.0),
                  SizedBox(
                    width: 300, // Adjust the width as needed
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
