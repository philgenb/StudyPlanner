import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:studyplanner/models/module.dart';
import 'package:studyplanner/pages/addmodule_menu.dart';
import 'package:studyplanner/pages/schedule/vertical_module_list.dart';
import 'package:studyplanner/services/database.dart';
import 'package:studyplanner/shared/appbar.dart';
import 'package:studyplanner/utils/sizehelper.dart';

import '../models/user.dart';
import '../services/auth_service.dart';

class ModuleMenu extends StatefulWidget {
  static const String routeName = "/ModuleMenu";

  const ModuleMenu({Key? key}) : super(key: key);

  @override
  _ModuleMenuState createState() => _ModuleMenuState();
}

class _ModuleMenuState extends State<ModuleMenu> {

  final AuthService _auth = AuthService();
  late final DataBaseService _database;

  @override
  void initState() {
    CustomUser? currentUser = _auth.getCurrentUser();
    _database = DataBaseService(uid: currentUser!.getUserIdentifier());
    super.initState();
    _database.testPrintModules();
  }

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
            const Text("Your modules", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            const Text("Your running modules", style: TextStyle(fontSize: 19, color: Color(0xffABABAB))),
            const SizedBox(height: 10),
            Expanded(
              child: StreamProvider<List<Module>>(
                create: (context) => _database.streamModules(),
                initialData: [],
                child: ModuleList()
              ),
            ),
            getAddModuleButton()
          ],
        ),
      ),
    );
  }

  Widget getAddModuleButton() {
    return Center(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: SizeHelper.getDisplayHeight(context) * 0.0175),
        height: SizeHelper.getDisplayHeight(context) * 0.06,
        width: SizeHelper.getDisplayWidth(context) * 0.5,
        child: TextButton.icon(
          style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                )
            ),
            backgroundColor: MaterialStateProperty.resolveWith((states) => Color(0xff303030)),
          ),
          icon: SvgPicture.asset(
            "assets/images/plus.svg",
            height: 25,
            color: Colors.white,
          ),
          onPressed: addModule,
          label: Text("Add Module", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold),),

        ),
      ),
    );
  }

  void addModule() {
    Navigator.pushNamed(context, AddModuleMenu.routeName);
  }
}
