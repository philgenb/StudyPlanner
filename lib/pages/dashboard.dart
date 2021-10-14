import 'package:flutter/material.dart';
import 'package:studyplanner/models/user.dart';
import 'package:studyplanner/pages/dashboard/module_card.dart';
import 'package:studyplanner/pages/dashboard/module_element.dart';
import 'package:studyplanner/pages/dashboard/moduleswipe.dart';
import 'package:studyplanner/shared/appbarv2.dart';
import 'package:studyplanner/utils/sizehelper.dart';


class HomeMenu extends StatefulWidget {
  final CustomUser _user;

  HomeMenu(this._user);

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {


  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: SizeHelper.getDisplayWidth(context) * 0.075, vertical: SizeHelper.getDisplayHeight(context) * 0.015),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Hello Phil G.", style: TextStyle(fontSize: 16, color: Color(0xffABABAB)),),
          Text("You've got", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          Text("6 Unit Tests this semester", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Color(0xff49B583))),

          SizedBox(height: SizeHelper.getDisplayHeight(context) * 0.03,),

          Text("Your modules", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          Text("Your running modules", style: TextStyle(fontSize: 19, color: Color(0xffABABAB))),

          ModuleElement(Color(0xff7F86FF), "Lineare Algebra II  (6)"),
          ModuleElement(Color(0xffff4171), "Betriebsysteme  (5)"),
          ModuleElement(Color(0xffffbd69), "Rechnerorganisation  (4)"),
          ModuleElement(Color(0xff5dd59e), "Datenbanksysteme  (7)"),

          SizedBox(height: SizeHelper.getDisplayHeight(context) * 0.03,),

          Text("Your schedule", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          Text("Upcoming Exams and events", style: TextStyle(fontSize: 19, color: Color(0xffABABAB))),

          ModuleSwipe(),



        ],
      ),
    );
  }

}


