import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttershare/widgets/header.dart';
import 'package:fluttershare/widgets/progress.dart';

final userRef = Firestore.instance.collection('users');

class Timeline extends StatefulWidget {
  @override
  _TimelineState createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  void initState() {
    // createUser();
    // updateUser();
    // deleteUser();
    super.initState();
  }

  createUser() async {
    await userRef.add({
      'userName': 'Jeff',
      'postCount': 2,
      'isAdmin': false,
    });
  }

  updateUser() async {
    final doc = await userRef.document('-M4AOEmRSgZOD2-e0gsW').get();

    if(doc.exists) {
      doc.reference.updateData({
        'userName': 'Jeff3'
      });
    }
  }

  deleteUser() async {
    final DocumentSnapshot doc = await userRef.document('-M4AOEmRSgZOD2-e0gsW').get();

    if (doc.exists) {
      doc.reference.delete();
    }
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: header(context, isAppTitle: true),
      body: StreamBuilder<QuerySnapshot>(
        stream: userRef.snapshots(),
        builder: (context, snapshot) {
          if(!snapshot.hasData) {
            return circularProgress();
          } 
          final List<Text> children = snapshot.data.documents.map((doc) => Text(doc['userName'])).toList();

          return Container(
            child: ListView(
              children: children,
            )
          );
        }
      ),
    );
  }
}
