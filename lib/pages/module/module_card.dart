import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyplanner/pages/module/module_info.dart';
import 'package:studyplanner/pages/modulemenu.dart';
import 'package:studyplanner/utils/sizehelper.dart';

class ModuleCard extends StatelessWidget {



  Color moduleColor;
  String moduleName;
  bool pressable = false;

  ModuleCard(this.moduleColor, this.moduleName, {required this.pressable, Key? key}) : super(key: key);



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
        height: SizeHelper.getDisplayHeight(context) * 0.21,
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
                Text(moduleName, style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18)),
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
                      onTap: () {

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
                ModuleInformation(
                  title: "10:30 Uhr",
                  moduleIcon: SvgPicture.asset(
                  "assets/images/clock.svg",
                  height: 22.5,
                ),),
                ModuleInformation(title: "Raum 201", moduleIcon: SvgPicture.asset(
                  "assets/images/map.svg",
                  height: 25,
                ),),
                ModuleInformation(title: "Zoom", moduleIcon: SvgPicture.asset(
                  "assets/images/zoom.svg",
                  height: 25,
                ),),
              ],
            )

          ],
        ),
      ),
    );
  }
}
