import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyplanner/pages/module/module_info.dart';
import 'package:studyplanner/pages/modulemenu.dart';
import 'package:studyplanner/services/database.dart';
import 'package:studyplanner/utils/sizehelper.dart';
import 'package:url_launcher/url_launcher.dart';
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
        } else {

        }
      },
      child: Dismissible(
        key: Key(moduleName),
        background: getDismissBackground(),
        direction: cropped ? DismissDirection.endToStart : DismissDirection.none,
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            if (database != null) {
              database?.removeModule(module!);
            }
          }
        },
        child: Container(
          margin: EdgeInsets.only(top: SizeHelper.getDisplayHeight(context) * 0.01, right: SizeHelper.getDisplayWidth(context) * 0.03),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          //height: SizeHelper.getDisplayHeight(context) * 0.21,
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
                      getNotificationButton(),
                      SizedBox(width: 15,),
                      getMoreInfoButton(),
                    ],
                  )
                ],
              ),
              SizedBox(height: 30,),

              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  getModuleInformation(module),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      getZoomButton(module),
                      Text(cropped ? module?.getDateString() ?? "" : module?.getRemainingTimeString() ?? "", style: Theme.of(context).textTheme.headline1)
                    ],
                  ),
                  cropped ? SizedBox(height: SizeHelper.getDisplayHeight(context) * 0.0125) : SizedBox()
                ],
              )

            ],
          ),
        ),
      ),
    );
  }

  Widget getDismissBackground() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          // Text("X", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Color(0xffFF2400)),),
          //  SizedBox(width: 5),
          // Icon(Icons.cancel, color: Color(0xffFF2400), size: 40),
        ],
      ),
    );
  }

  Widget getZoomButton(Module? module) {
    return !cropped ? InkWell(
      onTap: () async {
        if (module != null && module.zoomURL.isNotEmpty) {
          if (!module.zoomURL.startsWith("http://")) {
            await launch("http://${module.zoomURL}");
            return;
          }
          await launch(module.zoomURL);
        }
      },
      child: ModuleInformation(title: "Zoom", moduleIcon: SvgPicture.asset(
        "assets/images/zoom.svg",
        height: 25,
      )),
    ) : SizedBox();
  }

  Widget getNotificationButton() {
    return InkWell(
      onTap: () {

      },
      child: SvgPicture.asset(
        "assets/images/bell.svg",
        height: 30,
      ),
    );
  }

  Widget getMoreInfoButton() {
    return InkWell(
      onLongPress: () {

      },
      child: SvgPicture.asset(
        "assets/images/settings_dot.svg",
        height: 20,
      ),
    );
  }

  Widget getModuleInformation(Module? module) {
    if (cropped) {
      return SizedBox();
    }
    return Column(
      children: [
        ModuleInformation(
          title: module?.time ?? "Unknown",
          moduleIcon: SvgPicture.asset(
            "assets/images/clock.svg",
            height: 22.5,
          ),),
        ModuleInformation(title: module?.room ?? "Unknown", moduleIcon: SvgPicture.asset(
          "assets/images/map.svg",
          height: 25,
        ),)
      ],
    );
  }

}
