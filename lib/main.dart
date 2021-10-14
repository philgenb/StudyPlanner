import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:studyplanner/pages/dashboard/module_card.dart';
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

  bool isAppBarActive = false;


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
              theme: ThemeData(
                  fontFamily: 'Poppins',
                  accentColor: const Color(0xff1dbc9c),
                  primaryColor: const Color(0xff272727)),
              home: Scaffold(
                appBar: isAppBarActive ? CustomAppBar() : null,
                resizeToAvoidBottomInset: false,
                body: Wrapper(toggleAppBar),
              ),
              routes: {
                ModuleMenu.routeName: (context) => ModuleMenu(),
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
