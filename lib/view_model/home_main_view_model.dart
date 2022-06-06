import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../app_helper/app_local_database_helper/field_constants.dart';
import '../app_helper/app_local_database_helper/mycash_database.dart';
import '../app_helper/app_local_database_helper/name_constants.dart';
import '../model/home/cash_in_out_model.dart';
import '../model/home/new_saving_model.dart';
import 'dart:developer' as dev;

class HomeViewModel with ChangeNotifier {
  int _currentIndex = 0;
  int get currentIndex => _currentIndex;
  List<CashManage> _savingList = [];
  List<CashManage> get savingList => _savingList;
  List<CashInOut> _cashList = [];
  List<CashInOut> get cashList => _cashList;

  void addSaving(CashManage? data) {
    List<CashInOut> list = [];
    data?.cashInOut = list;
    _savingList.add(data!);
    insertCartItems(data);
    dev.log(_savingList.toString());
    notifyListeners();
  }

  addCash(CashInOut data, index) {
   dev.log(data.toString());
   _savingList[index].cashInOut?.add(data);
  //   _cashList.add(data);
  //   dev.log(_cashList.toString());
    dev.log(_savingList.toString());
    notifyListeners();
  }
  onSearchTextChanged(String text,index) {
    _cashList.clear();
    if (text.isEmpty) {
      return;
    }
    _savingList[index].cashInOut?.forEach((userDetail) {
      if (userDetail.remark
          .toString()
          .toLowerCase()
          .contains(text.toLowerCase())) {
        _cashList.add(userDetail);
      }
    });

  notifyListeners();
  }
  void changeView(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<bool> splashEnd() async {
    await Future.delayed(Duration(seconds: 3));
    notifyListeners();
    return true;
  }

  final database = DatabaseService.getInstance();
  Future<void> insertCartItems(CashManage data) async {
    final rendom=Random();
    try {
      await database.insert(
        NameConstants.SAVING_TABLE,
        {
          FieldConstants.id:"${rendom.nextInt(200)}",
          FieldConstants.savingTitle:data.savingTitle,
          FieldConstants.savingSubTitle:data.savingSubTitle,
        },);
    } catch (e) {
      rethrow;
    }
  }
}
