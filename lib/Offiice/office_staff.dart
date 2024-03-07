import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OfficeStaffPage extends StatefulWidget {
  @override
  _OfficeStaffPageState createState() => _OfficeStaffPageState();
}

class _OfficeStaffPageState extends State<OfficeStaffPage> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;

  late String _name;
  late String _bio;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _bioController = TextEditingController();
    _loadDataFromFirestore();
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
    } catch (e) {
      print('Error saving data: $e');
    }
  }

  void _changeOfficer() {
    _saveDataToFirestore();
    _loadDataFromFirestore();
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
              CircleAvatar(
                radius: 50.0,
                backgroundImage: NetworkImage(
                    "https://t3.ftcdn.net/jpg/02/99/04/20/360_F_299042079_vGBD7wIlSeNl7vOevWHiL93G4koMM967.jpg"),
              ),
              SizedBox(height: 20.0),
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
              ElevatedButton(
                onPressed: _saveDataToFirestore,
                child: Text('Save'),
              ),
              SizedBox(height: 10.0),
              ElevatedButton(
                onPressed: _changeOfficer,
                child: Text('Change Officer'),
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
