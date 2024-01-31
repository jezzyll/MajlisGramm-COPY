import 'package:flutter/material.dart';

void main(){
  runApp(UnionACtivity());
}

class UnionACtivity extends StatelessWidget {
  const UnionACtivity({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Activities",
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Center(child: Text("Activities"))
          ),
          body: SingleChildScrollView(child: activity()),
        ));
  }
}

class activity extends StatefulWidget {
  const activity({super.key});

  @override
  State<activity> createState() => _activityState();
}

class _activityState extends State<activity> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
          children: [
            ListTile(
              title: Text('Arts'),
              onTap: () {
                Navigator.push(context, 
            MaterialPageRoute(builder: (context) => UnionACtivity(),
            ),
            );
              },
            ),
            ]
            ),
    );
  }
}
