import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import './config/size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './chokin.dart';
import './syukkin.dart';
import './setting.dart';
import './ohi.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';

class Home extends StatefulWidget {
  @override
  _Home createState() => _Home();
}

class _Home extends State<Home> with SingleTickerProviderStateMixin {
  List l_color = [];
  List l_icon = [];
  List l_name = [];
  List l_Target = [];
  List l_money = [];
  bool sliderClose = true;
  double t = 150;
  bool isVisible = true;
  late AnimationController waveController;
  @override
  void initState() {
    waveController = AnimationController(
      duration: const Duration(seconds: 10), // アニメーションの間隔を3秒に設定
      vsync: this, // おきまり
    )..repeat(); // リピート設定

    super.initState();
  }

  @override
  void dispose() {
    waveController.dispose(); // AnimationControllerは明示的にdisposeする。
    super.dispose();
  }

  void toggleShowText() {
    isVisible = !isVisible;
  }

  Widget creatCard(name, icon, c, BuildContext context) {
    SizeConfig().init(context);
    return TextButton(
      style: TextButton.styleFrom(),
      onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => OhiPage()),
        );
      },
      child: Card(
        elevation: 0,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Container(
          width: SizeConfig.bw * 17,
          height: SizeConfig.bh * 5,
          child: Stack(children: [
            Icon(
              icon,
              color: c,
              size: 36.0,
            ),
            Center(
              child: Padding(
                padding: EdgeInsets.only(top: SizeConfig.bh * 0.5),
                child: Text(name),
              ),
            ),
          ]),
        ),
      ),
    );
  }

  Widget nomal(BuildContext context) {
    int i = 0;
    SizeConfig().init(context);
    ReadDate();
    return Container(
      height: SizeConfig.bh * 22,
      width: SizeConfig.bw * 90,
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(color: Color.fromARGB(255, 87, 87, 87)),
          left: BorderSide(color: Color.fromARGB(255, 87, 87, 87)),
          right: BorderSide(color: Color.fromARGB(255, 87, 87, 87)),
        ),
        color: Color.fromARGB(255, 241, 241, 241),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.only(left: SizeConfig.bw * 1.5),
          ),
          for (final Inname in l_name)
            creatCard(
                l_name[l_name.indexOf(Inname)],
                l_icon[l_name.indexOf(Inname)],
                l_color[l_name.indexOf(Inname)],
                context),
          Padding(
            padding: EdgeInsets.only(right: SizeConfig.bw * 1.5),
          ),
        ],
      ),
    );
  }

  void signal(int index) {
    if (index == 4) {
      Padding(
        padding: EdgeInsets.only(right: SizeConfig.bw * 1.5),
      );
    }
  }

  void ReadDate() {
    final userID = FirebaseAuth.instance.currentUser?.uid ?? '';
    DatabaseReference postListRef_num =
        FirebaseDatabase.instance.ref(userID + "OshiFile");
    postListRef_num.onValue.listen((DatabaseEvent event) {
      for (final child in event.snapshot.children) {
        int count = event.snapshot.child("deta_count").value as int;

        for (int i = 0; i < count; i++) {
          DatabaseReference postListRef = FirebaseDatabase.instance
              .ref(userID + "/OshiFile/" + i.toString());
          //DatabaseReference newPostRef = postListRef.push();
          postListRef.onValue.listen((DatabaseEvent event) {
            for (final child in event.snapshot.children) {
              String name = event.snapshot.child("name").value as String;
              l_name.insert(i, name);
              int Target = event.snapshot.child("Target").value as int;
              l_Target.insert(i, Target);
              String color = event.snapshot.child("color").value as String;
              l_color.insert(i, color);
              String icon = event.snapshot.child("icon").value as String;
              l_icon.insert(i, icon);
              int money = event.snapshot.child("money").value as int;
              l_money.insert(i, money);
            }
          }, onError: (error) {
            // Error.
          });
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: SlidingUpPanel(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Color.fromARGB(255, 141, 141, 141)),
        minHeight: SizeConfig.bh * 5,
        maxHeight: SizeConfig.bw * 60,
        onPanelOpened: () {
          setState(() {
            t = SizeConfig.bh * 10;
          });
        },
        onPanelClosed: () {
          setState(() {
            t = SizeConfig.bh * 20;
          });
        },
        panel: Container(
          child: Column(
            children: <Widget>[
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.bh * 2),
              ),
              Card(
                child: Container(
                  color: Color.fromARGB(255, 176, 175, 175),
                  width: SizeConfig.bw * 18,
                  height: SizeConfig.bh * 0.5,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: SizeConfig.bh * 2),
              ),
              if (isVisible == true) nomal(context),
            ],
          ),
        ),
        body: Container(
          child: Column(
            children: [
              Padding(
                child: Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                          padding: EdgeInsets.only(left: SizeConfig.bw * 2)),
                      Container(
                        height: SizeConfig.bh * 10,
                        width: SizeConfig.bw * 8,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: AssetImage("images/black.jpeg"),
                          ),
                        ),
                      ),
                      Padding(
                          padding: EdgeInsets.only(left: SizeConfig.bw * 2)),
                      Text("ユーザー名"), //ユーザーネーム

                      Padding(
                          padding: EdgeInsets.only(left: SizeConfig.bw * 55)),

                      IconButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SettingPage()),
                          );
                        },
                        icon: Icon(Icons.settings),
                      ),
                    ],
                  ),
                ),
                padding: EdgeInsets.only(
                    top: SizeConfig.bh * 5, bottom: SizeConfig.bw * 5),
              ),
              Padding(
                padding: EdgeInsets.only(top: t),
              ),
              Align(
                alignment: Alignment.center,
                child: Container(
                  width: SizeConfig.bw * 99,
                  height: SizeConfig.bh * 30,
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      PieChart(
                        PieChartData(
                          startDegreeOffset: 270,
                          centerSpaceRadius: SizeConfig.bw * 0,
                          sections: [
                            PieChartSectionData(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 0),
                              color: Colors.black,
                              value: 19 / 24 * 100,
                              radius: SizeConfig.bw * 34,
                              title: '',
                            ),
                            PieChartSectionData(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 0),
                              color: Colors.white,
                              value: 5 / 24 * 100,
                              radius: SizeConfig.bw * 34,
                              title: '',
                            ),
                          ],
                          sectionsSpace: 0,
                        ),
                      ),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(top: 0),
                              child: Container(
                                clipBehavior: Clip.antiAlias,
                                width: SizeConfig.bw * 90,
                                height: SizeConfig.bw * 90,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.white,
                                ),
                                child: AnimatedBuilder(
                                  animation:
                                      waveController, // waveControllerを設定
                                  builder: (context, child) => Stack(
                                    children: <Widget>[
                                      // 1つ目の波
                                      ClipPath(
                                        child: Container(
                                            color: Colors.transparent),
                                        clipper: WaveClipper(
                                            context, waveController.value, 0),
                                      ),
                                      // 2つ目の波
                                      ClipPath(
                                        child: Container(
                                            color: Colors.transparent
                                                .withOpacity(0.6)),
                                        clipper: WaveClipper(
                                            context, waveController.value, 0.5),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class WaveClipper extends CustomClipper<Path> {
  WaveClipper(this.context, this.waveControllerValue, this.offset) {
    final width = MediaQuery.of(context).size.width; // 画面の横幅
    final height = MediaQuery.of(context).size.height - 800; // 画面の高さ

    // coordinateListに波の座標を追加
    for (var i = 0; i <= width / 3; i++) {
      final step = (i / width) - waveControllerValue;
      coordinateList.add(
        Offset(
          i.toDouble() * 3, // X座標
          height * 0.5 - math.sin(step * 2 * math.pi - offset) * 45, // Y座標
        ),
      );
    }
  }

  final BuildContext context;
  final double waveControllerValue; // waveController.valueの値
  final double offset; // 波のずれ
  final List<Offset> coordinateList = []; // 波の座標のリスト

  @override
  Path getClip(Size size) {
    final path = Path()
      // addPolygon: coordinateListに入っている座標を直線で結ぶ。
      //             false -> 最後に始点に戻らない
      ..addPolygon(coordinateList, false)
      ..lineTo(size.width, 0.0) // 画面右下へ
      ..lineTo(0, 0.0) // 画面左下へ
      ..close(); // 始点に戻る
    return path;
  }

  // 再クリップするタイミング -> animationValueが更新されていたとき
  @override
  bool shouldReclip(WaveClipper oldClipper) =>
      waveControllerValue != oldClipper.waveControllerValue;
}
