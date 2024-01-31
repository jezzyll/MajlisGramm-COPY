import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Union/SubCommittee/union_finearts.dart';
import 'package:flutter_application_111_copy/Union/SubCommittee/union_sub_committee.dart';


void main()=> runApp(UnionMedical());

class UnionMedical extends StatelessWidget {
  const UnionMedical({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "UnionMedical",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Center(child: Text("Medical"))
          ),
          body: SingleChildScrollView(child: Body()),
        ));
  }
}

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<String> Items=[
    'https://img.freepik.com/free-vector/christmas-background-flat-design_52683-47609.jpg?size=626&ext=jpg&ga=GA1.1.648074344.1702646045&semt=ais',
    'https://img.freepik.com/free-vector/christmas-background-with-realistic-decoration_52683-30774.jpg?size=626&ext=jpg&ga=GA1.1.648074344.1702646045&semt=ais',
    'https://img.freepik.com/free-vector/merry-christmas-wallpaper-design_79603-2129.jpg?size=626&ext=jpg&ga=GA1.1.648074344.1702646045&semt=ais',
    'https://img.freepik.com/free-vector/merry-christmas-lettering-with-pine-leaves_52683-30638.jpg?size=626&ext=jpg&ga=GA1.1.648074344.1702646045&semt=ais',
  ];
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text("Notice",
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  )),
        ),
        SizedBox(height: 10,),
        CarouselSlider(items: Items.map((e) => ClipRRect(
          borderRadius: BorderRadius.circular(6),
          child: Stack(
            fit: StackFit.expand,
            children: [
              Image.network(e,
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
          child: Text("Committee Members",
           style: TextStyle(
            color: Colors.red,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
           ),
           ),
        ),
        Padding(
 padding: const EdgeInsets.fromLTRB(8, 20, 200, 50),
 child: CircleAvatar(
    radius: 70,
    backgroundImage: AssetImage('assets/images/me.jpg'),
 ),
),
Padding(
 padding: EdgeInsets.fromLTRB(20, 0, 200, 100),
 child: Column(
    children: [
      Padding(
        padding: const EdgeInsets.all(10.0),
        child: CircleAvatar(
          radius: 70,
          backgroundImage: AssetImage('assets/images/PSC1.jpg'),
        ),
      ),
      ],
    )
    ),
    Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: ElevatedButton(
                    child: Text('Back'),
                    onPressed: () {
                      Navigator.push(context, 
            MaterialPageRoute(builder: (context) => UnionSubcommittee(),
            ),
            );
                    },
                    ),
            ),
           ElevatedButton( 
          child: Text('Next'),
          onPressed: () {
            Navigator.push(context, 
            MaterialPageRoute(builder: (context) => Unionfinearts(),
            ),
            );
          },
          ),
              ],
              ),
    ]
    );
  }
}