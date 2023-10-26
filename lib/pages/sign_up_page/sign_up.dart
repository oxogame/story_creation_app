import 'dart:io';

import 'package:company_app_demo/mixins/sign_up_mixin.dart';
import 'package:company_app_demo/pages/sign_in_page/sign_in.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';
import '../main/main_page.dart';

//import 'package:get_it/get_it.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<StatefulWidget> createState() {
    return SignUpState();
  }
}

class SignUpState extends State<SignUp> with SignUpValidationMixin {
  final formKey = GlobalKey<FormState>();

  String name = "";
  String email = "";
  String password = "";

  @override
  void initState() {
    super.initState();
  }

  ButtonStyle textButtonStyle = TextButton.styleFrom(
    minimumSize: const Size(88, 36),
    padding: const EdgeInsets.symmetric(horizontal: 16),
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
    ),
    backgroundColor: Colors.green,
  );

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
        child: Scaffold(
          body: Column(
            children: [
              Flexible(
                  child: Container(
                      width: double.infinity,
                      height: double.infinity,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 199, 199, 199),
                        image: DecorationImage(
                          opacity: .1,
                          scale: 1,
                          image: AssetImage(
                              'assets/apple_icon.png'), // Replace with your image path
                        ),
                      ),
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            Container(
                              padding: const EdgeInsets.only(top: 70.0),
                              child: Image.asset("assets/lock.png"),
                            ),
                            const SizedBox(
                              height: 40.0,
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                  top: 20.0, left: 15.0, right: 15.0),
                              child: const Align(
                                alignment: Alignment.center,
                                child: Text(
                                  "Welcome back you've been missed!",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.w500,
                                      letterSpacing: 1.0,
                                      color: Color.fromARGB(255, 99, 98, 98)),
                                ),
                              ),
                            ),
                            Padding(
                                padding: const EdgeInsets.only(
                                    top: 20.0, left: 15.0, right: 15.0),
                                child: Form(
                                    key: formKey,
                                    child: SingleChildScrollView(
                                      child: Column(
                                        children: <Widget>[
                                          nameField(),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          emailField(),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                          passwordField(),
                                          const SizedBox(
                                            height: 8.0,
                                          ),
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: Container(
                                              margin: null,
                                              child: const Text(
                                                "Forgot Password ?",
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 100, 99, 99),
                                                ),
                                              ),
                                            ),
                                          ),
                                          verificationAction(),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                top: 45.0, bottom: 40.0),
                                            child: const Align(
                                              alignment: Alignment.center,
                                              child: Text(
                                                "Or continue with",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  fontSize: 16.0,
                                                  fontWeight: FontWeight.w500,
                                                  color: Color.fromARGB(
                                                      255, 107, 106, 106),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Container(
                                              margin: const EdgeInsets.only(
                                                  bottom: 10.0, left: 12.0),
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    ElevatedButton(
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            const Color
                                                                .fromARGB(255,
                                                                216, 214, 214),
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10.0)),
                                                        minimumSize: const Size(
                                                            85.0,
                                                            80.0), //////// HERE
                                                      ),
                                                      onPressed: () {
                                                        AuthService()
                                                            .signInWithGoogle()
                                                            .then((value) {
                                                          if (value != null) {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) => Main(
                                                                      userEmail:
                                                                          value),
                                                                ));
                                                          }
                                                        });
                                                      },
                                                      child: Image.asset(
                                                        "assets/google.png",
                                                        width: 40.0,
                                                        height: 40.0,
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      width: 20.0,
                                                    ),
                                                    Platform.isIOS
                                                        ? ElevatedButton(
                                                            style:
                                                                ElevatedButton
                                                                    .styleFrom(
                                                              backgroundColor:
                                                                  const Color
                                                                      .fromARGB(
                                                                      255,
                                                                      216,
                                                                      214,
                                                                      214),
                                                              shape: RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              10.0)),
                                                              minimumSize:
                                                                  const Size(
                                                                      85.0,
                                                                      80.0), //////// HERE
                                                            ),
                                                            onPressed: () {
                                                              AuthService()
                                                                  .signInWithApple()
                                                                  .then(
                                                                (value) {
                                                                  if (value !=
                                                                      null) {
                                                                    Navigator.push(
                                                                        context,
                                                                        MaterialPageRoute(
                                                                          builder: (context) =>
                                                                              Main(userEmail: value),
                                                                        ));
                                                                  }
                                                                },
                                                              );
                                                            },
                                                            child: Image.asset(
                                                              "assets/apple_icon.png",
                                                              width: 40.0,
                                                              height: 40.0,
                                                            ),
                                                          )
                                                        : const SizedBox()
                                                  ])),
                                          Align(
                                            alignment: Alignment.center,
                                            child: Container(
                                              padding: const EdgeInsets.only(
                                                  top: 20.0, bottom: 20.0),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  const Text(
                                                    "Are you a member?",
                                                    style: TextStyle(
                                                      fontSize: 15.0,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Color.fromARGB(
                                                          255, 107, 106, 106),
                                                    ),
                                                  ),
                                                  TextButton(
                                                      onPressed: () {
                                                        MaterialPageRoute
                                                            pageWay =
                                                            MaterialPageRoute(
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                          return const SignIn(
                                                            exit: false,
                                                          );
                                                        });

                                                        Navigator.push(
                                                            context, pageWay);
                                                      },
                                                      child: const Text(
                                                        "Log in now",
                                                        style: TextStyle(
                                                          fontSize: 15.0,
                                                          fontWeight:
                                                              FontWeight.w500,
                                                          color: Color.fromARGB(
                                                              255,
                                                              107,
                                                              106,
                                                              106),
                                                        ),
                                                      ))
                                                ],
                                              ),
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10.0,
                                          ),
                                        ],
                                      ),
                                    ))),
                          ],
                        ),
                      )))
            ],
          ),
        ),
        onRefresh: () async {
          setState(() {
            email = "";
            password = "";

            formKey.currentState?.reset();
          });
        });
  }

  Widget nameField() {
    return TextFormField(
      style: const TextStyle(fontSize: 18.0),
      decoration: const InputDecoration(
        contentPadding:
            EdgeInsets.only(top: 24.0, right: 12.0, bottom: 24.0, left: 12.0),
        fillColor: Color.fromARGB(255, 209, 205, 205),
        filled: true,
        labelText: "Name",
        border: OutlineInputBorder(),
      ),
      validator: validateName,
      onSaved: (String? value) {
        if (value != "" && value != null) {
          name = value.toString();
        }
      },
    );
  }

  Widget emailField() {
    return TextFormField(
      style: const TextStyle(fontSize: 18.0),
      decoration: const InputDecoration(
        contentPadding:
            EdgeInsets.only(top: 24.0, right: 12.0, bottom: 24.0, left: 12.0),
        fillColor: Color.fromARGB(255, 209, 205, 205),
        filled: true,
        labelText: "Email",
        border: OutlineInputBorder(),
      ),
      validator: validateEmail,
      onSaved: (String? value) {
        if (value != "" && value != null) {
          email = value.toString();
        }
      },
    );
  }

  Widget passwordField() {
    return TextFormField(
      obscureText: true,
      style: const TextStyle(fontSize: 18.0),
      decoration: const InputDecoration(
        contentPadding:
            EdgeInsets.only(top: 24.0, right: 12.0, bottom: 24.0, left: 12.0),
        fillColor: Color.fromARGB(255, 209, 205, 205),
        filled: true,
        labelText: "Password",
        border: OutlineInputBorder(),
      ),
      validator: validatePassword,
      onSaved: (String? value) {
        if (value != "" && value != null) {
          password = value.toString();
        }
      },
    );
  }

  Widget verificationAction() {
    return Container(
        margin: const EdgeInsets.only(top: 23.0),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black87,
            shadowColor: Colors.black87,
            elevation: 3,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6.0)),
            minimumSize: const Size(double.infinity, 75), //////// HERE
          ),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();

              signUp(context);
            }
          },
          child: const Text(
            'Sign Up',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
              fontSize: 17.0,
            ),
          ),
        ));
  }

  signUp(BuildContext context) async {
    AuthService authService = AuthService();

    authService.signUp(context, name: name, email: email, password: password);
  }
}
