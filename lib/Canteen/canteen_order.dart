import 'package:flutter/material.dart';

class CanteenOrderFood extends StatefulWidget {
  const CanteenOrderFood({super.key});

  @override
  State<CanteenOrderFood> createState() => _CanteenOrderFoodState();
}

class _CanteenOrderFoodState extends State<CanteenOrderFood> {
  int noOrderCount = 0;
  bool wantToOrder = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("order you food"),
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
                  groupValue: wantToOrder,
                  onChanged: (value) {
                    setState(() {
                      wantToOrder = value!;
                      if (wantToOrder) {
                        noOrderCount = 0;
                      }
                    });
                  },
                ),
                Text('Yes'),
                Radio(
                  value: false,
                  groupValue: wantToOrder,
                  onChanged: (value) {
                    setState(() {
                      wantToOrder = value!;
                      if (!wantToOrder) {
                        noOrderCount = 1;
                      }
                    });
                  },
                ),
                Text('No'),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Order Count: ${wantToOrder ? 1 : 0}',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'Users who don\'t need food: $noOrderCount',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }
}