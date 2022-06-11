import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import '../../app_helper/app_prefreance/app_preferences.dart';
import '../../model/home/cash_in_out_model.dart';
import '../../utils/app_time_converter.dart';
import '../../utils/extension_helper.dart';
import '../../utils/widget_style.dart';
import '../../view_model/home_main_view_model.dart';

class AddCashScreen extends StatefulWidget {
  CashManage? response;
  HomeViewModel? provider;
  int index;

  AddCashScreen({Key? key, this.response, this.provider, required this.index})
      : super(key: key);

  @override
  State<AddCashScreen> createState() => _AddCashScreenState();
}

class _AddCashScreenState extends State<AddCashScreen> {
  List cashAdd = [1, 2, 3];

  DateTime selectedDate = DateTime.now();

  TextEditingController _cash = TextEditingController();
  TextEditingController _remark = TextEditingController();
  TextEditingController _search = TextEditingController();
  var totalCash = 0;
  List<CashInOut>? searchDisplayList = [];


  @override
  Widget build(BuildContext context) {
    // totalCash = 0;
    // widget.provider?.savingList[widget.index].cashInOut?.forEach((element) {
    //   totalCash = totalCash + (element.balanceIn ?? 0);
    // });
    return Scaffold(
      appBar: appBar(context),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 15),
        child: Consumer<HomeViewModel>(builder: (context, counter, child) {
          return Column(
            children: [
              searchWidget(context),
              Expanded(
                  child: SingleChildScrollView(
                physics: BouncingScrollPhysics(),
                child: Column(
                  children: [
                    VertivalSpace(10),
                    //   dateTimeWidget(),
                    //  VertivalSpace(10),
                    totalCashWidget(),
                    VertivalSpace(10),
                    ListView.builder(
                        shrinkWrap: true,
                        physics: BouncingScrollPhysics(),
                        reverse: true,
                        itemCount: _search.text.length > 0
                            ? widget.provider?.cashList.length
                            : widget.provider?.savingList[widget.index]
                                .cashInOut?.length,
                        itemBuilder: (context, i) {
                          var data = _search.text.length > 0
                              ? widget.provider?.cashList[i]
                              : widget.provider?.savingList[widget.index]
                                  .cashInOut?[i];
                          return cashListWidget(data!);
                        })
                    // ...?widget.provider?.savingList[widget.index].cashInOut
                    //     ?.map(
                    //   (e) => cashListWidget(e),
                    // )
                  ],
                ),
              )),
              cashAddSubWidget(context)
            ],
          );
        }),
      ),
    );
  }

  Widget demo() {
    return Container();
  }

  Widget searchWidget(context) {
    return Container(
      margin: const EdgeInsets.only(top: 10),
      padding: const EdgeInsets.only(left: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.teal, width: 1),
        borderRadius: BorderRadius.circular(5),
      ),
      child: Row(
        children: [
          Icon(Icons.search),
          SizedBox(
            width: 10,
          ),
          SizedBox(
              width: 250,
              child: TextField(
                controller: _search,
                onChanged: (value) {
                  setState(() {
                    widget.provider?.onSearchTextChanged(value, widget.index);
                  });
                },
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: "Search By Remark..",
                  border: InputBorder.none,
                ),
              )),
        ],
      ),
    );
  }

  Widget cashAddSubWidget(
    context,
  ) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.green.shade700),
          child: Row(
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              HorizontalSpace(5),
              text("CASH IN", colors: Colors.white),
              HorizontalSpace(5),
            ],
          ),
        ).onTap(() {
          addNewSavingButtonSheet(context, true);
        }),
        Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 25),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(5),
              color: Colors.red.shade700),
          child: Row(
            children: [
              Icon(
                Icons.add,
                color: Colors.white,
              ),
              HorizontalSpace(5),
              text("CASH OUT", colors: Colors.white),
              HorizontalSpace(5),
            ],
          ),
        ).onTap(() {
          addNewSavingButtonSheet(context, false);
        }),
      ],
    );
  }

  Widget dateTimeWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 0.5,
                spreadRadius: 0.0,
                offset: Offset(0.5, 0.5), // shadow direction: bottom right
              )
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.calendar_today_outlined,
                color: Colors.teal,
              ),
              HorizontalSpace(10),
              text("Date Range"),
              HorizontalSpace(50),
            ],
          ),
        ),
        VertivalSpace(10),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 0.5,
                spreadRadius: 0.0,
                offset: Offset(0.5, 0.5), // shadow direction: bottom right
              )
            ],
          ),
          child: Row(
            children: [
              Icon(
                Icons.filter_alt_outlined,
                color: Colors.teal,
              ),
              HorizontalSpace(10),
              text("Filter"),
            ],
          ),
        )
      ],
    );
  }

  Widget totalCashWidget() {
    return Container(
      padding: EdgeInsets.all(5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey,
            blurRadius: 0.5,
            spreadRadius: 0.0,
            offset: Offset(0.5, 0.5), // shadow direction: bottom right
          )
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text("Net Balance", size: 18, fontWeight: FontWeight.w600),
                text(
                    "${widget.provider?.savingList[widget.index].totalBalance ?? 0}",
                    size: 18,
                    fontWeight: FontWeight.w600),
              ],
            ),
          ),
          Divider(
            height: 0.5,
            color: Colors.black87,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text("Total In(+)", size: 16, fontWeight: FontWeight.w500),
                text("${widget.provider?.savingList[widget.index].totalBalanceIn ?? 0}",
                    colors: Colors.green.shade500,
                    size: 16,
                    fontWeight: FontWeight.w500),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                text("Total Out (-)", size: 16, fontWeight: FontWeight.w500),
                text("${widget.provider?.savingList[widget.index].totalBalanceOout ?? 0}",
                    colors: Colors.red.shade500,
                    size: 16,
                    fontWeight: FontWeight.w500),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cashListWidget(CashInOut data) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: text(
              "${AppDateTime().getDisplayTime(data.createTime ?? DateTime.now().toString(), "dd MMM yyyy")}"),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          margin: EdgeInsets.only(bottom: 5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey,
                blurRadius: 0.5,
                spreadRadius: 0.0,
                offset: Offset(0.5, 0.5), // shadow direction: bottom right
              )
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  text("${data.remark ?? "N/A"}",
                      size: 16, fontWeight: FontWeight.w500),
                  text(
                      "${data.balanceIn != null ? data.balanceIn : data.balanceOout ?? 0}",
                      colors: data.inOut ?? true
                          ? Colors.green.shade500
                          : Colors.red,
                      size: 16,
                      fontWeight: FontWeight.w500),
                ],
              ),
              VertivalSpace(8),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    child: text("${data.csahType ?? "Cash"}",
                        size: 14,
                        colors: Colors.teal,
                        fontWeight: FontWeight.w500),
                    padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(5),
                        color: Colors.teal.shade50),
                  ),
                  text("${data.cashInOutBalance}",
                      size: 12,
                      colors: Colors.grey,
                      fontWeight: FontWeight.w300),
                ],
              ),
              VertivalSpace(8),
              text(
                  "${"${AppDateTime().getDisplayTime(data.createTime ?? DateTime.now().toString(), "hh:mm aa")}"}",
                  size: 12,
                  colors: Colors.grey,
                  fontWeight: FontWeight.w300),
            ],
          ),
        ),
      ],
    );
  }

  PreferredSizeWidget appBar(context) {
    return AppBar(
      backgroundColor: Colors.white,
      elevation: 1,
      leading: Icon(
        Icons.arrow_back_ios_sharp,
        color: Colors.black87,
      ).onTap(() => Navigator.of(context).pop()),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          text("Saving", size: 20),
          Row(
            children: [
              Icon(
                Icons.person_add_alt,
                color: Colors.black87,
              ),
              HorizontalSpace(15),
              Icon(
                Icons.picture_as_pdf_outlined,
                color: Colors.black87,
              ),
              HorizontalSpace(15),
              Icon(
                Icons.more_vert_outlined,
                color: Colors.black87,
              )
            ],
          ),
        ],
      ),
    );
  }

  addNewSavingButtonSheet(context, bool type) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            padding: MediaQuery.of(context).viewInsets,
            margin: EdgeInsets.all(8),
            child: Wrap(
              children: [
                Container(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    children: [
                      InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Icon(
                            Icons.close,
                            size: 22,
                          )),
                      HorizontalSpace(10),
                      Text(
                        "Add Cash",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                    ],
                  ),
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey,
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.calendar_today_outlined,
                            size: 22,
                          ),
                          HorizontalSpace(5),
                          Text(
                            "${AppDateTime().getDisplayTime(DateTime.now().toString(), "dd MMM yyyy")}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          HorizontalSpace(5),
                          Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 22,
                          ),
                        ],
                      ).onTap(() => _selectDate(context)),
                      Row(
                        children: [
                          Icon(
                            Icons.access_time_rounded,
                            size: 22,
                          ),
                          HorizontalSpace(5),
                          Text(
                            "${AppDateTime().getDisplayTime(DateTime.now().toString(), "hh:mm aa")}",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          HorizontalSpace(5),
                          Icon(
                            Icons.arrow_drop_down_outlined,
                            size: 22,
                          ),
                        ],
                      ).onTap(() => _selectTime(context)),
                    ],
                  ),
                ),
                TextFormField(
                  controller: _cash,
                  decoration: new InputDecoration(
                    labelText: "Enter Amount",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.number,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                VertivalSpace(15),
                // Row(
                //   children: [
                //     ActionChip(
                //       elevation: 2,
                //       padding: EdgeInsets.all(8),
                //       backgroundColor: Colors.greenAccent[100],
                //       shadowColor: Colors.black,
                //       label: Text(
                //         'CASH',
                //         style: TextStyle(fontSize: 16),
                //       ), onPressed: () {  }, //Text
                //     ),
                //     ActionChip(
                //       elevation: 2,
                //       padding: EdgeInsets.all(8),
                //       backgroundColor: Colors.greenAccent[100],
                //       shadowColor: Colors.black,
                //       label: Text(
                //         'ONLINE',
                //         style: TextStyle(fontSize: 16),
                //       ), onPressed: () {  }, //Text
                //     ),
                //   ],
                // ),
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 10),
                  child: TextField(
                    controller: _remark,
                    decoration: new InputDecoration(
                      labelText: "Enter Remark",
                      fillColor: Colors.white,
                      border: new OutlineInputBorder(
                        borderRadius: new BorderRadius.circular(5.0),
                        borderSide: new BorderSide(),
                      ),
                      //fillColor: Colors.green
                    ),
                    onChanged: (v) {
                      print(v);
                    },
                    keyboardType: TextInputType.name,
                    style: new TextStyle(
                      fontFamily: "Poppins",
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: deviceWidth(context) / 2.5,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        //color: Colors.teal,
                        border: Border.all(color: Colors.teal, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        "Cancel",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.black, fontSize: 20),
                      ),
                    ),
                    Container(
                      width: deviceWidth(context) / 2.5,
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      margin: EdgeInsets.all(5),
                      decoration: BoxDecoration(
                        color: Colors.teal,
                        //    border: Border.all(color: Colors.teal, width: 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: const Text(
                        "Save",
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                      ),
                    ).onTap(() {
                      widget.provider?.savingList[widget.index].totalBalance =
                          netBalance(
                              widget.provider?.savingList[widget.index]
                                      .totalBalance ??
                                  0,
                              int.parse(_cash.text),
                              type);
                      type
                          ? widget.provider?.savingList[widget.index]
                                  .totalBalanceIn =
                              totalBalanceIn(
                                  widget.provider?.savingList[widget.index]
                                          .totalBalanceIn ??
                                      0,
                                  int.parse(_cash.text))
                          : widget.provider?.savingList[widget.index]
                                  .totalBalanceOout =
                              totalBalanceIn(
                                  widget.provider?.savingList[widget.index]
                                          .totalBalanceOout ??
                                      0,
                                  int.parse(_cash.text));
                      CashInOut cash = CashInOut();
                      cash.balanceIn = type ? int.parse(_cash.text) : null;
                      cash.balanceOout = !type ? int.parse(_cash.text) : null;
                      cash.csahType = "Cash";
                      cash.inOut = type ? true : false;
                      cash.createTime = DateTime.now().toString();
                      cash.cashInOutBalance = widget.provider
                              ?.savingList[widget.index].totalBalance ??
                          0;
                      cash.remark = _remark.text;
                     widget.provider?.addCash(cash, widget.index);
                      //   widget.provider?.savingList[widget.index].totalBalance + int.parse(_cash.text) ;
                      _cash.clear();
                      _remark.clear();
                      Navigator.pop(context);
                      setState(() {});
                    }),
                  ],
                ),
              ],
            ),
          );
        });
  }

  int netBalance(int totalPrice, int price, bool type) {
    totalPrice = type ? totalPrice + price : totalPrice - price;
    return totalPrice;
  }

  int totalBalanceIn(
    int totalPrice,
    int price,
  ) {
    totalPrice = totalPrice + price;
    return totalPrice;
  }

  int totalBalanceOut(int totalPrice, int price) {
    totalPrice = totalPrice - price;
    return totalPrice;
  }

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        initialDatePickerMode: DatePickerMode.day,
        firstDate: selectedDate,
        lastDate: selectedDate.add(Duration(days: 30)));
  }

  Future<Null> _selectTime(BuildContext context) async {
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
  }
}
