import 'package:flutter/material.dart';
import 'package:studyplanner/utils/sizehelper.dart';

class ModuleInformation extends StatelessWidget {

  final Widget moduleIcon;
  final String title;

  ModuleInformation({required this.title, required this.moduleIcon, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        moduleIcon,
        SizedBox(width: SizeHelper.getDisplayWidth(context) * 0.025,),
        Text(title, style: TextStyle(fontSize: 16, color: Colors.white),),

      ],
    );
  }
}
