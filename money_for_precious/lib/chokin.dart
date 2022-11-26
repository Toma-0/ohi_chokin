import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'dentaku.dart';
import 'button.dart';

class ChokinPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.white,
          ),
          child: Container(
            child: Text(
              '<',
              style: TextStyle(
                color: Colors.black,
              ),
            ),
          ),
          onPressed: () {
            // 1つ前に戻る
            Navigator.pop(context);
          },
        ),
        title: Text("次のページ"),
      ),
      body: Container(
        child: Row(children: [
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DentakuPage()),
                );
              },
              child: Text("貯金する")),
          TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ButtonPage()),
                );
              },
              child: Text("出金する")),
        ]),
        height: double.infinity,
        color: Colors.white,
      ),
    );
  }
}

void newDate(Oshi, title) {
  final userID = FirebaseAuth.instance.currentUser?.uid ?? '';
  DatabaseReference postListRef =
      FirebaseDatabase.instance.ref("users/" + userID + "/" + Oshi + "/chokin");
  //DatabaseReference newPostRef = postListRef.push();
  postListRef.set({
    title: {
      "data": 10.12,
      "detale": "推しが尊かった理由の詳細",
      "how_money": 1000,
      "title": "推しが尊かった理由"
    }
  });
}
