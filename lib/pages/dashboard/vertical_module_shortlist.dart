import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyplanner/pages/module/module_element.dart';
import 'package:studyplanner/theme/colors.dart';

import '../../models/module.dart';

class ModuleShortList extends StatefulWidget {
  const ModuleShortList({Key? key}) : super(key: key);

  @override
  _ModuleShortListState createState() => _ModuleShortListState();
}

class _ModuleShortListState extends State<ModuleShortList> {
  @override
  Widget build(BuildContext context) {
    List<Module> modules = Provider.of<List<Module>>(context);
    
    return Expanded(
      child: ListView.builder(
        itemCount: modules.length,
          itemBuilder: (context, index) {
        return ModuleElement(colors[index % colors.length], modules[index].moduleName ?? "Module", modules[index].creditPoints);
      }),
    );
  }
}
