import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Canteen/canteen_main_screen.dart';
import 'package:flutter_application_111_copy/Offiice/office_Home.dart';

class MajlisgramHome extends StatefulWidget {
  const MajlisgramHome({Key? key}) : super(key: key);

  @override
  _MajlisgramHomeState createState() => _MajlisgramHomeState();
}

class _MajlisgramHomeState extends State<MajlisgramHome> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MajlisGram"),
      ),
      body: _getBody(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'Services',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Me',
          ),
        ],
      ),
    );
  }

  Widget _getBody(int index) {
    switch (index) {
      case 0:
        return MajlisgramHomePage(
          onCardTapped: () {
            // Navigate to Office Page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CanteenMainScreen()),
            );
          },
        );
      case 1:
        return ServicesPage();
      case 2:
        return MePage();
      default:
        return Container();
    }
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}

class MajlisgramHomePage extends StatelessWidget {
  final VoidCallback? onCardTapped;

  const MajlisgramHomePage({Key? key, this.onCardTapped}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Above section
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.blue,
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
        // Below section
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
                    _buildRedSquare('Office', onCardTapped),
                    _buildRedSquare('Staff', onCardTapped),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildRedSquare('Student', onCardTapped),
                    _buildRedSquare('Hostel', onCardTapped),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildRedSquare('Library', onCardTapped),
                    _buildRedSquare('Canteen', onCardTapped),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRedSquare(String title, VoidCallback? onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        child: Container(
          width: 150,
          height: 100,
          color: Colors.red,
          child: Center(
            child: Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Services Page'),
    );
  }
}

class MePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text('Me Page'),
    );
  }
}



void main() {
  runApp(MaterialApp(
    title: 'MajlisGram App',
    home: MajlisgramHome(),
  ));
}
