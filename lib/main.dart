import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:studyplanner/pages/addmodule_menu.dart';
import 'package:studyplanner/pages/modulemenu.dart';
import 'package:studyplanner/services/auth_service.dart';
import 'package:studyplanner/shared/appbar.dart';
import 'package:studyplanner/shared/loading.dart';
import 'package:studyplanner/wrapper.dart';

import 'models/user.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    //App only in portrait mode
    runApp(MyApp());
  });
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  CustomAppBar? customAppBar;
  bool isAppBarActive = true;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return const Center(child: Text("Error"));
        }

        if (snapshot.connectionState == ConnectionState.done) {
          return StreamProvider<CustomUser?>.value(
            initialData: null,
            value: AuthService().user,
            child: MaterialApp(
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
              home: Scaffold(
                appBar: isAppBarActive ? CustomAppBar() : null,
                resizeToAvoidBottomInset: false,
                body: Wrapper(toggleAppBar),
              ),
              routes: {
                ModuleMenu.routeName: (context) => ModuleMenu(),
                AddModuleMenu.routeName: (context) => AddModuleMenu(),
              },
            ),
          );
        }
        return MaterialApp(home: Loading());
      },
    );
  }

  void toggleAppBar(bool status) {
    isAppBarActive = status;
  }
}
