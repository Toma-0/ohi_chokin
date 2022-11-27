import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'main.dart';

class Login extends StatefulWidget {
  @override
  _Login createState() => _Login();
}

class _Login extends State<Login> {
  FirebaseDatabase database = FirebaseDatabase.instance;
  String newUserEmail = "";
  // 入力されたパスワード
  String newUserPassword = "";

  String newUserOshi = "";

  // 入力されたメールアドレス（ログイン）
  String loginUserEmail = "";
  // 入力されたパスワード（ログイン）
  String loginUserPassword = "";
  // 登録・ログインに関する情報を表示
  String infoText = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(32),
          child: Column(
            children: <Widget>[
              const SizedBox(height: 32),
              TextFormField(
                decoration: InputDecoration(labelText: "メールアドレス"),  
                onChanged: (String value) {
                  setState(() {
                    newUserEmail = value;
                  });
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: "パスワード（６文字以上）"),
                // パスワードが見えないようにする
                obscureText: true,
                onChanged: (String value) {
                  setState(() {
                    newUserPassword = value;
                  });
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: "最初に登録する推しの名前"),
                onChanged: (String value) {
                  setState(() {
                    newUserOshi = value;
                  });
                },
              ),
              ElevatedButton(
                onPressed: () async {
                  try {
                    // メール/パスワードでユーザー登録
                    final FirebaseAuth auth = FirebaseAuth.instance;
                    final UserCredential result =
                        await auth.createUserWithEmailAndPassword(
                      email: newUserEmail,
                      password: newUserPassword,
                    );

                    // 登録したユーザー情報
                    final User user = result.user!;
                    setState(() {
                      infoText = "登録OK：${user.email}";
                    });
                    newDate(newUserOshi);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                    );
                  } catch (e) {
                    // 登録に失敗した場合
                    setState(() {
                      infoText = "登録NG：${e.toString()}";
                    });
                  }
                },
                child: Text("ユーザー登録"),
              ),
              const SizedBox(height: 8),
              Text(infoText),
              const SizedBox(height: 8),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => MyApp()),
                    );
                  },
                  child: Text("ログインはこちら")),
            ],
          ),
        ),
      ),
    );
  }

  void newDate(Oshi) {
    final userID = FirebaseAuth.instance.currentUser?.uid ?? '';
    DatabaseReference postListRef = FirebaseDatabase.instance.ref("users");
    DatabaseReference newPostRef = postListRef.push();
    postListRef.set({
      userID: {
        "OshiFile":{
          "deta_count":0,
        0: {
          "name":Oshi,
          "Target": 10000,
          "color": "Colors.blue.withOpacity(0.6)",
          "icon": 0,
          "money": 0,
        }
        }
      }
    });
  }
}
