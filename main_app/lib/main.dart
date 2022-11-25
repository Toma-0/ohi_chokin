import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // システムバー・ナビゲーションバーの色
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarDividerColor: Colors.grey,
      systemNavigationBarIconBrightness: Brightness.dark,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false, // DEBUGバナー削除
      title: 'Wave Animation',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: WaveView(),
    );
  }
}

class WaveView extends StatefulWidget {
  @override
  _WaveViewState createState() => _WaveViewState();
}

class _WaveViewState extends v {
  late AnimationController waveController; // AnimationControllerの宣言
  static const darkBlue = Color.fromARGB(255, 131, 132, 133); // 波の色

  @override
  void initState() {
    waveController = AnimationController(
      duration: const Duration(seconds: 3), // アニメーションの間隔を3秒に設定
      vsync: this, // おきまり
    )..repeat(); // リピート設定

    super.initState();
  }

  @override
  void dispose() {
    waveController.dispose(); // AnimationControllerは明示的にdisposeする。
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        clipBehavior: Clip.antiAlias,
      decoration:BoxDecoration(
        shape: BoxShape.circle,
      color: Colors.white,
      ),
      child:AnimatedBuilder(
        animation: waveController, // waveControllerを設定
        builder: (context, child) => Stack(
          children: <Widget>[
            // 1つ目の波
            ClipPath(
              child: Container(color: darkBlue),
              clipper: WaveClipper(context, waveController.value, 0),
            ),
            // 2つ目の波
            ClipPath(
              child: Container(color: darkBlue.withOpacity(0.6)),
              clipper: WaveClipper(context, waveController.value, 0.5),
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
    final height = MediaQuery.of(context).size.height; // 画面の高さ
    

    // coordinateListに波の座標を追加
    for (var i = 0; i <= width / 3; i++) {
      final step = (i / width) - waveControllerValue;
      coordinateList.add(
        Offset(
          i.toDouble() * 3, // X座標
          height*0.5-math.sin(step * 2 * math.pi - offset) * 45,// Y座標
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
