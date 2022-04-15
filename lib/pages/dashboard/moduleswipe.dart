import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyplanner/pages/module/module_card.dart';
import 'package:studyplanner/utils/sizehelper.dart';

import '../../models/module.dart';

class ModuleSwipe extends StatefulWidget {
  const ModuleSwipe({Key? key}) : super(key: key);

  @override
  _ModuleSwipeState createState() => _ModuleSwipeState();
}

class _ModuleSwipeState extends State<ModuleSwipe> {

  int _index = 0;

  @override
  Widget build(BuildContext context) {
    List<Module> moduleList = Provider.of<List<Module>>(context);

    final PageController pageController = PageController(viewportFraction: 1.0);
    return SizedBox(
      height: SizeHelper.getDisplayHeight(context) * 0.225,
      width: SizeHelper.getDisplayWidth(context) * 0.9,
      child: PageView.builder(
        controller: pageController,
        scrollDirection: Axis.horizontal,
        onPageChanged: (int index) => setState(() {
          _index = index;
        }),
        itemCount: moduleList.length,
        itemBuilder: (BuildContext context, int index) {
          return ModuleCard(Color(0xff7F86FF), moduleList[index].moduleName, pressable: true, module: moduleList[index]);
        },
      ),
    );
  }
}
