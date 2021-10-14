import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyplanner/models/inputfieldwrapper.dart';
import 'package:studyplanner/services/auth_service.dart';
import 'package:studyplanner/shared/Loading.dart';
import 'package:studyplanner/utils/sizehelper.dart';
import 'package:studyplanner/utils/titlewidget.dart';

class Registration extends StatefulWidget {
  final Function? switchView;

  Registration({this.switchView});

  @override
  _RegistrationState createState() => _RegistrationState();
}

class _RegistrationState extends State<Registration> {
  final AuthService _auth = AuthService();
  final _formInputKey = GlobalKey<FormState>();

  bool _loading = false;

  InputFieldWrapper _username = InputFieldWrapper();
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
                title: "Sign Up",
                subTitle:
                "Create an account, so you can connect with your friends",
                iconButton: null),
            SizedBox(
              height: SizeHelper.getDisplayHeight(context) * 0.03,
            ),
            Form(
                key: _formInputKey,
                child: Column(
                  children: [
                    inputField(
                        "Username",
                        _username,
                        SvgPicture.asset(
                          "assets/images/profile-user.svg",
                          width: 30,
                          height: 30,
                        )),
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
                    createAccountButton(),
                    SizedBox(
                      height: SizeHelper.getDisplayHeight(context) * 0.02,
                    ),
                  ],
                )),
            termsOfService(),
            SizedBox(
              height: SizeHelper.getDisplayHeight(context) * 0.025,
            ),
            loginButton()
          ],
        ));
  }

  Widget inputField(String fieldTitle, InputFieldWrapper fieldText, Widget fieldIcon) {
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

  Widget termsOfService() {
    return Align(
      alignment: Alignment.center,
      child: RichText(
        text: const TextSpan(
            style: TextStyle(color: Color(0xff171717), fontFamily: 'Poppins'),
            children: [
              TextSpan(text: "By signing up, you're agree to our\n"),
              TextSpan(
                  text: "Terms of Use",
                  style: TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: " and "),
              TextSpan(
                  text: "Privacy Policy",
                  style: TextStyle(fontWeight: FontWeight.bold)),
            ]),
        textAlign: TextAlign.center,
      ),
    );
  }

  Widget createAccountButton() {
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
            _loading = true;
            dynamic result = await _auth.registerWithEmailAndPassword(
                _email.getInputTitle(), _password.getInputTitle(), _username.getInputTitle());
            if (result == null) {
              setState(() {
                _loading = false;
                _error.setInputTitle("Please enter a valid E-Mail and Password");
              });
            }
          }
        },
        child: const Text(
          "Create an Account",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

  Widget loginButton() {
    return Align(
      alignment: Alignment.center,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const Text(
            "Already have an Account?",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: SizeHelper.getDisplayHeight(context) * 0.01),
          OutlineButton(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
            borderSide: const BorderSide(color: Color(0xff272727), width: 3),
            child: const Text(
              "Login",
              style: TextStyle(
                  fontSize: 16,
                  color: Color(0xff272727),
                  fontWeight: FontWeight.bold),
            ),
            color: const Color(0xff272727),
            shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            onPressed: () {
              widget.switchView!();
            },
          ),
        ],
      ),
    );
  }
}