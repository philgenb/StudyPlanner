import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:studyplanner/pages/addmodule_menu.dart';
import 'package:studyplanner/pages/modulemenu.dart';

class CustomMatApp extends StatelessWidget {
  final Widget child;

  const CustomMatApp({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate
      ],
      supportedLocales: const [Locale('de'), Locale('en')],
      theme: ThemeData(
        colorScheme: const ColorScheme.light(
          primary: Color(0xff303030),
        ),
        fontFamily: 'Poppins',
        accentColor: const Color(0xff1dbc9c),
        primaryColor: const Color(0xff272727),
        textTheme: const TextTheme(
            headline1: TextStyle(fontSize: 17, fontWeight: FontWeight.bold, color: Colors.white),
            headline2: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black),
            bodyText1: TextStyle(fontSize: 16, color: Colors.white)
        ),
      ),
      home: child,
      routes: {
        ModuleMenu.routeName: (context) => ModuleMenu(),
        AddModuleMenu.routeName: (context) => AddModuleMenu(),
      },
    );
  }


}
