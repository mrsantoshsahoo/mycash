import 'package:intl/intl.dart';

class AppDateTime {


  //To send to server
  String getServerTime(DateTime dateTime) {
    final format = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    String time = format.format(dateTime);
    time += ".000Z";
    return time;
  }
  String getServerTimeDate(DateTime dateTime) {
    final format = DateFormat("yyyy-MM-dd'T'");
    String time = format.format(dateTime);
    // time += ".000Z";
    return time;
  }
  String getServerTimeUTC(DateTime dateTime) {
    final format = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    String time = format.format(dateTime.toUtc());
    time += ".000Z";
    return time;
  }

  //display time from server time
  String getDisplayTime(String serverTime, String displayFormat) {
    DateTime dateTime = DateTime.parse(serverTime);
    final format1 = DateFormat (displayFormat);
    String displayTime = format1.format (dateTime.toLocal());
    return displayTime;
  }

  //date time form server time
  DateTime getDateTime(String serverTime) {
    DateTime dateTime = DateTime.parse(serverTime);
    return dateTime;
  }

  String getUTCTime(String serverTime) {
    DateTime dateTime = DateTime.parse(serverTime);
    final format1 = DateFormat ("yyyy-MM-dd'T'HH:mm:ss");
    String displayTime = format1.format(dateTime.toUtc());
    displayTime += ".000Z";
    return displayTime;
  }
  String getUTCTimehr(String serverTime) {
    DateTime dateTime = DateTime.parse(serverTime);
    final format1 = DateFormat ("HH:mm:ss");
    String displayTime = format1.format(dateTime.toUtc());
    // displayTime += ".000Z";
    return displayTime;
  }

  String getActualTime(DateTime dateTime) {
    final format = DateFormat("dd/MM/yyyy");
    String time = format.format(dateTime);
    return time;
  }

  String getGeneralTime(DateTime dateTime) {
    final format = DateFormat("yyyy-MM-dd");
    String time = format.format(dateTime);
    return time;
  }
  String getServerTimes(DateTime dateTime) {
    final format = DateFormat("yyyy-MM-dd'T'HH:mm:ss");
    String time = format.format(dateTime);
    time += ".000";
    return time;
  }
  String getUTCTimes(String serverTime) {
    DateTime dateTime = DateTime.parse(serverTime);
    final format1 = DateFormat ("yyyy-MM-dd' 'HH:mm:ss");
    String displayTime = format1.format(dateTime.toUtc());
    displayTime += ".000Z";
    return displayTime;
  }
}