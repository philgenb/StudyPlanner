import 'package:flutter/material.dart';
import 'package:studyplanner/models/user.dart';
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
      padding: EdgeInsets.symmetric(horizontal: SizeHelper.getDisplayWidth(context) * 0.075, vertical: SizeHelper.getDisplayHeight(context) * 0.025),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Hello Phil Gengenbach", style: TextStyle(fontSize: 16, color: Color(0xffABABAB)),),
          Text("You've got", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          Text("6 Unit Tests this semester", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Color(0xff49B583))),
          SizedBox(height: SizeHelper.getDisplayHeight(context) * 0.05,),
          Text("Your modules", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
          Text("Your running modules", style: TextStyle(fontSize: 19, color: Color(0xffABABAB))),
        ],
      ),
    );
  }

}


