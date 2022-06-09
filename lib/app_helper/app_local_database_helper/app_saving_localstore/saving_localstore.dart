import 'dart:convert';
import '../../../model/home/cash_in_out_model.dart';
import '../field_constants.dart';
import '../mycash_database.dart';
import '../name_constants.dart';

class OrderLocalDataSource {
  final database = DatabaseService.getInstance();

  static OrderLocalDataSource? _instance;

  static OrderLocalDataSource getInstance() {
    _instance ??= OrderLocalDataSource();
    return _instance!;
  }
Future<void> insertOrder(CashManage order) async {
  try {
    await database.insert(
      NameConstants.SAVING_TABLE,
      {
        FieldConstants.createdTimeStamp: order.createdTimeStamp,
        FieldConstants.data:  JsonEncoder().convert(order.toJson())
      },
    );
  } catch (e) {
    rethrow;
  }
}
  Future<List<CashManage>> fetchOrders() async {
    try {
      var orders = await database.queryAllRows(NameConstants.SAVING_TABLE);
      List<CashManage> finalData = List.generate(
        orders != null ? orders.length : 0,
            (index) {
          Map<String, dynamic> order = orders[index];
          String data = order[FieldConstants.data];
          Map<String, dynamic> valueMap = jsonDecode(data);
          var orderFromDb = CashManage.fromJson(valueMap);
        //  orderFromDb.orderId = order[FieldConstants.orderId];
          return orderFromDb;
        },
      );
      return finalData;
    } catch (e) {
      rethrow;
    }
  }
  Future<void> deleteOrder(String createdTimeStamp) async {
    try {
      await database.deleteById(NameConstants.SAVING_TABLE,
          FieldConstants.createdTimeStamp, createdTimeStamp);
    } catch (e) {
      rethrow;
    }
  }
}