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
import 'package:studyplanner/utils/dateutil.dart';
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

  String semester = "SS22";

  Module module = Module(creditPoints: '0', examTimeStamp: Timestamp.now(), moduleName: '', zoomURL: '');

  Color moduleColor = Color(0xff303030);
  String moduleName = "Digitaltechnik";
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
            ModuleCard(Color(0xff303030), moduleNameInput.getInputTitle(), pressable: false, credits: moduleCreditInput.getInputTitle(), module: module,),

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
                    moduleName = moduleNameInput.getInputTitle();
                    module.moduleName = moduleNameInput.getInputTitle();
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
                  module.room = moduleRoomInput.getInputTitle();
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
              leadingIcon: Image.asset('assets/images/coins.png', height: 27.5,),
              input: moduleCreditInput,
              acceptNumbers: true,
              onChange: () {
                setState(() {
                  module.creditPoints = moduleCreditInput.getInputTitle();
                });
              },
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
                padding: MaterialStateProperty.all<EdgeInsets>(EdgeInsets.symmetric(horizontal: 20, vertical: 7.5)),
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
                    room: moduleRoomInput.getInputTitle(),
                );
                _database.addModuleToSemester(module);
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
      initialEntryMode: DatePickerEntryMode.calendar,
      locale: const Locale("de", "DE"),
    );
    if (date != null && date != selectedDate) {
      setState(() {
        selectedDate = date;
        examDate = Timestamp.fromMicrosecondsSinceEpoch(date.microsecondsSinceEpoch);
        module.examTimeStamp = examDate;
      });
    }
  }

}
