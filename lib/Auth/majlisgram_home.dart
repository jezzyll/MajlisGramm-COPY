import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter_application_111_copy/Canteen/canteen_main_screen.dart';
import 'package:flutter_application_111_copy/Home_BottomNav/user_profile.dart';
import 'package:flutter_application_111_copy/Offiice/office_Home.dart';
import 'package:flutter_application_111_copy/Staff/staffHome.dart';
import 'package:flutter_application_111_copy/Union/union_home.dart';

final List<String> imageUrls = [
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWw2pFaWpErThq2KE3QcR78LnElpJfCxfD_g&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQFQzqiYlQX1SjI-ClavKcMupJZE3J6z_WH3FY7rNFkZWPELz8i587b-UXEQXLHolmHhyI&usqp=CAU',
  'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSepDC04oQVpXOT_Hg_ecrSMC4_5C_gwqV2A&usqp=CAU',
];

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
        backgroundColor: Colors.green,
      ),
      body: Stack(
        children: [
          Positioned(
            width: MediaQuery.of(context).size.width,
            bottom: 0,
            child: Opacity(
              opacity: 0.6,          
              child: Image.asset(
                "assets/images/majlisgramHome.png", 
                height: 400,
                fit: BoxFit.cover,
              ),
            ),
          ),
          _getBody(_selectedIndex),
        ],
      ),
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
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StaffHomePage()),
            );
          },
          onUnionTapped: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => unionHomePage()),
            ).then((value) {
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
        return UserProfilePage(userId: '9JAKYeQUoLf9CWP0p3mF');
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
  final VoidCallback? onBankTapped;
  final VoidCallback? onMoreTapped;

  const MajlisgramHomePage({
    Key? key,
    this.onOfficeTapped,
    this.onStaffTapped,
    this.onUnionTapped,
    this.onHostelTapped,
    this.onLibraryTapped,
    this.onCanteenTapped,
    this.onBankTapped,
    this.onMoreTapped,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Container(
            height: 200, // Set a specific height for the CarouselSlider
            child: CarouselSlider(
              items: imageUrls
                  .map(
                    (url) => ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            url,
                            fit: BoxFit.cover,
                          ),
                        ],
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                autoPlay: true,
                scrollPhysics: const BouncingScrollPhysics(),
                aspectRatio: 2,
                viewportFraction: 1,
              ),
            ),
          ),
          Divider(
            color: Colors.white,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSquare(Icons.business, 'Office', onOfficeTapped),
                    _buildSquare(Icons.people, 'Staff', onStaffTapped),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSquare(Icons.group, 'Union', onUnionTapped),
                    _buildSquare(Icons.apartment, 'Hostel', onHostelTapped),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSquare(Icons.book, 'Library', onLibraryTapped),
                    _buildSquare(Icons.fastfood, 'Canteen', onCanteenTapped),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSquare(Icons.account_balance, 'Bank', onBankTapped),
                    _buildSquare(Icons.more_horiz, 'More', onMoreTapped),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSquare(
    IconData icon,
    String title,
    VoidCallback? onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        color: Color.fromARGB(255, 3, 167, 38), // Changed card color
        child: Container(
          width: 150,
          height: 100,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 40,
                color: Colors.white,
              ),
              SizedBox(height: 8),
              Text(
                title,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
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
