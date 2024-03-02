
import 'package:flutter/material.dart';
// padding size
EdgeInsets commonPaddingAll10 = const EdgeInsets.all(10);
EdgeInsets commonPaddingAll20 = const EdgeInsets.all(20);
EdgeInsets commonPaddingAll30 = const EdgeInsets.all(30);

//sizes
double screenWidth(context) {
  return MediaQuery.of(context).size.width;
}

double screenHeight(context) {
  return MediaQuery.of(context).size.height;
}

// divider

Widget dividerH15() {
  return const SizedBox(height: 15);
}

Widget dividerH10() {
  return const SizedBox(height: 10);
}

Widget dividerH5() {
  return const SizedBox(height: 5);
}