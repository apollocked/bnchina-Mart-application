// ignore_for_file: deprecated_member_use

import 'package:MiniMart/pages/layout_page.dart';
import 'package:MiniMart/utils/assets.dart';
import 'package:MiniMart/utils/colors.dart';
import 'package:MiniMart/utils/data.dart';
import 'package:MiniMart/widgits/Custom_Widget/custom_appbar.dart';
import 'package:MiniMart/widgits/Custom_Widget/custom_snackBar.dart';
import 'package:MiniMart/widgits/Custom_Widget/custom_textfeild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ChangePasswordPage extends StatefulWidget {
  const  ChangePasswordPage({super.key});

  @override
  State<ChangePasswordPage> createState() => _ChangePasswordPageState();
}

class _ChangePasswordPageState extends State<ChangePasswordPage> {
  GlobalKey<FormState> passform = GlobalKey<FormState>();
  bool isval = false;
  bool trustpassword = false;
  String? password;
  String? againpassword;

  void changePass(BuildContext context) {
    passform.currentState!.validate();
    passform.currentState!.save();

    if (!isval) {
      return;
    }
    if (!trustpassword) {
      return;
    }

    if (currentUser["password"] == againpassword && againpassword == password) {
      CustomSnackbar(errorColor, context, "you cant use an old password");

      isval = false;
      return;
    } else {
      for (var element in accounts) {
        if (element["username"] == currentUser["username"]) {
          element["password"] = againpassword;
          currentUser["password"] = againpassword;
        }
      }
    }
    if (currentUser["password"] == againpassword) {
      Navigator.pop(context, MaterialPageRoute(builder: (context) {
        return const LayoutPage();
      }));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: customAppBar(),
      body: SafeArea(
        minimum: const EdgeInsets.all(5),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            child: Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      Text(
                        "Change Your Password",
                        style: TextStyle(
                            color: primaryColor,
                            fontSize: 20,
                            fontFamily: "Poppins",
                            fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      SvgPicture.asset(
                        "assets/icons/change-password-icon.svg",
                        color: primaryColor,
                        width: 120,
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 38,
                ),
                Form(
                    key: passform,
                    child: Column(
                      children: [
                        CustomField(
                            onvalidad: (value) {
                              if (value == null || value.isEmpty) {
                                return "password is required";
                              }
                              if (value.length <= 7) {
                                return "it must be more than 8 chars";
                              }
                              if (currentUser["password"] != value) {
                                return "Wrong password";
                              }

                              isval = true;
                              return null;
                            },
                            onsave: (value) {
                              trustpassword = true;
                            },
                            path: passwordIcon,
                            name: "old password"),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomField(
                            onvalidad: (value) {
                              if (value == null || value.isEmpty) {
                                return "New password is required";
                              }
                              if (value.length <= 7) {
                                return "it must be more than 8 chars";
                              }
                              isval = true;
                              return null;
                            },
                            onsave: (value) {
                              password = value;
                            },
                            path: passwordIcon,
                            name: "new password"),
                        const SizedBox(
                          height: 10,
                        ),
                        CustomField(
                          onvalidad: (value) {
                            if (value == null || value.isEmpty) {
                              return "New password is required";
                            }
                            if (value.length <= 7) {
                              return "it must be more than 8 chars";
                            }
                            if (password != againpassword) {
                              return "your new password must exactly same";
                            }
                            isval = true;
                            return null;
                          },
                          onsave: (x) {
                            againpassword = x;
                          },
                          path: passwordIcon,
                          name: "new password agian",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                minimumSize: const Size(double.infinity, 40),
                                backgroundColor: primaryColor,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5))),
                            onPressed: () {
                              setState(() {
                                changePass(context);
                              });
                            },
                            child: const Text("Change your password"))
                      ],
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
