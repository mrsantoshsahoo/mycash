import 'package:flutter/material.dart';

extension WidgetExt on Widget {
  Widget onTap(Function() onTap) => GestureDetector(
        onTap: onTap,
        child: this,
      );
}
