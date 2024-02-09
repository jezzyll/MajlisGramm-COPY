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
  TextEditingController _controller1 = TextEditingController();
  TextEditingController _controller2 = TextEditingController();

  // List to store data fetched from Firestore
  String? committeeMember1;
  List<String> newUpdates = [];

  @override
  void initState() {
    super.initState();
    // Fetch data from Firestore for the first text field
    _fetchDataFromFirestore();
  }

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
              TextFormField(
                controller: _controller1,
                readOnly: true,
                decoration: InputDecoration(
                  hintText: 'Enter name...',
                ),
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
              TextFormField(
                controller: _controller2,
                decoration: InputDecoration(
                  hintText: 'Enter name...',
                  suffixIcon: IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Implement update functionality for committee member 2
                      _submitToFirestore();
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {},
          child: Text('Submit'),
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
      child: SingleChildScrollView( // Use SingleChildScrollView to handle overflow
        child: Text(
          update,
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }

  Future<void> _submitToFirestore() async {
    // Submit committee member 2 to Firestore
    await FirebaseFirestore.instance.collection('committee_members').add({
      'name': _controller2.text,
    });

    // Clear text field 2 after submission
    _controller2.clear();
  }

  Future<void> _fetchDataFromFirestore() async {
    // Fetch data from Firestore for committee member 1
    final snapshot = await FirebaseFirestore.instance.collection('committee_members').doc('your_document_id').get();
    setState(() {
      committeeMember1 = snapshot.get('name1');
      _controller1.text = committeeMember1 ?? '';
    });
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
