import 'package:flutter/material.dart';

class TitleWidget extends StatelessWidget {
  final String? title;
  final String? subTitle;
  final IconButton? iconButton;

  final bool? smallSize;

  TitleWidget(
      {@required this.title,
        @required this.subTitle,
        @required this.iconButton,
        this.smallSize});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title!,
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w800,
                ),
                textAlign: TextAlign.left,
              ),
              iconButton != null ? iconButton! : const SizedBox()
            ],
          ),
          Text(
            subTitle!,
            style: const TextStyle(
              color: Color(0xff1dbc9c),
              fontSize: 20,
              fontWeight: FontWeight.w700,
            ),
            textAlign: TextAlign.left,
          ),
        ],
      ),
    );
  }
}