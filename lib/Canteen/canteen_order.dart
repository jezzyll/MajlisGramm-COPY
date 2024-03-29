import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CanteenOrderFood extends StatefulWidget {
  const CanteenOrderFood({Key? key});

  @override
  State<CanteenOrderFood> createState() => _CanteenOrderFoodState();
}

class _CanteenOrderFoodState extends State<CanteenOrderFood> {
  late int orderCount;
  late int noOrderCount;

  @override
  void initState() {
    super.initState();
    // Initialize states and fetch user's choice from Firestore
    orderCount = 0;
    noOrderCount = 0;
    _fetchCounts();
  }

  // Function to fetch counts from Firestore
  void _fetchCounts() async {
    try {
      // Retrieve counts from Firestore and update UI
      DocumentSnapshot<Map<String, dynamic>> snapshot = await FirebaseFirestore.instance
          .collection('canteen')
          .doc('order')
          .get();

      setState(() {
        orderCount = snapshot.data()?['orderCount'] ?? 0;
        noOrderCount = snapshot.data()?['noOrderCount'] ?? 0;
      });
    } catch (error) {
      print('Error fetching counts: $error');
    }
  }

  // Function to update counts in Firestore
  void _updateCounts(bool wantToOrder) async {
    try {
      // Reference to the document in Firestore
      DocumentReference<Map<String, dynamic>> docRef =
          FirebaseFirestore.instance.collection('canteen').doc('order');

      // Update counts based on user selection
      if (wantToOrder) {
        await docRef.update({'orderCount': FieldValue.increment(1)});
      } else {
        await docRef.update({'noOrderCount': FieldValue.increment(1)});
      }

      // Update counts in the UI
      _fetchCounts();
    } catch (error) {
      print('Error updating counts: $error');
    }
  }

  // Function to show the order dialog
  void _showOrderDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        bool? _userChoice;

        return AlertDialog(
          title: Text('Order Food'),
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  RadioListTile(
                    title: Text('Yes'),
                    value: true,
                    groupValue: _userChoice,
                    onChanged: (bool? value) {
                      setState(() {
                        _userChoice = value;
                      });
                    },
                  ),
                  RadioListTile(
                    title: Text('No'),
                    value: false,
                    groupValue: _userChoice,
                    onChanged: (bool? value) {
                      setState(() {
                        _userChoice = value;
                      });
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (_userChoice != null) {
                        Navigator.of(context).pop();
                        _updateCounts(_userChoice!);
                      }
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.green,
                      elevation: 30,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      padding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 30,
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Your Food"),
        backgroundColor: Color.fromARGB(255, 162, 245, 165),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: _showOrderDialog,
                child: Text(
                  'Order Food',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green,
                  elevation: 30,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 15,
                    horizontal: 30,
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 137, 224, 182), // Set background color to accent green
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Users who need food: $orderCount',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black, // Text color
                  ),
                ),
              ),
              SizedBox(height: 20),
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 137, 224, 182), // Set background color to accent green
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  'Users who don\'t need food: $noOrderCount',
                  style: TextStyle(fontSize: 16,
                  fontWeight: FontWeight.bold,
                      color: Colors.black,),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
