import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:studyplanner/theme/colors.dart';

import '../utils/dateutil.dart';

class Module {

  String ?moduleName;
  String ?zoomURL;
  Timestamp ?examTimeStamp;
  late Color color;
  String creditPoints = "";


  Module({required this.moduleName, required this.zoomURL, required this.examTimeStamp, required this.creditPoints}) {
    color = randomColor();
  }

  String getDateString() {
    return DateUtil.formatDateTimeToPrint(DateTime.fromMicrosecondsSinceEpoch(this.examTimeStamp!.microsecondsSinceEpoch));
  }

  factory Module.fromFireStore(DocumentSnapshot doc) {
    return Module(
      moduleName: doc.id,
      zoomURL: doc.get('zoom') ?? "",
      examTimeStamp: doc.get('examTimeStamp') ?? Timestamp.now(),
      creditPoints: doc.get('credits').toString(),
    );
  }


}