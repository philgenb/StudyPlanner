import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyplanner/models/inputfieldwrapper.dart';
import 'package:studyplanner/services/auth_service.dart';
import 'package:studyplanner/shared/Loading.dart';
import 'package:studyplanner/utils/sizehelper.dart';
import 'package:studyplanner/utils/titlewidget.dart';

class SignIn extends StatefulWidget {

  static const routeName = "Login";

  final Function? switchView;

  SignIn({this.switchView});

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthService _auth = AuthService();
  final _formInputKey = GlobalKey<FormState>();

  bool _loading = false;

  InputFieldWrapper _email = InputFieldWrapper();
  InputFieldWrapper _password = InputFieldWrapper();
  InputFieldWrapper _error = InputFieldWrapper();

  @override
  Widget build(BuildContext context) {
    if (_loading == true) {
      return Loading();
    }
    return Container(
        margin: EdgeInsets.only(
            top: SizeHelper.getDisplayHeight(context) * 0.08,
            left: SizeHelper.getDisplayWidth(context) * 0.05,
            right: SizeHelper.getDisplayWidth(context) * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TitleWidget(
                title: "Sign In",
                subTitle:
                "Login into your Account to plan your exam phase",
                iconButton: null),
            Form(
                key: _formInputKey,
                child: Column(
                  children: [
                    SizedBox(
                      height: SizeHelper.getDisplayHeight(context) * 0.03,
                    ),
                    inputField(
                        "E-Mail",
                        _email,
                        SvgPicture.asset(
                          "assets/images/email.svg",
                          width: 30,
                        )),
                    inputField(
                        "Password",
                        _password,
                        SvgPicture.asset(
                          "assets/images/padlock.svg",
                          height: 30,
                        )),
                    const Text(
                      "Your password must be 8 or more characters long & contain a mix of upper & lower case letters",
                      style: TextStyle(fontSize: 12),
                    ),
                    SizedBox(
                      height: SizeHelper.getDisplayHeight(context) * 0.02,
                    ),
                    loginButton(),
                  ],
                )),
            SizedBox(
              height: SizeHelper.getDisplayHeight(context) * 0.025,
            ),
            registerAccountButton(),
          ],
        ));
  }

  Widget loginButton() {
    return SizedBox(
      height: SizeHelper.getDisplayHeight(context) * 0.06,
      width: double.infinity,
      child: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<OutlinedBorder>(
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
          backgroundColor: MaterialStateProperty.all<Color>(const Color(0xff272727)),
        ),
        onPressed: () async {
          if (_formInputKey.currentState!.validate()) {
            setState(() {
              _loading = true;
            });
            dynamic result = _auth.loginWithEmailAndPassword(
                _email.getInputTitle(), _password.getInputTitle());
            if (result == null) {
              setState(() {
                _loading = false;
                _error.setInputTitle("Incorrect E-Mail or Password!");
              });
            }
          }
        },
        child: const Text(
          "Login into Account",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

  Widget registerAccountButton() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Don't have an Account yet.",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: SizeHelper.getDisplayHeight(context) * 0.01),
          OutlinedButton(
            onPressed: () {
                widget.switchView!();
              },
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
              foregroundColor: const Color(0xff272727),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              side: const BorderSide(color: Color(0xff272727), width: 3),
            ),
            child: const Text(
              "Register",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff272727),
                  fontWeight: FontWeight.bold),
            ),
          )
        ],
      ),
    );
  }

  Widget inputField(
      String fieldTitle, InputFieldWrapper fieldText, Widget fieldIcon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          fieldTitle,
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
                return "Invalid " + fieldTitle;
              }
            },
            obscureText: fieldTitle == "Password" ? true : false,
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              icon: fieldIcon,
              suffixIcon: SvgPicture.asset(
                "assets/images/check.svg",
                width: 27.5,
              ),
              prefixIconConstraints: const BoxConstraints(maxHeight: 32),
              suffixIconConstraints: const BoxConstraints(maxHeight: 32),
              contentPadding:
              EdgeInsets.all(SizeHelper.getDisplayHeight(context) * 0.0175),
              hintText: fieldTitle,
              fillColor: Colors.transparent,
              hintStyle: const TextStyle(
                  fontSize: 18,
                  color: Color(0xff171717),
                  fontWeight: FontWeight.bold),
            ),
            onChanged: (String input) {
              setState(() {
                fieldText.setInputTitle(input.trim());
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