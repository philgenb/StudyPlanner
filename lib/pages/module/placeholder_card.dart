import 'package:flutter/material.dart';
import 'package:studyplanner/utils/sizehelper.dart';

class PlaceholderCard extends StatelessWidget {

  final Duration duration;

  const PlaceholderCard({Key? key, required this.duration}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: SizeHelper.getDisplayHeight(context) * 0.01, right: SizeHelper.getDisplayWidth(context) * 0.03),
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      height: SizeHelper.getDisplayHeight(context) * 0.05,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20.0),
        color: Theme.of(context).primaryColor,
      ),
      child: Text("<---- ${duration.inDays.abs() - 1} Days ---->", style: Theme.of(context).textTheme.headline1,),
    );
  }
}
