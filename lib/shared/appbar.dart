import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyplanner/services/auth_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {
  CustomAppBar({Key? key}) : super(key: key);

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Color(0xffe7e7e7),
      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 17.5, right: 2.5),
        child: SvgPicture.asset(
          "assets/images/settings.svg",
          height: 30,
        ),
      ),
      actions: [
        PopupMenuButton(

            child: Row(children: [
              SvgPicture.asset(
                "assets/images/profile-user.svg",
                height: 30,
              ),
              SvgPicture.asset(
                "assets/images/arrow_down.svg",
                height: 50,
              )
            ]),
            itemBuilder: (context) => [
                  PopupMenuItem(
                    child: Text("Logout", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),),
                    onTap: () {
                      _auth.signOut();
                    },
                  ),
                ]),
      ],
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size.fromHeight(55);
}
