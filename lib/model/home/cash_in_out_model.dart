// To parse this JSON data, do
//
//     final savingOdel = savingOdelFromJson(jsonString);

import 'dart:convert';

List<CashManage> savingOdelFromJson(String str) => List<CashManage>.from(json.decode(str).map((x) => CashManage.fromJson(x)));

String savingOdelToJson(List<CashManage> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CashManage {
  CashManage({
    this.savingTitle,
    this.savingSubTitle,
    this.totalBalance,
    this.totalBalanceIn,
    this.totalBalanceOout,
    this.cashInOut,
    this.createdTimeStamp
  });
String? createdTimeStamp;
  String? savingTitle;
  String? savingSubTitle;
  int? totalBalance;
  int? totalBalanceIn;
  int? totalBalanceOout;
  List<CashInOut>? cashInOut;

  factory CashManage.fromJson(Map<String, dynamic> json) => CashManage(
    savingTitle: json["savingTitle"],
    savingSubTitle: json["savingSubTitle"],
    totalBalance: json["totalBalance"],
    totalBalanceIn: json["totalBalanceIn"],
    totalBalanceOout: json["totalBalanceOout"],
    cashInOut: List<CashInOut>.from(json["cashInOut"].map((x) => CashInOut.fromJson(x))),
    createdTimeStamp: json["createdTimeStamp"],
  );

  Map<String, dynamic> toJson() => {
    "savingTitle": savingTitle,
    "savingSubTitle": savingSubTitle,
    "totalBalance": totalBalance,
    "totalBalanceIn": totalBalanceIn,
    "totalBalanceOout": totalBalanceOout,
    "cashInOut": List<dynamic>.from(cashInOut!.map((x) => x.toJson())),
    "createdTimeStamp": createdTimeStamp,
  };

  @override
  String toString() {
    return 'CashManage{createdTimeStamp: $createdTimeStamp, savingTitle: $savingTitle, savingSubTitle: $savingSubTitle, totalBalance: $totalBalance, totalBalanceIn: $totalBalanceIn, totalBalanceOout: $totalBalanceOout, cashInOut: $cashInOut}';
  }
}

class CashInOut {
  CashInOut({
    this.remark,
    this.csahType,
    this.createTime,
    this.cashInOutBalance,
    this.balanceIn,
    this.balanceOout,
    this.nowBalance,
    this.inOut,
  });

  String? remark;
  String? csahType;
  String? createTime;
  int? cashInOutBalance;
  int? balanceIn;
  bool? inOut;
  int? balanceOout;
  int? nowBalance;

  factory CashInOut.fromJson(Map<String, dynamic> json) => CashInOut(
    remark: json["remark"],
    csahType: json["csahType"],
    createTime: json["createTime"],
    cashInOutBalance: json["cashInOutBalance"],
    balanceIn: json["balanceIn"],
    balanceOout: json["balanceOout"],
    nowBalance: json["nowBalance"],
    inOut: json["inOut"],
  );

  Map<String, dynamic> toJson() => {
    "remark": remark,
    "csahType": csahType,
    "createTime": createTime,
    "cashInOutBalance": cashInOutBalance,
    "balanceIn": balanceIn,
    "balanceOout": balanceOout,
    "nowBalance": nowBalance,
    "inOut": inOut,
  };

  @override
  String toString() {
    return 'CashInOut{remark: $remark, csahType: $csahType, createTime: $createTime, cashInOutBalance: $cashInOutBalance, balanceIn: $balanceIn, inOut: $inOut, balanceOout: $balanceOout, nowBalance: $nowBalance}';
  }
}
