import 'package:flutter/material.dart';
import 'package:studyplanner/pages/dashboard/module_card.dart';
import 'package:studyplanner/shared/appbar.dart';
import 'package:studyplanner/utils/sizehelper.dart';

class ModuleMenu extends StatefulWidget {

  static const String routeName = "/ModuleMenu";

  const ModuleMenu({Key? key}) : super(key: key);

  @override
  _ModuleMenuState createState() => _ModuleMenuState();
}

class _ModuleMenuState extends State<ModuleMenu> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(popupMenu: true,),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: SizeHelper.getDisplayWidth(context) * 0.06),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Your modules", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            Text("Your running modules", style: TextStyle(fontSize: 19, color: Color(0xffABABAB))),
            Expanded(
              child: ListView.builder(
                itemCount: 3,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.symmetric(vertical: SizeHelper.getDisplayHeight(context) * 0.0075),
                      child: (
                          ModuleCard(Color(0xff7F86FF), "Lineare Algebra II", pressable: false,)));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
