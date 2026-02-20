import 'package:minimart/pages/Authotication/register_page.dart';
import 'package:minimart/pages/Layout_page/layout_page.dart';
import 'package:minimart/utils/assets.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/utils/data.dart';
import 'package:minimart/services/user_service.dart';
import 'package:minimart/widgits/Custom_Widget/custom_banner.dart';
import 'package:minimart/widgits/Custom_Widget/custom_textfeild.dart';

import 'package:flutter/material.dart';

// ignore: must_be_immutable
class LoginPage extends StatelessWidget {
  LoginPage({super.key});
  bool isval = false;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String? email;
  String? password;

  void login(BuildContext context) {
    _form.currentState!.validate();
    if (!isval) {
      return;
    }

    _form.currentState!.save();
    bool isLogin = false;
    for (var element in accounts) {
      if (element['email'] == email && element['password'] == password) {
        UserService().login(email!, password!);

        isLogin = true;
        break;
      }
    }
    if (!isLogin) {
      ScaffoldMessenger.of(context).clearMaterialBanners();

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        backgroundColor: errorColor,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        content: Text(
          "Account not found. Please try again.",
          textAlign: TextAlign.center,
          style: TextStyle(color: whiteColor, fontWeight: FontWeight.w600),
        ),
      ));
      return;
    }

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LayoutPage();
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
                    const EdgeInsets.symmetric(horizontal: 28, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Welcome back 👋",
                      style: TextStyle(
                          color: subTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Sign In",
                      style: TextStyle(
                          color: textColor,
                          fontSize: 28,
                          fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 24),
                    Form(
                        key: _form,
                        child: Column(
                          children: [
                            CustomField(
                                onvalidad: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Email is required";
                                  }
                                  if (!value.contains('@')) {
                                    return 'Please enter a valid email';
                                  }
                                  isval = true;
                                  return null;
                                },
                                onsave: (newValue) {
                                  email = newValue;
                                },
                                path: emailIcon,
                                name: "Email"),
                            const SizedBox(height: 14),
                            CustomField(
                                onvalidad: (value) {
                                  if (value == null || value.isEmpty) {
                                    return "Password is required";
                                  }
                                  if (value.length <= 7) {
                                    return "Password must be at least 8 characters";
                                  }
                                  isval = true;
                                  return null;
                                },
                                onsave: (newValue) {
                                  password = newValue;
                                },
                                obscureText: true,
                                path: passwordIcon,
                                name: "Password"),
                            const SizedBox(height: 30),
                            // Gradient Login Button
                            Container(
                              width: double.infinity,
                              height: 54,
                              decoration: BoxDecoration(
                                gradient: primaryGradient,
                                borderRadius: BorderRadius.circular(16),
                                boxShadow: [
                                  BoxShadow(
                                    color: primaryColor.withOpacity(0.35),
                                    blurRadius: 14,
                                    offset: const Offset(0, 6),
                                  ),
                                ],
                              ),
                              child: ElevatedButton(
                                onPressed: () {
                                  login(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                ),
                                child: Text(
                                  "Login",
                                  style: TextStyle(
                                      color: blackColor,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Don't have an account?",
                                  style: TextStyle(
                                      fontSize: 13, color: subTextColor),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.pushReplacement(context,
                                        MaterialPageRoute(builder: ((context) {
                                      return SignUpPage();
                                    })));
                                  },
                                  child: Text(
                                    "Sign Up",
                                    style: TextStyle(
                                        color: primaryColor,
                                        fontSize: 14,
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
