import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class SyukkinPage extends StatelessWidget {
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
        height: double.infinity,
        color: Colors.white,
      ),
    );
  }
}

void newDate(Oshi, title) {
  final userID = FirebaseAuth.instance.currentUser?.uid ?? '';
  DatabaseReference postListRef = FirebaseDatabase.instance
      .ref("users/" + userID + "/" + Oshi + "/syukkin");
  //DatabaseReference newPostRef = postListRef.push();
  postListRef.set(
    {
      title: {"data": 10.12, "how_money": "何円引き出すのか", "title": "何に引き出すのか"}
    },
  );
}
