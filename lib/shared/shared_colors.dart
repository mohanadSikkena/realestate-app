import 'package:flutter/material.dart';
class Shared{
  static Color appBackGroundColor=const Color(0xff1b1b1b);

  static Color containerBackGroundColor=const Color(0xff202020);

  static Color mainFontColor=const Color(0xffdbd9de);

  static Color primaryFontColor=const Color(0xff3e8a9a);

  static Color secondaryFontColor=const Color(0xffc2c1c6);

  static Color primaryIconColor=const Color(0xfff05e4f);

  static Color mainBorderColor=const Color(0xff282828);



  static TextStyle mainTextStyleF18= TextStyle(
      color: mainFontColor,
      fontSize: 18,
      fontWeight: FontWeight.w400);


  static TextStyle mainTextStyleF20=TextStyle(
    color: mainFontColor,
    fontSize: 20,
    fontWeight: FontWeight.w500
  );

  static TextStyle secondTextStyleF20= TextStyle(
      color: primaryFontColor,
      fontSize: 20,
      fontWeight: FontWeight.w500);


  static TextStyle thirdTextStyleF16=TextStyle(
      color: secondaryFontColor,
      fontSize: 16,
      fontWeight: FontWeight.w400);
  static TextStyle thirdTextStyleF18=TextStyle(
      color: secondaryFontColor,
      fontSize: 18 ,
      fontWeight: FontWeight.w400);

}