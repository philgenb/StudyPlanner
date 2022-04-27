import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:studyplanner/services/auth_service.dart';

class CustomAppBar extends StatelessWidget implements PreferredSize {

  bool? popupMenu;

  CustomAppBar({this.popupMenu, Key? key}) : super(key: key);

  AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.white,
       systemOverlayStyle: const SystemUiOverlayStyle(statusBarColor: Colors.white),
      titleSpacing: 0,
      leading: Padding(
        padding: const EdgeInsets.only(left: 17.5, right: 10),
        child: getLeading(context)
      ),
      actions: [
        PopupMenuButton(
            child: Row(children: [
              SizedBox(width: 10,),
              SvgPicture.asset(
                "assets/images/profile-user.svg",
                height: 25,
              ),
              SvgPicture.asset(
                "assets/images/arrow_down.svg",
                height: 50,
              )
            ]),
            elevation: 0,
            shape: const OutlineInputBorder(
              borderSide: BorderSide(width: 3),
                borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            itemBuilder: (context) => [
                  PopupMenuItem(
                    // padding: EdgeInsets.all(2),
                    child: Text("Logout", style: Theme.of(context).textTheme.headline2),
                    onTap: () {
                      _auth.signOut();
                    },
                  ),
                ]),
      ],
    );

  }

  Widget getLeading(BuildContext context) {
    if (popupMenu != null && popupMenu!) {
      return InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: SvgPicture.asset(
          "assets/images/arrow_left.svg",
          height: 30,
        ),
      );
    }
    return SvgPicture.asset(
      "assets/images/settings.svg",
      height: 30,
    );
  }

  @override
  Widget get child => throw UnimplementedError();

  @override
  Size get preferredSize => Size.fromHeight(55);
}
