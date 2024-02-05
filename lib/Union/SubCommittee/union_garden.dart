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
  TextEditingController _controller3 = TextEditingController();

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
              TextField(
                controller: _controller1,
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
              TextField(
                controller: _controller2,
                decoration: InputDecoration(
                  hintText: 'Enter name...',
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10),
            ),
            child: TextField(
              controller: _controller3,
              maxLines: null,
              decoration: InputDecoration(
                hintText: 'Enter text here...',
                border: InputBorder.none,
              ),
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () async {
            await _submitToFirestore();
          },
          child: Text('Submit'),
        ),
      ],
    );
  }

  Future<void> _submitToFirestore() async {
    await FirebaseFirestore.instance.collection('committee_members').add({
      'name1': _controller1.text,
      'name2': _controller2.text,
      'containerText': _controller3.text,
    });

    // Clear text fields after submission
    _controller1.clear();
    _controller2.clear();
    _controller3.clear();
  }
}
