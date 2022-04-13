import 'package:cloud_firestore/cloud_firestore.dart';

class DateUtil {

  static String formatDateTime(DateTime date) {
    return date.year.toString() + "-" + date.month.toString().padLeft(2, '0') + "-" + date.day.toString().padLeft(2, '0');
  }

  static String formatDateTimeToPrint(DateTime date) {
    return date.day.toString().padLeft(2, '0') + "." + date.month.toString().padLeft(2, '0') + "." +  date.year.toString();
  }

  static Duration getDuration(Timestamp ?day1, Timestamp ?day2) {
    return day1!.toDate().difference(day2!.toDate());
  }

}