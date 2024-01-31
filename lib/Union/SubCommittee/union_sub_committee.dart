import 'package:flutter/material.dart';
import 'package:flutter_application_111_copy/Union/SubCommittee/union_finearts.dart';
import 'package:flutter_application_111_copy/Union/SubCommittee/union_garden.dart';
import 'package:flutter_application_111_copy/Union/SubCommittee/union_literary.dart';
import 'package:flutter_application_111_copy/Union/SubCommittee/union_prd.dart';
import 'package:flutter_application_111_copy/Union/SubCommittee/union_research.dart';
import 'package:flutter_application_111_copy/Union/SubCommittee/union_social_affairs.dart';
import 'package:flutter_application_111_copy/Union/SubCommittee/union_sports.dart';
import 'package:flutter_application_111_copy/Union/SubCommittee/union_store.dart';


void main() {
 runApp(UnionSubcommittee());
}

class UnionSubcommittee extends StatelessWidget {
 @override
 Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Sub-committees'),
        ),
        body: ListView(
          children: [
            ListTile(
              title: Text('LIBRARY'),
              onTap: () {
                print('LITERARY selected');
              },
            ),
            ListTile(
              title: Text('FINE ARTS'),
              onTap: () {
                Navigator.push(context, 
            MaterialPageRoute(builder: (context) => Unionfinearts(),
            ),
            );
              },
            ),
            ListTile(
              title: Text('BANK'),
              onTap: () {
                print('SOCIAL AFFAIRS selected');
              },
            ),
            ListTile(
              title: Text('RESEARCH'),
              onTap: () {
                Navigator.push(context, 
            MaterialPageRoute(builder: (context) => UnionResearch(),
            ),
            );
              },
            ),
            ListTile(
              title: Text('GARDEN'),
              onTap: () {
                Navigator.push(context, 
            MaterialPageRoute(builder: (context) => UnionGarden(),
            ),
            );
              },
            ),
             ListTile(
              title: Text('LITERARY'),
              onTap: () {
                Navigator.push(context, 
            MaterialPageRoute(builder: (context) => UnionLiterary(),
            ),
            );
              },
            ),
             ListTile(
              title: Text('IT'),
              onTap: () {
                Navigator.push(context, 
            MaterialPageRoute(builder: (context) => UnionPrd(),
            ),
            );
              },
            ),
             ListTile(
              title: Text('SOCIAL AFFAIRS'),
              onTap: () {
                Navigator.push(context, 
            MaterialPageRoute(builder: (context) => UnionSocialAffairs(),
            ),
            );
              },
            ),
             ListTile(
              title: Text('STORE'),
              onTap: () {
                Navigator.push(context, 
            MaterialPageRoute(builder: (context) => UnionStore(),
            ),
            );
              },
            ),
             ListTile(
              title: Text('SPORTS'),
              onTap: () {
                Navigator.push(context, 
            MaterialPageRoute(builder: (context) => UnionSports(),
            ),
            );
              },
            ),
          ],
        ),
      ),
    );
 }
}