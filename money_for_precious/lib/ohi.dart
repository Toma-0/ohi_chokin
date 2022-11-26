import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import './config/size_config.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import './chokin.dart';
import './syukkin.dart';
import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:firebase_database/firebase_database.dart';

class OhiPage extends StatefulWidget {
  @override
  _OhiPage createState() => _OhiPage();
}

class _OhiPage extends State<OhiPage> with SingleTickerProviderStateMixin {
  bool sliderClose = true;
  double t = SizeConfig.bh * 1.5;
  bool isVisible = true;  late AnimationController waveController;

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

  Widget creatCard(name, number, c, BuildContext context) {
    SizeConfig().init(context);
    return TextButton(
      style: TextButton.styleFrom(),
      onPressed: () {
        setState(toggleShowText);
      },
      child: Card(
        elevation: 0,
        color: Color.fromARGB(255, 255, 255, 255),
        child: Container(
          width: SizeConfig.bw * 22,
          height: SizeConfig.bh * 9,
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("images/oshi$number.PNG"),
                colorFilter: ColorFilter.mode(c, BlendMode.srcIn),
                scale: SizeConfig.bw * 2.5,
                fit: BoxFit.none,
              ),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.only(top: SizeConfig.bh),
                child: Text(name),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget nomal(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Column(children: [
        Padding(padding: EdgeInsets.only(top: SizeConfig.bh)),
        creatCard("うい", 0, Colors.red, context),
      ]),
    );
  }

  Widget push(BuildContext context) {
    SizeConfig().init(context);
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.only(top: SizeConfig.bh)),
          creatCard("うい", 0, Colors.blue, context),
          Padding(
            padding: EdgeInsets.only(right: SizeConfig.bw * 1.5),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ChokinPage()),
                    );
                  },
                  child: Text("貯金する")),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SyukkinPage()),
                    );
                  },
                  child: Text("出金する")),
            ],
          ),
        ],
      ),
    );
  }

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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.bh * 10),
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
                                animation: waveController, // waveControllerを設定
                                builder: (context, child) => Stack(
                                  children: <Widget>[
                                    // 1つ目の波
                                    ClipPath(
                                      child:
                                          Container(color: Colors.transparent),
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
            Padding(
              padding: EdgeInsets.only(top: SizeConfig.bh * 15),
            ),
            if (isVisible == true) nomal(context),
            if (isVisible == false) push(context),
          ],
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
