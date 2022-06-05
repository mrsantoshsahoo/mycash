import 'package:flutter/material.dart';

Widget text(data,
    {Color colors = Colors.black,
    double size = 14,
    FontWeight? fontWeight = FontWeight.normal}) {
  return Text(data,
      style: TextStyle(color: colors, fontSize: size, fontWeight: fontWeight));
}

Widget VertivalSpace(double height) {
  return SizedBox(
    height: height,
  );
}

Widget HorizontalSpace(double width) {
  return SizedBox(
    width: width,
  );
}
deviceWidth(context) => MediaQuery.of(context).size.width;
deviceHeight(context) => MediaQuery.of(context).size.height;