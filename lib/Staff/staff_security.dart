import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StaffSecurityPage extends StatefulWidget {
  @override
  _OfficeStaffPageState createState() => _OfficeStaffPageState();
}

class _OfficeStaffPageState extends State<StaffSecurityPage> {
  late TextEditingController _nameController;
  late TextEditingController _bioController;

  late String _name;
  late String _bio;
  bool _showInputFields = true; // Flag to control the visibility of input fields

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
      await FirebaseFirestore.instance.collection('StaffSecurity').doc('1').set({
        'name': _nameController.text,
        'contact': _bioController.text,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Security'),
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
                    "https://cdn.openart.ai/stable_diffusion/b3c822d4202185d5fca9fb7029268a4901811998_2000x2000.webp"),
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
                child: Text(_showInputFields ? 'Save' : 'Change Security'),
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
    home: StaffSecurityPage(),
  ));
}
