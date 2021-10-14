import 'package:flutter/material.dart';
import 'package:studyplanner/utils/sizehelper.dart';

class ModuleElement extends StatelessWidget {
  final Color moduleColor;
  final String moduleName;

  const ModuleElement(this.moduleColor, this.moduleName, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: SizeHelper.getDisplayHeight(context) * 0.01),
      padding: EdgeInsets.symmetric(
          horizontal: SizeHelper.getDisplayWidth(context) * 0.05, vertical: SizeHelper.getDisplayHeight(context) * 0.003),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6.0),
        color: moduleColor,
      ),
      child: Text(
        moduleName,
        style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 17)
      ),
    );
  }
}
