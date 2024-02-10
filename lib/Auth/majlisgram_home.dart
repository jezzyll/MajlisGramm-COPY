import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Canteen/canteen_main_screen.dart';
import 'package:flutter_application_111_copy/Home_BottomNav/user_profile.dart';
import 'package:flutter_application_111_copy/Offiice/office_Home.dart';
import 'package:flutter_application_111_copy/Union/union_activity.dart';
import 'package:flutter_application_111_copy/Union/union_home.dart';

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
          onOfficeTapped: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => OfficeHomePage()),
            );
          },
          onStaffTapped: () {
            // Navigate to Staff Page
          },
          onUnionTapped: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => unionHomePage())).then((value) {
              setState(() {});
            });
          },
          onHostelTapped: () {
            // Navigate to Hostel Page
          },
          onLibraryTapped: () {
            // Navigate to Library Page
          },
          onCanteenTapped: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => CanteenMainScreen()),
            );
          },
        );
      case 1:
        return ServicesPage();
      case 2:
        return  UserProfilePage(userId: '9JAKYeQUoLf9CWP0p3mF',);
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
  final VoidCallback? onOfficeTapped;
  final VoidCallback? onStaffTapped;
  final VoidCallback? onUnionTapped;
  final VoidCallback? onHostelTapped;
  final VoidCallback? onLibraryTapped;
  final VoidCallback? onCanteenTapped;

  const MajlisgramHomePage({
    Key? key,
    this.onOfficeTapped,
    this.onStaffTapped,
    this.onUnionTapped,
    this.onHostelTapped,
    this.onLibraryTapped,
    this.onCanteenTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
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
                    _buildRedSquare('Office', onOfficeTapped),
                    _buildRedSquare('Staff', onStaffTapped),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildRedSquare('Union', onUnionTapped),
                    _buildRedSquare('Hostel', onHostelTapped),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildRedSquare('Library', onLibraryTapped),
                    _buildRedSquare('Canteen', onCanteenTapped),
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




void main() {
  runApp(MaterialApp(
    title: 'MajlisGram App',
    home: MajlisgramHome(),
  ));
}
