import 'package:minimart/pages/Authotication/login_page.dart';
import 'package:minimart/utils/assets.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/utils/data.dart';
import 'package:minimart/widgits/Custom_Widget/custom_banner.dart';
import 'package:minimart/widgits/Custom_Widget/custom_textfeild.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class SignUpPage extends StatelessWidget {
  SignUpPage({super.key});
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String? email;
  String? username;
  String? password;
  bool isval = false;

  void login(BuildContext context) {
    _form.currentState!.validate();

    _form.currentState!.save();
    accounts.add({
      "username": username,
      "email": email,
      "password": password,
    });
    bool isLogin = false;

    for (var element in accounts) {
      if (element['email'] == email && element['password'] == password) {
        currentUser = element;

        isLogin = true;
        break;
      }
    }
    if (!isLogin) {
      ScaffoldMessenger.of(context).clearSnackBars();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
        "this account not avalable",
        textAlign: TextAlign.center,
        style: TextStyle(
          backgroundColor: errorColor,
          color: textColor,
        ),
      )));
      return;
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return LoginPage();
    }));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: backgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const CustomBanner(),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Start Now",
                      style: TextStyle(fontSize: 10, color: textColor),
                    ),
                    Text(
                      "Wellcome ",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                        key: _form,
                        child: Column(
                          children: [
                            CustomField(
                                onvalidad: (value) {
                                  if (value == null || value.isEmpty) {
                                    isval = false;
                                    return "password is required";
                                  }
                                  isval = true;
                                  return null;
                                },
                                onsave: (newValue) {
                                  username = newValue;
                                },
                                path: usernameIcon,
                                name: "Username"),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomField(
                                onvalidad: (value) {
                                  if (value == null || value.isEmpty) {
                                    isval = false;
                                    return "email is required";
                                  }
                                  if (!value.contains('@')) {
                                    isval = false;
                                    return 'email is not validate';
                                  }
                                  isval = true;
                                  return null;
                                },
                                onsave: (newValue) {
                                  email = newValue;
                                },
                                path: emailIcon,
                                name: "Email"),
                            const SizedBox(height: 10),
                            CustomField(
                                onvalidad: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "password is required";
                                  }
                                  if (value.length <= 7) {
                                    return "it must be more than 8 chars";
                                  }
                                  return null;
                                },
                                onsave: (newValue) {
                                  password = newValue;
                                },
                                path: passwordIcon,
                                name: "Password"),
                            const SizedBox(
                              height: 30,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                login(context);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(13)),
                                minimumSize: const Size(300, 50),
                                backgroundColor: primaryColor,
                              ),
                              child: Text(
                                "Sign Up",
                                style: TextStyle(
                                    color: whiteColor,
                                    fontSize: 22,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Already have account?",
                                  style:
                                      TextStyle(fontSize: 10, color: textColor),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: ((context) {
                                      return LoginPage();
                                    })));
                                  },
                                  child: Text(
                                    "Login",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ],
                            )
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
