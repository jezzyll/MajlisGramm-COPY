import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
        body: SingleChildScrollView(child: Body()),
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
  // List to store data fetched from Firestore
  List<String> newUpdates = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Committee Members",
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
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/images/me.jpg'),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  // Implement functionality for adding committee member 1
                  _addCommitteeMember(1);
                },
                child: Text('Add Committee'),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              CircleAvatar(
                radius: 70,
                backgroundImage: AssetImage('assets/images/PSC1.jpg'),
              ),
              SizedBox(height: 5),
              ElevatedButton(
                onPressed: () {
                  // Implement functionality for adding committee member 2
                  _addCommitteeMember(2);
                },
                child: Text('Add Committee'),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        Text(
          "NEW UPDATES",
          style: TextStyle(
            color: Colors.red,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        SizedBox(height: 10),
        Column(
          children: newUpdates.map((update) => _buildUpdateContainer(update)).toList(),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Navigate to AdditionalInformationPage
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AdditionalInformationPage()),
            ).then((value) {
              // Update newUpdates after returning from AdditionalInformationPage
              if (value != null) {
                setState(() {
                  newUpdates.add(value);
                });
              }
            });
          },
          child: Text('Add'),
        ),
      ],
    );
  }

  Widget _buildUpdateContainer(String update) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      width: 300, // Fixed width
      height: 100, // Fixed height
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: SingleChildScrollView(
        child: Text(
          update,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  void _addCommitteeMember(int memberNumber) {
    // Implement functionality for adding committee members
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Add Committee Member'),
          content: TextFormField(
            decoration: InputDecoration(
              hintText: 'Enter name...',
            ),
            onChanged: (value) {
              // Update UI or perform necessary actions
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                // Add functionality to save committee member to Firestore or perform other actions
                Navigator.pop(context);
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}

class AdditionalInformationPage extends StatelessWidget {
  TextEditingController _additionalInfoController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Additional Information'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            Expanded(
              child: Container(
                width: 400, // Fixed width
                height: 100, // Fixed height
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _additionalInfoController,
                  maxLines: null,
                  decoration: InputDecoration(
                    hintText: 'Enter text here...',
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await FirebaseFirestore.instance.collection('additionalInformation').add({
                  'info': _additionalInfoController.text,
                });
                Navigator.pop(context, _additionalInfoController.text);
              },
              child: Text('Enter'),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(UnionGarden());
}
