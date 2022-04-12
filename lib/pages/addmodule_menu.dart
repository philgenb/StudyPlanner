import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyplanner/models/inputfieldwrapper.dart';
import 'package:studyplanner/models/module.dart';
import 'package:studyplanner/models/user.dart';
import 'package:studyplanner/pages/module/module_card.dart';
import 'package:studyplanner/services/auth_service.dart';
import 'package:studyplanner/services/database.dart';
import 'package:studyplanner/shared/appbar.dart';
import 'package:studyplanner/shared/inputfield.dart';
import 'package:studyplanner/shared/inputfieldbutton.dart';
import 'package:studyplanner/theme/colors.dart';
import 'package:studyplanner/utils/DateFormatter.dart';
import 'package:studyplanner/utils/sizehelper.dart';

class AddModuleMenu extends StatefulWidget {
  static const String routeName = "/AddModuleMenu";

  const AddModuleMenu({Key? key}) : super(key: key);

  @override
  _AddModuleMenuState createState() => _AddModuleMenuState();
}

class _AddModuleMenuState extends State<AddModuleMenu> {

  final AuthService _auth = AuthService();
  late final DataBaseService _database;

  Color moduleColor = Color(0xff303030);
   String moduleName = "Digitaltechnik";
  // String moduleRoom = "";
  // String zoomURL = "";
  Timestamp examDate = Timestamp.now();

  DateTime selectedDate = DateTime.now();

  InputFieldWrapper moduleNameInput = InputFieldWrapper();
  InputFieldWrapper moduleRoomInput = InputFieldWrapper();
  InputFieldWrapper moduleZoomInput = InputFieldWrapper();
  InputFieldWrapper moduleCreditInput = InputFieldWrapper();

  @override
  void initState() {
    CustomUser? currentUser = _auth.getCurrentUser();
    _database = DataBaseService(uid: currentUser!.getUserIdentifier());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar(
        popupMenu: true,
      ),
      body: Container(
        padding: EdgeInsets.symmetric(
            horizontal: SizeHelper.getDisplayWidth(context) * 0.06,
            vertical: SizeHelper.getDisplayHeight(context) * 0.0075),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: SizeHelper.getDisplayHeight(context) * 0.05),
            ModuleCard(Color(0xff303030), moduleNameInput.getInputTitle(), pressable: false),

            SizedBox(height: SizeHelper.getDisplayHeight(context) * 0.04),

            SizedBox(
              child: ModuleInputField(
                fieldTitle: "Name des Moduls",
                leadingIcon: SvgPicture.asset(
                  "assets/images/graduation.svg",
                  height: 30,
                ),
                input: moduleNameInput,
                onChange: () {
                  setState(() {
                    this.moduleName = moduleNameInput.getInputTitle();
                  });
                },
              ),
            ),

            ModuleInputField(
              fieldTitle: "Raum",
              leadingIcon: SvgPicture.asset(
                "assets/images/map.svg",
                height: 30,
                color: Colors.black,
              ),
              input: moduleRoomInput,
              onChange: () {
                setState(() {

                });
              },
            ),

            ModuleInputField(
              fieldTitle: "Zoom Link",
              leadingIcon: SvgPicture.asset(
                "assets/images/zoom_black.svg",
                height: 27.5,
              ),
              input: moduleZoomInput,
            ),

            ModuleInputField(
              fieldTitle: "Credit Points",
              leadingIcon: SvgPicture.asset(
                "assets/images/zoom_black.svg",
                height: 27.5,
              ),
              input: moduleCreditInput,
            ),

            ModuleInputButton(
                leadingIcon: SvgPicture.asset(
                  "assets/images/calendar.svg",
                  height: 27.5,
                ),
                fieldTitle: "Exam",
                hintText: DateUtil.formatDateTime(selectedDate),
                onPressFunction: () {
                  datePicker(context);
                }),

            TextButton(
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    )
                ),
                backgroundColor: MaterialStateProperty.resolveWith((states) =>
                    Color(0xff303030)),
              ),
              onPressed: () {
                Module module = Module(
                    moduleName: this.moduleName,
                    examTimeStamp: this.examDate,
                    zoomURL: this.moduleZoomInput.getInputTitle(),
                    creditPoints: moduleCreditInput.getInputTitle(),
                );
                _database.addModule(module);
                Navigator.of(context).pop();
              },
              child: const Text("Save", style: TextStyle(fontSize: 18,
                  color: Colors.white,
                  fontWeight: FontWeight.bold),),
            )

          ],
        ),
      ),
    );
  }

  Future datePicker(BuildContext context) async {
    final DateTime? date = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
      initialDatePickerMode: DatePickerMode.day,
      initialEntryMode: DatePickerEntryMode.input,
      locale: const Locale("de", "DE"),
    );
    if (date != null && date != selectedDate) {
      setState(() {
        selectedDate = date;
        examDate = Timestamp.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch);
      });
    }
  }

}
