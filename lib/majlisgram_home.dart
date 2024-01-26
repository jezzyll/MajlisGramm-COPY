
import 'package:flutter/material.dart';

class MajlisgramHome extends StatelessWidget {
  const MajlisgramHome({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        title: Text("MajlisGram"),
      ),

      body: Column(
        children: [
          //above section
           Expanded(
            flex: 2,
            child: Container(
              color: Colors.blue, // Change color as needed
              child: Center(
                child: Text(
                  'Above Section',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
          Divider(),
          //below section
          Expanded(
            flex: 4,
            child: Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildRedSquare(),
                  _buildRedSquare(),
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildRedSquare(),
                  _buildRedSquare(),
                  
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildRedSquare(),
                  _buildRedSquare(),
                  
                ],
              ),
            ],
                
              ),
            ),
          ),
        ],
      ),
    );
  }

Widget _buildRedSquare() {
    return Card(
      child: Container(
        width: 150,
        height: 100,
        color: Colors.red,
      ),
    );
  }
        


}