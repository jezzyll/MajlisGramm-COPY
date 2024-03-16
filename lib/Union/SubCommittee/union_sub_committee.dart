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
          title: Text('Sub-Committees'),
          backgroundColor: Colors.green,
        ),
        
        body: ListView(
          children: [
            _buildSubcommitteeTile(
              title: 'FINE ARTS',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Unionfinearts()),
                );
              },
            ),
            _buildSubcommitteeTile(
              title: 'LITERARY',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UnionLiterary()),
                );
              },
            ),
            _buildSubcommitteeTile(
              title: 'RESEARCH',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UnionResearch()),
                );
              },
            ),
            _buildSubcommitteeTile(
              title: 'GARDEN',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UnionGarden()),
                );
              },
            ),
            _buildSubcommitteeTile(
              title: 'SOCIAL AFFAIRS',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UnionSocialAffairs()),
                );
              },
            ),
            _buildSubcommitteeTile(
              title: 'BANK',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UnionSocialAffairs()),
                );
              },
            ),
            
            _buildSubcommitteeTile(
              title: 'PRD',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UnionPrd()),
                );
              },
            ),
            _buildSubcommitteeTile(
              title: 'STORE',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UnionStore()),
                );
              },
            ),
            _buildSubcommitteeTile(
              title: 'SPORTS',
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => UnionSports()),
                );
              },
            ),
            // Add other subcommittee tiles similarly
          ],
        ),
      ),
    );
  }

  Widget _buildSubcommitteeTile({required String title, required VoidCallback onTap}) {
    return Card(
      color: Colors.green, // Set background color to green
      child: ListTile(
        title: Text(
          title,
          style: TextStyle(color: Colors.white),
        ), // Set text color to white
        onTap: onTap,
      ),
    );
  }
}
