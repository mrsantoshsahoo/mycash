import 'package:flutter/material.dart';
import 'package:mycash/view/home/add_cash_screen.dart';
import 'package:provider/provider.dart';
import '../../app_helper/app_widgets/app_search_screen.dart';
import '../../model/home/cash_in_out_model.dart';
import '../../model/home/new_saving_model.dart';
import '../../view_model/home_main_view_model.dart';
import '../../utils/extension_helper.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  TextEditingController _savingTitle = TextEditingController();

  @override
  Widget build(BuildContext context) {
    var prov = Provider.of<HomeViewModel>(context,listen: true);
    return ChangeNotifierProvider<HomeViewModel>(
        create: (context) => HomeViewModel(),
        child: Consumer<HomeViewModel>(builder: (context, counter, child) {
          return Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.white,
              elevation: 1,
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const [
                  Text(
                    "MyCash",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.teal),
                  ),
                  Icon(
                    Icons.security,
                    color: Colors.teal,
                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(
                child: Column(
              children: [
                searchWidget(context),
                ListView.builder(
                    itemCount: counter.savingList.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          ListTile(
                            leading: Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(30),
                                    border: Border.all(
                                        color: Colors.teal, width: 1.5)),
                                child: const Icon(
                                  Icons.book_rounded,
                                  color: Colors.teal,
                                  size: 25,
                                )),
                            title: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(counter.savingList[index].savingTitle ??
                                    ""),
                                Row(
                                  children: [
                                    Text("5000"),
                                    Icon(Icons.more_vert_outlined)
                                  ],
                                ),
                              ],
                            ),
                            subtitle: Text("My Salary"),
                            //   trailing: Icon(Icons.more_vert_outlined),
                          ),
                          const Divider(
                            indent: 60,
                            color: Colors.grey,
                            thickness: 0.5,
                          )
                        ],
                      ).onTap(() => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AddCashScreen(
                                    response: counter.savingList[index],
                                    provider: counter,
                                    index: index,
                                  ))));
                    })
              ],
            )),
            floatingActionButton: FloatingActionButton.extended(
              onPressed: () {
                addNewSavingButtonSheet(context, counter);
              },
              icon: const Icon(Icons.add),
              label: const Text("ADD NEW SAVING"),
            ),
          );
        }));
  }

  Widget searchWidget(context) {
    return InkWell(
      onTap: () {
        showSearch(
          context: context,
          delegate: TheSearch(),
          query: "",
        );
      },
      child: Container(
        margin: const EdgeInsets.all(10),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.teal, width: 1),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: const [
                Icon(Icons.search),
                SizedBox(
                  width: 10,
                ),
                Text("Search Your Cash"),
              ],
            ),
            InkWell(onTap: () {}, child: Icon(Icons.menu_rounded)),
          ],
        ),
      ),
    );
  }

  addNewSavingButtonSheet(context, HomeViewModel counter) {
    return showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (BuildContext context) {
          return Container(
            padding: MediaQuery.of(context).viewInsets,
            //    margin: EdgeInsets.only( bottom: MediaQuery.of(context).viewInsets.bottom),
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
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        "Add New Saving",
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
                SizedBox(
                  height: 10,
                ),
                TextFormField(
                  controller: _savingTitle,
                  decoration: new InputDecoration(
                    labelText: "Enter Saving Name",
                    fillColor: Colors.white,
                    border: new OutlineInputBorder(
                      borderRadius: new BorderRadius.circular(5.0),
                      borderSide: new BorderSide(),
                    ),
                    //fillColor: Colors.green
                  ),
                  autofocus: true,
                  keyboardType: TextInputType.name,
                  style: new TextStyle(
                    fontFamily: "Poppins",
                  ),
                ),
                Divider(
                  thickness: 0.5,
                  color: Colors.grey,
                ),
                InkWell(
                  onTap: () {
                    CashManage _data = CashManage();
                    _data.savingTitle = _savingTitle.text;
                    _data.cashInOut?.add(CashInOut(balanceIn: 100));
                    counter.addSaving( _data);
                    _savingTitle.clear();
                    Navigator.pop(context);
                  },
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(10),
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
                  ),
                ),
              ],
            ),
          );
        });
  }
}
