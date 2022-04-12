import 'package:flutter/material.dart';
import 'package:studyplanner/models/inputfieldwrapper.dart';
import 'package:studyplanner/utils/sizehelper.dart';

class ModuleInputButton extends StatefulWidget {

  String fieldTitle;
  String hintText;
  Widget leadingIcon;
  Function onPressFunction;

  ModuleInputButton({required this.leadingIcon, required this.fieldTitle, required this.hintText, required this.onPressFunction, Key? key}) : super(key: key);

  @override
  _ModuleInputFieldState createState() => _ModuleInputFieldState();
}

class _ModuleInputFieldState extends State<ModuleInputButton> {

  InputFieldWrapper inputText = InputFieldWrapper();

  _ModuleInputFieldState();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.fieldTitle,
          style: const TextStyle(
              fontSize: 14,
              color: Color(0xff171717),
              fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: () {
            widget.onPressFunction();
          },
          child: Container(
            padding: EdgeInsets.symmetric(
                horizontal: SizeHelper.getDisplayWidth(context) * 0.0275, vertical: SizeHelper.getDisplayHeight(context) * 0.0125),
            decoration: BoxDecoration(
              color: const Color(0xffEBEBEB).withOpacity(0.6),
              borderRadius: BorderRadius.circular(23.00),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                widget.leadingIcon,
                SizedBox(width: 30),
                Text(widget.hintText, style: TextStyle(
                    fontSize: 18,
                    color: Color(0xff171717),
                    fontWeight: FontWeight.bold),)
              ],
            )
          ),
        ),
        SizedBox(
          height: SizeHelper.getDisplayHeight(context) * 0.015,
        )
      ],
    );
  }
}

