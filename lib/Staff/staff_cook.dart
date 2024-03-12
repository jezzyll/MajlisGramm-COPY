import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StaffCookPage extends StatefulWidget {
  @override
  _StaffCookPageState createState() => _StaffCookPageState();
}

class _StaffCookPageState extends State<StaffCookPage> {
  late TextEditingController _nameController;
  late TextEditingController _contactController;

  late String _name;
  late String _contact;
  bool _showInputFields = true; // Flag to control the visibility of input fields

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _contactController = TextEditingController();
    _loadDataFromFirestore();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    super.dispose();
  }

  void _loadDataFromFirestore() async {
    try {
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('StaffCook').doc('1').get();

      setState(() {
        _name = snapshot.data()!['name'] ?? '';
        _contact = snapshot.data()!['contact'] ?? '';
        _nameController.text = _name;
        _contactController.text = _contact;
      });
    } catch (e) {
      print('Error loading data: $e');
    }
  }

  void _saveDataToFirestore() async {
    try {
      await FirebaseFirestore.instance.collection('StaffCook').doc('1').set({
        'name': _nameController.text,
        'contact': _contactController.text,
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

  void _changeCook() {
    setState(() {
      _showInputFields = true; // Show input fields when changing cook
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cook Staff'),
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
                      controller: _contactController,
                      decoration: InputDecoration(
                        labelText: 'Contact',
                        border: OutlineInputBorder(),
                      ),
                      onChanged: (value) {
                        setState(() {
                          _contact = value;
                        });
                      },
                    ),
                    SizedBox(height: 20.0),
                  ],
                ),
              ElevatedButton(
                onPressed: _showInputFields ? _saveDataToFirestore : _changeCook,
                child: Text(_showInputFields ? 'Save' : 'Change Cook'),
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
                      'Contact: $_contact',
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
    home: StaffCookPage(),
  ));
}
