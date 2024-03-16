import 'dart:io';

import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';


class UnionActivity extends StatefulWidget {
  @override
  _NotificationPageState createState() => _NotificationPageState();
}

class _NotificationPageState extends State<UnionActivity> {
  List<String> imageUrls = [];

  Future<void> _pickImage(ImageSource source) async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: source); // Use pickImage instead of getImage

  if (pickedFile != null) {
    File image = File(pickedFile.path);
    setState(() {
      imageUrls.add(image.path);
    });
  }
}


  Future<void> _addImage() async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Add Image"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.camera),
                child: Text("Take a Photo"),
              ),
              SizedBox(height: 10),
              ElevatedButton(
                onPressed: () => _pickImage(ImageSource.gallery),
                child: Text("Choose from Gallery"),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Image Notification Page'),
        backgroundColor: Colors.green,
      ),
      body: ListView.builder(
        itemCount: imageUrls.length,
        itemBuilder: (context, index) {
          return Container(
            margin: EdgeInsets.all(8),
            decoration: BoxDecoration(
              border: Border.all(),
            ),
            child: Image.file(File(imageUrls[index])),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.green,
        onPressed: _addImage,
        child: Icon(Icons.add),
      ),
    );
  }
}