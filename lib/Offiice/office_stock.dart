import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OfficeStockPage extends StatefulWidget {
  @override
  _OfficeStockPageState createState() => _OfficeStockPageState();
}

class _OfficeStockPageState extends State<OfficeStockPage> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _itemNameController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  Future<void> _addItem(String itemName, int stock) async {
    try {
      await _firestore.collection('office_stock').add({
        'item_name': itemName,
        'stock': stock,
      });
    } catch (e) {
      print('Error adding item: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Office Stock'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _itemNameController,
                    decoration: InputDecoration(labelText: 'Item'),
                  ),
                ),
                SizedBox(width: 20),
                Expanded(
                  child: TextField(
                    controller: _stockController,
                    decoration: InputDecoration(labelText: 'Stock'),
                    keyboardType: TextInputType.number,
                  ),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () {
                    _addItem(_itemNameController.text, int.parse(_stockController.text));
                    _itemNameController.clear();
                    _stockController.clear();
                  },
                  child: Text('Add Stock'),
                ),
              ],
            ),
          ),
          Expanded(
            child: StreamBuilder(
              stream: _firestore.collection('office_stock').snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                }

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    return ListTile(
                      title: Text(data['item_name']),
                      subtitle: Text('Stock: ${data['stock']}'),
                    );
                  }).toList(),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _itemNameController.dispose();
    _stockController.dispose();
    super.dispose();
  }
}
