import 'dart:io';
import 'package:company_app_demo/pages/main/main_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:company_app_demo/pages/sign_in_page/sign_in.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  try {
    WidgetsFlutterBinding.ensureInitialized();

    Platform.isAndroid
        ? await Firebase.initializeApp(
            options: const FirebaseOptions(
                apiKey: "AIzaSyAcPxG7VgVR2JNpbyB315UNz8ULXeriM9g",
                appId: "1:587756873097:android:10453fe16cea4a816dad58",
                messagingSenderId: "587756873097",
                projectId: "company-project-c6a7d"))
        : Firebase.initializeApp();

    runApp(const MyApp());
  } catch (e) {
    debugPrint(e.toString());
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<StatefulWidget> createState() {
    return MyAppState();
  }
}

class MyAppState extends State<MyApp> {
  String email = "";

  Future<void> isThereAUser() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    final String? os = prefs.getString("email");
    if (os != null) {
      setState(() {
        email = os;
      });
    }
  }

  @override
  void initState() {
    isThereAUser();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Company Application Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: email != ""
          ? Main(
              userEmail: email,
            )
          : const SignIn(exit: false,),
    );
  }
}
