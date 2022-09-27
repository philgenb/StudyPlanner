import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyplanner/utils/sizehelper.dart';

class TopAppBar extends StatelessWidget {
  const TopAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.symmetric(horizontal: 17.5, vertical: 22.5),
      height: SizeHelper.getDisplayHeight(context) * 0.1,
      color: const Color(0xffe7e7e7),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            "assets/images/settings.svg",
            height: 30,
          ),
        ],
      ),
    );
  }
}
