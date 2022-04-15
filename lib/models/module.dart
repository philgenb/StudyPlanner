import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studyplanner/theme/colors.dart';

import '../utils/dateutil.dart';

class Module {

  String moduleName;
  String zoomURL;
  String room;
  String time;
  Timestamp examTimeStamp;
  late Color color;
  String creditPoints;


  Module({required this.moduleName, required this.zoomURL, required this.examTimeStamp, required this.creditPoints, this.room = "Unknown", this.time = "Unknown"}) {
    color = randomColor();
  }

  String getDateString() {
    return DateUtil.formatDateTimeToPrint(DateTime.fromMicrosecondsSinceEpoch(examTimeStamp.microsecondsSinceEpoch));
  }

  factory Module.fromFireStore(DocumentSnapshot doc) {
    return Module(
      moduleName: doc.id,
      zoomURL: doc.get('zoom') ?? "",
      examTimeStamp: doc.get('examTimeStamp') ?? Timestamp.now(),
      time: doc.get('time'),
      room: doc.get('room'),
      creditPoints: doc.get('credits').toString(),
    );
  }


}