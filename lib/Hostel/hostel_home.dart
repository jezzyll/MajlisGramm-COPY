import 'package:flutter/material.dart';

// Room class to represent each room
class Room {
  final String name;
  final String description;

  Room(this.name, this.description);
}

// List of rooms
List<Room> rooms = [
  Room("Room 1", "THAMHEEDIYYA ULA"),
  Room("Room 2", "THAMHEEDIYYA ULA"),
  Room("Room 3", "THAMHEEDIYYA SANIYA"),
  Room("Room 4", "THAMHEEDIYYA SANIYA"),
  Room("Room 5", "ALIYA ULA"),
  Room("Room 6", "ALIYA ULA"),
  Room("Room 7", "ALIYA SANIYA"),
  Room("Room 8", "ALIYA SANIYA"),
  Room("Room 9", "ALIYA SALISA"),
  Room("Room 0", "ALIYA SALISA"),
  Room("Room 11", "ALIYA RABIA"),
  Room("Room 12", "ALIYA RABIA"),
];

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Hostel App',
      theme: ThemeData(
        primaryColor: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity, colorScheme: ColorScheme.fromSwatch().copyWith(secondary: Colors.green),
      ),
      home: HostelHomePage(),
    );
  }
}

class HostelHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Hostel Rooms'),
      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 10.0,
          crossAxisSpacing: 10.0,
          childAspectRatio: 0.75, // You can adjust this aspect ratio as needed
        ),
        itemCount: rooms.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              if (index == 0) { // Assuming Room 1 is at index 0
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => FirstRoomPage()),
                );
              }
            },
            child: RoomTile(room: rooms[index]),
          );
        },
      ),
    );
  }
}

class RoomTile extends StatelessWidget {
  final Room room;

  RoomTile({required this.room});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              room.name,
              style: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 8.0),
            Text(
              room.description,
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class FirstRoomPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(appBar: AppBar(
        title: Text(
          'Hostel Room    1 ',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          DataTable(
            columns: [
              DataColumn(
                label: Text(
                  'ID',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
              DataColumn(
                label: Text(
                  'Name',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                ),
              ),
            ],
            rows: [
              DataRow(cells: [
                DataCell(Text('1001')),
                DataCell(Text('Salih')),
              ]),
              DataRow(cells: [
                DataCell(Text('1002')),
                DataCell(Text('Jazeel')),
              ]),
              DataRow(cells: [
                DataCell(Text('1003')),
                DataCell(Text('Sinan')),
              ]),
              DataRow(cells: [
                DataCell(Text('1004')),
                DataCell(Text('Anshad')),
              ]),
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                // Add logic for the action to be performed when the button is pressed
              },
              child: Icon(Icons.add),
              style: ElevatedButton.styleFrom(
                foregroundColor: Colors.white,
                backgroundColor: Colors.green,
                elevation: 30,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                padding: EdgeInsets.symmetric(
                  vertical: 15,
                  horizontal: 30,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
