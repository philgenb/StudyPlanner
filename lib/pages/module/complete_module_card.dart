import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../models/module.dart';
import '../../utils/sizehelper.dart';

/// describes a completed module that lies in the past
class CompleteModuleCard extends StatelessWidget {
  Module module;

  CompleteModuleCard({Key? key, required this.module}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: SizeHelper.getDisplayHeight(context) * 0.006, right: SizeHelper.getDisplayWidth(context) * 0.03),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      width: SizeHelper.getDisplayWidth(context) * 0.85,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).primaryColor
        // border: Border.all(color: Colors.black, width: 3)
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text("${module.moduleName}  (${module.creditPoints} CP)",
              style: Theme.of(context).textTheme.headline1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          Row(
            children: [
              Text(module.getDateString(), style: Theme.of(context).textTheme.headline1),
              SizedBox(width: 10),
              SvgPicture.asset(
                "assets/images/check_mark.svg",
                color: Color(0xff5dd59e),
                height: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
