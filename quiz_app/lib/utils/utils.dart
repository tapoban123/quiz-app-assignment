import 'package:flutter/material.dart';

enum CustomFontFamily {
  rubikSemiBold("Rubik-SemiBold"),
  rubikBold("Rubik-Bold"),
  rubikLight("Rubik-Light"),
  rubikMedium("Rubik-Medium"),
  rubikRegular("Rubik-Regular"),
  rubikExtraBold("Rubik-ExtraBold"),
  rubikBlack("Rubik-Black");

  final String fontFamily;
  const CustomFontFamily(this.fontFamily);
}

double screenWidth(BuildContext context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(BuildContext context) {
  return MediaQuery.of(context).size.height;
}
