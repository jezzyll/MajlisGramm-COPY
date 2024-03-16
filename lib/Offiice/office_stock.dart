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

  Future<void> _deleteItem(DocumentSnapshot document) async {
    try {
      await _firestore.collection('office_stock').doc(document.id).delete();
    } catch (e) {
      print('Error deleting item: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Office Stock'),
        backgroundColor: Colors.green,
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(20.0),
            color: Colors.green[100], // Added background color for input section
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
                  style: ElevatedButton.styleFrom(
                    primary: Colors.green, // Changed button color to green
                    onPrimary: Colors.white, // Changed text color to white
                    elevation: 5,
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
                  return Center(child: CircularProgressIndicator());
                }

                return ListView(
                  children: snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data = document.data() as Map<String, dynamic>;
                    return Dismissible(
                      key: Key(document.id),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        alignment: AlignmentDirectional.centerEnd,
                        color: Colors.red,
                        child: Padding(
                          padding: EdgeInsets.fromLTRB(0.0, 0.0, 10.0, 0.0),
                          child: Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      onDismissed: (direction) {
                        _deleteItem(document);
                      },
                      child: Card(
                        color: Colors.green[100], // Added background color for each tile
                        child: ListTile(
                          title: Text(data['item_name']),
                          subtitle: Text('Stock: ${data['stock']}'),
                        ),
                      ),
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
