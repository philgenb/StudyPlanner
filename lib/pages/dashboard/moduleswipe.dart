import 'package:flutter/material.dart';
import 'package:studyplanner/pages/dashboard/module_card.dart';
import 'package:studyplanner/utils/sizehelper.dart';

class ModuleSwipe extends StatefulWidget {
  const ModuleSwipe({Key? key}) : super(key: key);

  @override
  _ModuleSwipeState createState() => _ModuleSwipeState();
}

class _ModuleSwipeState extends State<ModuleSwipe> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
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
        itemCount: 3,
        itemBuilder: (BuildContext context, int index) {
          return ModuleCard(Color(0xff7F86FF), "Lineare Algebra II", pressable: true,);
        },
      ),
    );
  }
}
