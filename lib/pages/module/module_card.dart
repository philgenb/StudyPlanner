import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyplanner/pages/module/module_info.dart';
import 'package:studyplanner/pages/modulemenu.dart';
import 'package:studyplanner/services/database.dart';
import 'package:studyplanner/utils/sizehelper.dart';

import '../../models/module.dart';

class ModuleCard extends StatelessWidget {

  Module ?module;

  Color moduleColor;
  String moduleName;
  bool pressable;
  DataBaseService ?database;
  String ?credits;
  bool cropped;

  ModuleCard(this.moduleColor, this.moduleName, {required this.pressable, Key? key, this.module, this.database, this.credits = "0", this.cropped = false}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return InkWell(
      onTap: () {
        if (pressable) {
          Navigator.pushNamed(context, ModuleMenu.routeName);
        }
      },
      child: Container(
        margin: EdgeInsets.only(top: SizeHelper.getDisplayHeight(context) * 0.01, right: SizeHelper.getDisplayWidth(context) * 0.03),
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        // height: SizeHelper.getDisplayHeight(context) * 0.21,
        width: SizeHelper.getDisplayWidth(context) * 0.85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: moduleColor,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("$moduleName  (${module?.creditPoints ?? credits} CP)", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18), softWrap: true,),
                Row(
                  children: [
                    InkWell(
                      onTap: () {

                      },
                      child: SvgPicture.asset(
                        "assets/images/bell.svg",
                        height: 30,
                      ),
                    ),
                    SizedBox(width: 15,),
                    InkWell(
                      onLongPress: () {
                        if (database != null) {
                          database?.removeModule(module!);
                        }
                      },
                      child: SvgPicture.asset(
                        "assets/images/settings_dot.svg",
                        height: 20,
                      ),
                    )
                  ],
                )
              ],
            ),
            SizedBox(height: 30,),

            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                getModuleInformation(),
                ModuleInformation(title: "Raum 201", moduleIcon: SvgPicture.asset(
                  "assets/images/map.svg",
                  height: 25,
                ),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    ModuleInformation(title: "Zoom", moduleIcon: SvgPicture.asset(
                      "assets/images/zoom.svg",
                      height: 25,
                    )),
                    Text(module?.getDateString() ?? "Datum", style: Theme.of(context).textTheme.headline1)
                  ],
                ),
                cropped ? SizedBox(height: 10) : SizedBox()
              ],
            )

          ],
        ),
      ),
    );
  }
  Widget getModuleInformation() {
    if (cropped) {
      return SizedBox();
    }
    return ModuleInformation(
      title: "10:30 Uhr",
      moduleIcon: SvgPicture.asset(
        "assets/images/clock.svg",
        height: 22.5,
      ),);
  }
}
