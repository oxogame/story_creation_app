/*
* import 'package:drawer_demo/screens/customer_screen.dart';
import 'package:drawer_demo/screens/product_screen.dart';
* */
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../pages/sign_in_page/sign_in.dart';
import '../services/auth_service.dart';

class MainPageDrawer extends StatefulWidget {
  final String? userEmail;

  const MainPageDrawer({super.key, this.userEmail});

  @override
  State<StatefulWidget> createState() {
    return MainPageDrawerState();
  }
}

class MainPageDrawerState extends State<MainPageDrawer> {
  int _selectedDestination = 0;

  late final SharedPreferences prefs;

  startSharedPreferences() async {
    try {
      prefs = await SharedPreferences.getInstance();
    } catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0);
    }
  }

  @override
  void initState() {
    super.initState();

    startSharedPreferences();
  }

  @override
  Widget build(BuildContext context) {
    return buildDrawer(context);
  }

  Drawer createMenuItems(BuildContext context) {
    var borderRadius = const BorderRadius.only(
        topRight: Radius.circular(32), bottomRight: Radius.circular(32));

    profileImageAndName(String image, String? name) {
      return DrawerHeader(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 10.0),
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(200)),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffDDDDDD),
                    blurRadius: 6.0,
                    spreadRadius: 2.0,
                    offset: Offset(5.0, 7.0),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(200),
                child: ClipOval(
                  child: SizedBox.fromSize(
                    size: const Size.fromRadius(50), // Image radius
                    child: Image.asset(image, fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(left: 5.0),
              child: Text(
                name!,
                style: const TextStyle(
                    fontSize: 18.0, fontWeight: FontWeight.w500),
              ),
            )
          ],
        ),
      );
    }

    List<Widget> navigationList = <Widget>[
      profileImageAndName("assets/user.PNG", widget.userEmail ?? "null"),
      const Divider(height: 6.0, color: Colors.black45),
      const SizedBox(
        height: 10.0,
      ),
      ListTile(
        horizontalTitleGap: 0,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        selectedTileColor: _selectedDestination == 0 ? Colors.blue[100] : null,
        selected: _selectedDestination == 0,
        tileColor: _selectedDestination == 0 ? Colors.white : null,
        leading: Icon(
          Icons.home,
          color: _selectedDestination == 0 ? Colors.blue : Colors.black87,
          size: 30.0,
        ),
        title: Container(
          margin: const EdgeInsets.only(top: 3.0),
          child: Text(
            "Home",
            style: TextStyle(
                color: _selectedDestination == 0 ? Colors.blue : null,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
        ),
        onTap: () {
          selectDestination(0);
        },
      ),
      const SizedBox(
        height: 10.0,
      ),
      ListTile(
        horizontalTitleGap: 0,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        selectedTileColor: _selectedDestination == 1 ? Colors.blue[100] : null,
        selected: _selectedDestination == 1,
        tileColor: _selectedDestination == 1 ? Colors.white : null,
        leading: Image(
          image: const AssetImage("assets/help.png"),
          width: 28,
          height: 28,
          color: _selectedDestination == 1 ? Colors.blue : Colors.black87,
        ),
        title: Container(
          margin: const EdgeInsets.only(top: 3.0),
          child: Text(
            "Help",
            style: TextStyle(
                color: _selectedDestination == 1 ? Colors.blue : null,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
        ),
        onTap: () {
          selectDestination(1);
        },
      ),
      const SizedBox(
        height: 10.0,
      ),
      ListTile(
        horizontalTitleGap: 0,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        selectedTileColor: _selectedDestination == 2 ? Colors.blue[100] : null,
        selected: _selectedDestination == 2,
        tileColor: _selectedDestination == 2 ? Colors.white : null,
        leading: Image(
          image: const AssetImage("assets/question.png"),
          width: 28,
          height: 28,
          color: _selectedDestination == 2 ? Colors.blue : Colors.black87,
        ),
        title: Container(
          margin: const EdgeInsets.only(top: 3.0),
          child: Text(
            "FeedBack",
            style: TextStyle(
                color: _selectedDestination == 2 ? Colors.blue : null,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
        ),
        onTap: () {
          selectDestination(2);
        },
      ),
      const SizedBox(
        height: 10.0,
      ),
      ListTile(
        horizontalTitleGap: 0,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        selectedTileColor: _selectedDestination == 3 ? Colors.blue[100] : null,
        selected: _selectedDestination == 3,
        tileColor: _selectedDestination == 3 ? Colors.white : null,
        leading: Image(
          image: const AssetImage("assets/friend.png"),
          width: 28,
          height: 28,
          color: _selectedDestination == 3 ? Colors.blue : Colors.black87,
        ),
        title: Container(
          margin: const EdgeInsets.only(top: 3.0),
          child: Text(
            "Invite Friend",
            style: TextStyle(
                color: _selectedDestination == 3 ? Colors.blue : null,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
        ),
        onTap: () {
          selectDestination(3);
        },
      ),
      const SizedBox(
        height: 10.0,
      ),
      ListTile(
        horizontalTitleGap: 0,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        selectedTileColor: _selectedDestination == 4 ? Colors.blue[100] : null,
        selected: _selectedDestination == 4,
        tileColor: _selectedDestination == 4 ? Colors.white : null,
        leading: Image(
          image: const AssetImage("assets/connect.png"),
          width: 28,
          height: 28,
          color: _selectedDestination == 4 ? Colors.blue : Colors.black87,
        ),
        title: Container(
          margin: const EdgeInsets.only(top: 3.0),
          child: Text(
            "Rate the app",
            style: TextStyle(
                color: _selectedDestination == 4 ? Colors.blue : null,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
        ),
        onTap: () {
          selectDestination(4);
        },
      ),
      const SizedBox(
        height: 10.0,
      ),
      ListTile(
        horizontalTitleGap: 0,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        selectedTileColor: _selectedDestination == 5 ? Colors.blue[100] : null,
        selected: _selectedDestination == 5,
        tileColor: _selectedDestination == 5 ? Colors.white : null,
        leading: Image(
          image: const AssetImage("assets/exclamation.png"),
          width: 28,
          height: 28,
          color: _selectedDestination == 5 ? Colors.blue : Colors.black87,
        ),
        title: Container(
          margin: const EdgeInsets.only(top: 3.0),
          child: Text(
            "About us",
            style: TextStyle(
                color: _selectedDestination == 5 ? Colors.blue : null,
                fontSize: 18.0,
                fontWeight: FontWeight.w600),
          ),
        ),
        onTap: () {
          selectDestination(5);
        },
      ),
      const SizedBox(
        height: 10.0,
      ),
      const Divider(
        height: 3.0,
        thickness: 2.0,
      ),
      const SizedBox(
        height: 10.0,
      ),
      ListTile(
        horizontalTitleGap: 0,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
        leading: const Text(
          "Sign Out",
          style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.w600),
        ),
        trailing: TextButton(
          onPressed: () async {
            try {
              final String? os = prefs.getString("os");
              final String? type = prefs.getString("typeRegister");

              if (os != null) {
                if (os == "ios") {
                  AuthService().signOutOfApple(context);
                } else if (os == "android") {
                  AuthService().signOut(context);
                }
              } else if (type != null) {
                if (type == "withRegister" || type == "withSignIn") {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SignIn(
                            exit: true,
                          )));
                } else {
                  Fluttertoast.showToast(
                      msg: "No entry has been made yet.",
                      toastLength: Toast.LENGTH_LONG,
                      gravity: ToastGravity.TOP,
                      timeInSecForIosWeb: 2,
                      backgroundColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16.0);
                }
              } else {
                Fluttertoast.showToast(
                    msg: "No entry has been made yet.",
                    toastLength: Toast.LENGTH_LONG,
                    gravity: ToastGravity.TOP,
                    timeInSecForIosWeb: 2,
                    backgroundColor: Colors.green,
                    textColor: Colors.white,
                    fontSize: 16.0);
              }
            } catch (e) {
              Fluttertoast.showToast(
                  msg: e.toString(),
                  toastLength: Toast.LENGTH_LONG,
                  gravity: ToastGravity.TOP,
                  timeInSecForIosWeb: 2,
                  backgroundColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          },
          child: const Image(
            image: AssetImage("assets/power.png"),
            width: 28,
            height: 28,
          ),
        ),
        onTap: () {},
      ),
    ];

    ListView menuItems = ListView(
      children: navigationList,
    );

    return Drawer(
      width: 90.0,
      child: menuItems,
    );
  }

  buildDrawer(BuildContext context) {
    return Drawer(
      child: createMenuItems(context),
    );
  }

  void selectDestination(int index) {
    setState(() {
      _selectedDestination = index;
    });
  }
}
