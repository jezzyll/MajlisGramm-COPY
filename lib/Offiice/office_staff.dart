import 'dart:io';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OfficeStaffPage extends StatefulWidget {
  @override
  _OfficeStaffPageState createState() => _OfficeStaffPageState();
}

class _OfficeStaffPageState extends State<OfficeStaffPage> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;

  late String _name;
  late String _bio;
  bool _showInputFields = true; // Flag to control the visibility of input fields
  File? _imageFile; // Variable to store the selected image file

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _bioController = TextEditingController();
    _loadDataFromFirestore();
    _loadImage();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _bioController.dispose();
    super.dispose();
  }

  void _loadDataFromFirestore() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('officer').doc('1').get();

      setState(() {
        _name = snapshot.data()!['name'] ?? '';
        _bio = snapshot.data()!['bio'] ?? '';
        _nameController.text = _name;
        _bioController.text = _bio;
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  void _saveDataToFirestore() async {
    try {
      await FirebaseFirestore.instance.collection('officer').doc('1').set({
        'name': _nameController.text,
        'bio': _bioController.text,
      });

      // After saving, reload the data from Firestore
      _loadDataFromFirestore();
      setState(() {
        _showInputFields = false; // Hide input fields after saving
      });
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  void _changeOfficer() {
    setState(() {
      _showInputFields = true; // Show input fields when changing officer
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await ImagePicker().pickImage(source: source);
    if (pickedFile != null) {
      setState(() {
        _imageFile = File(pickedFile.path);
        _saveImage(_imageFile!.path);
      });
    }
  }

  Future<void> _saveImage(String imagePath) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('imagePath', imagePath);
  }

  Future<void> _loadImage() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? imagePath = prefs.getString('imagePath');
    if (imagePath != null) {
      setState(() {
        _imageFile = File(imagePath);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Office Staff'),
      ),
      body: Center(
        child: Container(
          padding: EdgeInsets.all(20.0),
          width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(20.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              GestureDetector(
                onTap: () {
                  _pickImage(ImageSource.gallery);
                },
                child: CircleAvatar(
                  radius: 50.0,
                  backgroundImage: _imageFile != null ? FileImage(_imageFile!) : null,
                  backgroundColor: Colors.grey[300],
                  child: _imageFile == null
                      ? Icon(
                          Icons.camera_alt,
                          size: 40,
                          color: Colors.white,
                        )
                      : null,
                ),
              ),
              SizedBox(height: 20.0),
              if (_showInputFields)
                Column(
                  children: [
                    TextField(
                      controller: _nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _name = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                    TextField(
                      controller: _bioController,
                      decoration: InputDecoration(
                        labelText: 'Bio',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _bio = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ElevatedButton(
                onPressed: _showInputFields ? _saveDataToFirestore : _changeOfficer,
                child: Text(_showInputFields ? 'Save' : 'Change Officer'),
              ),
              SizedBox(height: 10.0),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10.0),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 3,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Name: $_name',
                      style: TextStyle(fontSize: 18.0),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      'Bio: $_bio',
                      style: TextStyle(fontSize: 18.0),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: OfficeStaffPage(),
  ));
}
