import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../pages/main/main_page.dart';
import '../pages/sign_in_page/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  Future<void> signUp(BuildContext context,{required String name, required String email, required String password}) async {
    NavigatorState navigator = Navigator.of(context);
    try {
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: password);

      if(userCredential.user != null)  {
        await _registerUser(name: name, email: email, password: password);
        navigator.push(MaterialPageRoute(builder:(context) => Main(userEmail: userCredential.user!.email,),));
      }else {
        Fluttertoast.showToast(
            msg: "Registration Failed. Try Again.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  Future<void> signIn(BuildContext context,{ required String email, required String password}) async {
    NavigatorState navigator = Navigator.of(context);

    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      if(userCredential.user != null)  {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        if(userCredential.user!.email != null) {
          await prefs.setString("typeRegister", "withSignIn");
          await prefs.setString("email", userCredential.user!.email!);

          navigator.push(MaterialPageRoute(builder:(context) => Main(userEmail: userCredential.user!.email,),));
        }else {
          Fluttertoast.showToast(
              msg: "Email Not Found.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );
        }
      }else {
        Fluttertoast.showToast(
            msg: "User Not Found.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );
      }

    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(
          msg: e.message!,
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

  Future<void> _registerUser(
      {required String name,
        required String email,
        required String password}) async {
    try {
      await users
          .add({
        "email": email, // John Doe
        "name": name, // Stokes and Sons
        "password": password // 42
      });

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("typeRegister", "withRegister");
      await prefs.setString("email", email);

    } catch(e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }


  Future<String?> signInWithGoogle() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("os", "android");

      final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication gAuth = await gUser!.authentication;
      final credential = GoogleAuthProvider.credential(accessToken: gAuth.accessToken, idToken: gAuth.idToken);
      var userCredential = await FirebaseAuth.instance.signInWithCredential(credential);

      if(userCredential.user != null)  {
        if(userCredential.user!.email != null) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("email", userCredential.user!.email!);

          return userCredential.user?.email;
        }else {
          Fluttertoast.showToast(
              msg: "Email Not Found.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );

          return null;
        }
      }else {
        Fluttertoast.showToast(
            msg: "User Not Found.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

        return null;
      }

    }catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      return null;
    }
  }

  Future<void> signOut(BuildContext context) async {
    NavigatorState navigator = Navigator.of(context);

    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("os");
      await prefs.remove("email");
      await GoogleSignIn().signOut();

      navigator.push(MaterialPageRoute(builder:(context) => const SignIn(exit: false,)));

      Fluttertoast.showToast(
          msg: "Successful Logout",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }


  ///////////////////////////////////////////////


  Future<String?> signInWithApple() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString("os", "ios");

      final appleProvider  = AppleAuthProvider();
      final userCredential = await FirebaseAuth.instance.signInWithProvider(appleProvider);

      if(userCredential.user != null) {
        if (userCredential.user!.email != null) {
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          await prefs.setString("email", userCredential.user!.email!);

          return userCredential.user?.email;
        } else {
          Fluttertoast.showToast(
              msg: "Email Not Found.",
              toastLength: Toast.LENGTH_LONG,
              gravity: ToastGravity.TOP,
              timeInSecForIosWeb: 2,
              backgroundColor: Colors.red,
              textColor: Colors.white,
              fontSize: 16.0
          );

          return null;
        }
      }else {
        Fluttertoast.showToast(
            msg: "User Not Found.",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.TOP,
            timeInSecForIosWeb: 2,
            backgroundColor: Colors.red,
            textColor: Colors.white,
            fontSize: 16.0
        );

        return null;
      }
    }catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );

      return null;
    }

  }

  Future<void> signOutOfApple(BuildContext context) async {
    NavigatorState navigator = Navigator.of(context);
    try {
      await signOutOfApple(context);

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove("os");
      await prefs.remove("email");

      navigator.push(MaterialPageRoute(builder:(context) => const SignIn(exit: false,)));

      Fluttertoast.showToast(
          msg: "Successful Logout",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }catch (e) {
      Fluttertoast.showToast(
          msg: e.toString(),
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 2,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
    }
  }

}
