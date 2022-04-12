import 'package:flutter/material.dart';
import 'package:studyplanner/models/inputfieldwrapper.dart';
import 'package:studyplanner/utils/sizehelper.dart';

class ModuleInputField extends StatefulWidget {

  String fieldTitle;
  Widget leadingIcon;
  InputFieldWrapper input;

  Function ?onChange;

  ModuleInputField({required this.leadingIcon, required this.fieldTitle, required this.input, Key? key, this.onChange}) : super(key: key);

  @override
  _ModuleInputFieldState createState() => _ModuleInputFieldState();
}

class _ModuleInputFieldState extends State<ModuleInputField> {

  // InputFieldWrapper inputText = InputFieldWrapper();

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
        Container(
          padding: EdgeInsets.symmetric(
              horizontal: SizeHelper.getDisplayWidth(context) * 0.0275),
          decoration: BoxDecoration(
            color: const Color(0xffEBEBEB).withOpacity(0.6),
            borderRadius: BorderRadius.circular(23.00),
          ),
          width: double.infinity,
          child: TextFormField(
            validator: (String? input) {
              if (input!.isNotEmpty) {
                return null;
              } else {
                return "Invalid " + widget.fieldTitle;
              }
            },
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              icon: widget.leadingIcon,
              prefixIconConstraints: const BoxConstraints(maxHeight: 32),
              suffixIconConstraints: const BoxConstraints(maxHeight: 32),
              contentPadding:
              EdgeInsets.all(SizeHelper.getDisplayHeight(context) * 0.0125),
              hintText: widget.fieldTitle,
              fillColor: Colors.transparent,
              hintStyle: const TextStyle(
                  fontSize: 18,
                  color: Color(0xff171717),
                  fontWeight: FontWeight.bold),
            ),
            onChanged: (String input) {
              setState(() {
                widget.input.setInputTitle(input.trim());
                if (RegExp(r'^[0-9]+$').hasMatch(input.trim())) {
                  widget.input.setInputValue(int.parse(input.trim()));
                }
                if (widget.onChange != Null) {
                  widget.onChange!();
                }
              });
            },
          ),
        ),
        SizedBox(
          height: SizeHelper.getDisplayHeight(context) * 0.015,
        )
      ],
    );
  }
}

