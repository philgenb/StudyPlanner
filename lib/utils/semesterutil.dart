import 'package:cloud_firestore/cloud_firestore.dart';

class SemesterUtil {

  static getCurrentSemester() {

  }

  static List<String> getCurrentSemesterStrings() {
    Timestamp currentStamp = Timestamp.now();
    int yearEnding = int.parse(currentStamp.toDate().year.toString().substring(2));
    return [
      "WS${yearEnding - 1}/$yearEnding",
      "SS$yearEnding",
      "WS$yearEnding/${yearEnding + 1}"];
  }

}