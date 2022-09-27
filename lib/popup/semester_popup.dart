import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../utils/semesterutil.dart';

class SemesterPopup extends StatelessWidget {

  SvgPicture popupIcon;

  SemesterPopup({Key? key, required this.popupIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      itemBuilder: (context) => [
        ...?getSemesterItems(context)
      ],
      initialValue: 1,
      offset: const Offset(0, 50),
      elevation: 1,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0))
      ),
      enableFeedback: true,
      child: popupIcon
    );
  }

  List<PopupMenuItem>? getSemesterItems(BuildContext context) {
    return SemesterUtil.getCurrentSemesterStrings().map((semesterString)
    => PopupMenuItem(child: Text(semesterString), textStyle: Theme.of(context).textTheme.headline2,)).toList();
  }
}
