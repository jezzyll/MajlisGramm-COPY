import 'package:flutter/material.dart';

class OfficeStockPage extends StatefulWidget {
  @override
  _OfficeStockPageState createState() => _OfficeStockPageState();
}



class _OfficeStockPageState extends State<OfficeStockPage> {
  List<List<String>> gridData = List.generate(10, (_) => List.filled(10, ""));

  

  void addRow() {
    setState(() {
      gridData.add(List.filled(gridData[0].length, ""));
    });
  }

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
        title: Text('Office Stock Page'),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  columns: List.generate(
                    gridData[0].length,
                    (index) => DataColumn(label: Text('Column $index')),
                  ),
                  rows: List.generate(
                    gridData.length,
                    (index) => DataRow(
                      cells: List.generate(
                        gridData[index].length,
                        (cellIndex) => DataCell(
                          TextFormField(
                            initialValue: gridData[index][cellIndex],
                            onChanged: (newValue) {
                              setState(() {
                                gridData[index][cellIndex] = newValue;
                              });
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
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
