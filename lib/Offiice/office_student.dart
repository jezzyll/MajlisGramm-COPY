import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() {
  runApp(OfficeStudentFee());
}

class OfficeStudentFee extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Student Fee App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: StudentFeePage(),
    );
  }
}

class StudentFeePage extends StatefulWidget {
  @override
  _StudentFeePageState createState() => _StudentFeePageState();
}

class _StudentFeePageState extends State<StudentFeePage> {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  List<List<String>> gridData = [[]];

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    QuerySnapshot snapshot = await firestore.collection('').get();
    setState(() {
      gridData = snapshot.docs.map((doc) => List<String>.from(doc[''])).toList();
    });
  }

  void _addRow() {
    setState(() {
      gridData.add(List.filled(gridData[0].length, ""));
    });
  }

  void _addColumn() {
    setState(() {
      for (int i = 0; i < gridData.length; i++) {
        gridData[i].add("");
      }
    });
  }

  void _updateCell(int rowIndex, int colIndex, String newValue) {
    setState(() {
      gridData[rowIndex][colIndex] = newValue;
    });
    _saveData();
  }

  void _saveData() {
    for (int i = 0; i < gridData.length; i++) {
      firestore.collection('fee_data').doc('row_$i').set({'row': gridData[i]});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Fee Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: gridData.length,
              itemBuilder: (context, rowIndex) {
                return Row(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: gridData[rowIndex].length,
                        itemBuilder: (context, colIndex) {
                          return Container(
                            padding: EdgeInsets.all(8.0),
                            decoration: BoxDecoration(
                              border: Border.all(),
                            ),
                            child: TextFormField(
                              initialValue: gridData[rowIndex][colIndex],
                              onChanged: (newValue) {
                                _updateCell(rowIndex, colIndex, newValue);
                              },
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: _addRow,
                child: Text('Add Row'),
              ),
              ElevatedButton(
                onPressed: _addColumn,
                child: Text('Add Column'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
