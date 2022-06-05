import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppPicker {
  static pickTime(context) async {
    final newTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (context, child) {
        return MediaQuery(
          data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
          child: child ?? Container(),
        );
      },
    );
    return newTime;
  }

  static pickDate(context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    return picked;
  }

  static pickDateRange(context) async {

    final startTime = await showDateRangePicker(
        context: context,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 100)),

    );
    final endTime = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 100)),
    );
    return showDialog(context: context, builder: ( context){
      return CupertinoAlertDialog(
        content:Text("content"),
      );
    });
  }
}
