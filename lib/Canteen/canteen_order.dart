import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    // Call a function to fetch counts from Firestore
    _fetchCounts();
  }

  // Function to fetch counts from Firestore
  void _fetchCounts() async {
    try {
      // Reference to the document in Firestore
      DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection('canteen').doc('order').get();

      // Retrieve the counts from the document
      setState(() {
        orderCount = (snapshot.data()?['orderCount'] ?? 0) as int;
        noOrderCount = (snapshot.data()?['noOrderCount'] ?? 0) as int;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Order Your Food"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Do you want to order food?',
              style: TextStyle(fontSize: 18),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Radio(
                  value: true,
                  groupValue: orderCount,
                  onChanged: (value) {
                    _updateCounts(true);
                  },
                ),
                Text('Yes'),
                Radio(
                  value: false,
                  groupValue: orderCount,
                  onChanged: (value) {
                    _updateCounts(false);
                  },
                ),
                Text('No'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'No of Orders: $orderCount',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Text(
              'Users who don\'t need food: $noOrderCount',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
