import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class MenuItemsPage extends StatefulWidget {
  final String day;
  MenuItemsPage({required this.day});

  @override
  _MenuItemsPageState createState() => _MenuItemsPageState();
}

class _MenuItemsPageState extends State<MenuItemsPage> {
  late TextEditingController _addItemController;
  late CollectionReference _menuCollection;

  @override
  void initState() {
    super.initState();
    _addItemController = TextEditingController();
    _menuCollection = FirebaseFirestore.instance.collection('menu');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Menu for ${widget.day}'),
        backgroundColor: Colors.green,
      ),
      body: StreamBuilder<DocumentSnapshot>(
        stream: _menuCollection.doc(widget.day).snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (!snapshot.hasData || snapshot.data!.data() == null) {
            return Center(child: Text('No menu items available'));
          } else {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            List<dynamic> items = data['items'];
            return ListView.builder(
              itemCount: items.length,
              itemBuilder: (context, index) {
                return Card(
                  color: Colors.green[100], // Set background color to green-related color
                  child: ListTile(
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20), // Adjust padding
                    title: Text(items[index]),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        _deleteItemFromMenu(items[index]);
                      },
                    ),
                    // Add more details or customize UI for each menu item here
                  ),
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _showAddItemDialog,
        tooltip: 'Add Item',
        backgroundColor: Colors.green, // Set background color to green
        child: Icon(Icons.add),
      ),
    );
  }

  Future<void> _showAddItemDialog() async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add New Item'),
          content: TextField(
            controller: _addItemController,
            decoration: InputDecoration(hintText: 'Enter item name'),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Add'),
              onPressed: () {
                _addItemToMenu(_addItemController.text);
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _addItemToMenu(String itemName) {
    _menuCollection.doc(widget.day).set({
      'items': FieldValue.arrayUnion([itemName]),
    }, SetOptions(merge: true));
  }

  void _deleteItemFromMenu(String itemName) {
    _menuCollection.doc(widget.day).update({
      'items': FieldValue.arrayRemove([itemName]),
    });
  }
}
