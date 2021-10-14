import 'package:flutter/material.dart';

import 'signin.dart';
import 'registration.dart';


class Authentication extends StatefulWidget {
  const Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {

  bool showSignInScreen = true;

  //switch between SignIn and Registering Form
  void switchView() {
    setState(() {
      showSignInScreen = !showSignInScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    if(showSignInScreen) {
      return SignIn(switchView: switchView); //pass switchView Function
    } else {
      return Registration(switchView: switchView);
    }

  }
}