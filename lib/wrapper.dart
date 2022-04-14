import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:studyplanner/pages/authentication/authentication.dart';
import 'package:studyplanner/pages/dashboard/dashboard.dart';
import 'package:studyplanner/services/database.dart';

import 'models/profile.dart';
import 'models/user.dart';

class Wrapper extends StatelessWidget {

  static const routeName = '/Wrapper';

  Function toggleAppBar;

  Wrapper(this.toggleAppBar);

  @override
  Widget build(BuildContext context) {

    final CustomUser? user = Provider.of<CustomUser?>(context);


    //Checks whether User is already Signed in
    if(user == null) { //no User Logged In -> Call authentication Widget
      //toggleAppBar(false);
      return Authentication(); //SignIn or Registration Widget
    } else {
      //User Logged In -> HomeScreen
      toggleAppBar(true);
      print("User Logged In:");
      print(user.getUserName());
      return StreamProvider<Profile>(
          create: (context) => DataBaseService(uid: user.userID).streamProfile,
          initialData: Profile(userName: "-", credits:  0, moduleCount:  0),
          child: HomeMenu(user)
      );
    }

  }
}