import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Union/SubCommittee/union_literary.dart';
import 'package:flutter_application_111_copy/Union/SubCommittee/union_sub_committee.dart';

class UnionGarden extends StatelessWidget {
  const UnionGarden({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "UnionGarden",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Center(child: Text("Garden")),
        ),
        body: SingleChildScrollView(child: Body()),
      ),
    );
  }
}

class Body extends StatefulWidget {
  const Body({Key? key}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<String> items = [
    'https://img.freepik.com/free-vector/christmas-background-flat-design_52683-47609.jpg?size=626&ext=jpg&ga=GA1.1.648074344.1702646045&semt=ais',
    'https://img.freepik.com/free-vector/christmas-background-with-realistic-decoration_52683-30774.jpg?size=626&ext=jpg&ga=GA1.1.648074344.1702646045&semt=ais',
    'https://img.freepik.com/free-vector/merry-christmas-wallpaper-design_79603-2129.jpg?size=626&ext=jpg&ga=GA1.1.648074344.1702646045&semt=ais',
    'https://img.freepik.com/free-vector/merry-christmas-lettering-with-pine-leaves_52683-30638.jpg?size=626&ext=jpg&ga=GA1.1.648074344.1702646045&semt=ais',
  ];

  List<String> textFields = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Notice",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        SizedBox(height: 10,),
        CarouselSlider(
          items: items.map((e) => ClipRRect(
            borderRadius: BorderRadius.circular(6),
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.network(
                  e,
                  height: 200,
                  width: 100,
                  fit: BoxFit.cover,
                ),
              ],
            ),
          )).toList(),
          options: CarouselOptions(
            autoPlay: true,
            enableInfiniteScroll: false,
            enlargeCenterPage: true,
            height: 150
          )
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "Committee Members",
            style: TextStyle(
              color: Colors.red,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
        ),
        Column(
          children: [
            for (int i = 0; i < items.length; i++)
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 70,
                      backgroundImage: AssetImage('assets/images/me.jpg'),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Your Name',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        onChanged: (value) {
                          textFields[i] = value;
                        },
                        decoration: InputDecoration(
                          hintText: 'Enter text here...',
                          border: InputBorder.none,
                        ),
                        maxLines: null,
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            setState(() {
              textFields.add('');
            });
          },
          child: Text('Add'),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: () {
            // Add code here to store textFields to Firestore
          },
          child: Text('Submit'),
        ),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UnionSubcommittee()),
                );
              },
              child: Text('Back'),
            ),
            SizedBox(width: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UnionLiterary()),
                );
              },
              child: Text('Next'),
            ),
          ],
        ),
      ],
    );
  }
}
