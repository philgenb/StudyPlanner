import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyplanner/models/module.dart';
import 'package:studyplanner/models/user.dart';
import 'package:studyplanner/pages/dashboard/moduleswipe.dart';
import 'package:studyplanner/pages/dashboard/vertical_module_shortlist.dart';
import 'package:studyplanner/shared/appbar.dart';
import 'package:studyplanner/utils/sizehelper.dart';

import '../../models/profile.dart';
import '../../services/auth_service.dart';
import '../../services/database.dart';

/// Main Menu of the application
class HomeMenu extends StatefulWidget {
  final CustomUser _user;

  HomeMenu(this._user);

  @override
  _HomeMenuState createState() => _HomeMenuState();
}

class _HomeMenuState extends State<HomeMenu> {

  final AuthService _auth = AuthService();
  late final DataBaseService _database;
  String semester = "WS22/23";

  late Stream<List<Module>> semesterModuleStream;

  @override
  void initState() {
    CustomUser? currentUser = _auth.getCurrentUser();
    _database = DataBaseService(uid: currentUser!.getUserIdentifier());
    semesterModuleStream = _database.streamSemesterModules(semester);
    initSemester();
    super.initState();
  }

  void initSemester() async {
    String newSemester = await _database.getSemester();
    setState(() {
      semester = newSemester;
      semesterModuleStream = _database.streamSemesterModules(semester);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        popupMenu: false,
        changeSemester: changeSemester,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: SizeHelper.getDisplayWidth(context) * 0.075, vertical: SizeHelper.getDisplayHeight(context) * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ...getHeadElements(),
            StreamProvider<List<Module>>.value(
              value: semesterModuleStream,
              initialData: [],
              child: ModuleShortList(),
            ),
            const SizedBox(height: 30,),

            Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                  border: Border.all(), borderRadius: const BorderRadius.all(Radius.circular(10))),
              child: Consumer<Profile>(
                  builder: (BuildContext context, profile, child) {
                    return Text("• ${profile.credits} / 30  Credit Points",
                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white));
                  },
              ),
            ),

            SizedBox(height: SizeHelper.getDisplayHeight(context) * 0.025,),

            const Text("Your schedule", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
            const Text("Upcoming Exams and events", style: TextStyle(fontSize: 19, color: Color(0xffABABAB))),
            StreamProvider<List<Module>>.value(
                value: semesterModuleStream,
                initialData: [],
              child: ModuleSwipe(),
            ),

          ],
        ),
      ),
    );
  }

  List<Widget> getHeadElements() {
    return [
      Text("Hello ${widget._user.getUserName()}", style: TextStyle(fontSize: 16, color: Color(0xffABABAB)),),
      Text("You've got", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),

      Consumer<Profile>(
        builder: (BuildContext context, profile, child) {
          return Text("${profile.moduleCount} Unit Tests this semester", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold, color: Color(0xff49B583)));
        },
      ),


      SizedBox(height: SizeHelper.getDisplayHeight(context) * 0.03,),

      Text("Your modules", style: TextStyle(fontSize: 23, fontWeight: FontWeight.bold)),
      Text("Your running modules", style: TextStyle(fontSize: 19, color: Color(0xffABABAB))),
    ];
  }

  void changeSemester(String newSemester) {
    setState(() {
      semester = newSemester;
      semesterModuleStream = _database.streamSemesterModules(semester);
    });
    _database.setSemester(newSemester);
    print("changed Semester to $semester");
  }

}


