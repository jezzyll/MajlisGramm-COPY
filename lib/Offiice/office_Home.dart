import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OfficeStudentFee extends StatelessWidget {
  final  CollectionReference users =
  FirebaseFirestore.instance.collection('users');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Student Fee Details'),
      ),
      body: StreamBuilder(
        stream: users.snapshots(), 
        builder: (context,AsyncSnapshot snapshot) {
          if (snapshot.hasData){
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context,Index){
                final DocumentSnapshot usersSnap = snapshot.data.docs[Index];
                return Text(usersSnap['name']);

              },
              );
          }
          return Container();
        }
        )
        
    );
  }
}
