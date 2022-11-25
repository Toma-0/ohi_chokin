import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class SizeConfig{
 static MediaQueryData? _mediaQueryData;
 static double screenWidth = 0;
 static double screenHeight = 0 ;
 static double bw= 0 ;
 static double bh= 0;
 
 void init(BuildContext context) {
  _mediaQueryData = MediaQuery.of(context);
  screenWidth = _mediaQueryData!.size.width;
  screenHeight = _mediaQueryData!.size.height;
  bw= screenWidth / 100;//blockSizeHorizonta
  bh = screenHeight / 100;//blockSizeVertical
 }
}