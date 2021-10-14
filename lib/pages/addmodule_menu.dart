import 'package:flutter/material.dart';
import 'package:studyplanner/pages/module/module_card.dart';
import 'package:studyplanner/shared/appbar.dart';
import 'package:studyplanner/utils/sizehelper.dart';

class AddModuleMenu extends StatelessWidget {

  static const String routeName = "/AddModuleMenu";

  AddModuleMenu({Key? key}) : super(key: key);

  Color moduleColor = Color(0xff303030);
  String moduleName = "";
  String moduleRoom = "";
  String zoomLink = "";
  DateTime date = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        popupMenu: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeHelper.getDisplayWidth(context) * 0.06,
            vertical: SizeHelper.getDisplayHeight(context) * 0.01),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeHelper.getDisplayHeight(context) * 0.1),
            ModuleCard(moduleColor, moduleName, pressable: false),

            SizedBox(height: SizeHelper.getDisplayHeight(context) * 0.02),



          ],
        ),
      ),
    );
  }
}
