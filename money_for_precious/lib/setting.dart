import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SettingPage extends StatelessWidget {
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
      ),
      body: Container(
        height: double.infinity,
        color: Colors.white,
      ),
    );
  }
}

void newDate(Oshi) {
    final userID = FirebaseAuth.instance.currentUser?.uid ?? '';
    DatabaseReference postListRef = FirebaseDatabase.instance.ref("users");
    //DatabaseReference newPostRef = postListRef.push();
    postListRef.set({
      userID: {
        "deta_count":1,
        "OshiFile":{
        Oshi: {
          "Target": 10000,
          "color": "green",
          "icon": "heart",
          "money": 0,
          "name": "推しの名前",
        }
        }
      }
    });
  }