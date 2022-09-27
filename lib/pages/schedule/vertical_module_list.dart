import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyplanner/pages/module/complete_module_card.dart';
import 'package:studyplanner/pages/module/placeholder_card.dart';
import 'package:studyplanner/theme/colors.dart';
import 'package:studyplanner/utils/dateutil.dart';

import '../../models/module.dart';
import '../../models/user.dart';
import '../../services/auth_service.dart';
import '../../services/database.dart';
import '../../utils/sizehelper.dart';
import '../module/module_card.dart';

class ModuleList extends StatefulWidget {
  const ModuleList({Key? key}) : super(key: key);

  @override
  _ModuleListState createState() => _ModuleListState();
}

class _ModuleListState extends State<ModuleList> {

  final AuthService _auth = AuthService();
  late final DataBaseService _database;

  @override
  void initState() {
    CustomUser? currentUser = _auth.getCurrentUser();
    _database = DataBaseService(uid: currentUser!.getUserIdentifier());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Module> moduleList = Provider.of<List<Module>>(context);

    return ListView.builder(
      itemCount: moduleList.length,
      itemBuilder: (BuildContext context, int index) {
        if (index < moduleList.length - 1) {
          Duration dur = DateUtil.getDuration(moduleList[index].examTimeStamp, moduleList[index + 1].examTimeStamp);
          bool modFinished = DateUtil.isOver(moduleList[index].examTimeStamp);
          return Column(
            children: [
              Container(
                  margin: EdgeInsets.symmetric(
                      vertical:
                      SizeHelper.getDisplayHeight(context) * 0.0075),
                  child: (!modFinished ?
                  ModuleCard(
                    colors[index % colors.length],
                    moduleList[index].moduleName,
                    module: moduleList[index],
                    pressable: false,
                    database: _database,
                    cropped: true,
                  ) : CompleteModuleCard(module: moduleList[index],))
              ),
              !modFinished ? PlaceholderCard(duration: dur) : const SizedBox(),
            ],
          );
        }
        return Container(
            margin: EdgeInsets.symmetric(
                vertical:
                SizeHelper.getDisplayHeight(context) * 0.0075),
            child: (ModuleCard(
              colors[index % colors.length],
              moduleList[index].moduleName,
              module: moduleList[index],
              pressable: false,
              database: _database,
              cropped: true,
            ))
        );

      },
    );

  }



}

