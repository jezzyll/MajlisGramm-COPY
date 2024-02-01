

import 'package:flutter/material.dart';

class OfficeStockPage extends StatefulWidget {
  @override
  _StudentFeePageState createState() => _StudentFeePageState();
}

class _StudentFeePageState extends State<OfficeStockPage> {
  List<List<String>> gridData = List.generate(10, (_) => List.filled(10, ""));

  void addRow() {
    setState(() {
      gridData.add(List.filled(gridData[0].length, ""));
    });
  }

  final growableList = List.empty(growable: true);


  void addColumn() {
    setState(() {
      for (int i = 0; i < gridData.length; i++) {
        gridData[i].add("");
      }
    });
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
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridData[0].length,
              ),
              itemCount: gridData.length * gridData[0].length,
              itemBuilder: (context, index) {
                int rowIndex = index ~/ gridData[0].length;
                int colIndex = index % gridData[0].length;
                return Container(
                  decoration: BoxDecoration(
                    border: Border.all(),
                  ),
                  child: Center(
                    child: Text(gridData[rowIndex][colIndex]),
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton(
                onPressed: addRow,
                child: Text('Add Row'),
              ),
              ElevatedButton(
                onPressed: addColumn,
                child: Text('Add Column'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}