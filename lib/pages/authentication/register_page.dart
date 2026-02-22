import 'package:minimart/pages/authentication/login_page.dart';
import 'package:minimart/utils/assets.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/utils/data.dart';
import 'package:minimart/widgets/custom_widgets/custom_banner.dart';
import 'package:minimart/widgets/custom_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String? email;
  String? username;
  String? password;
  bool isval = false;

  void signUp(BuildContext context) {
    _form.currentState!.validate();

    _form.currentState!.save();

    if (!isval) {
      return;
    }

    accounts.add({
      "username": username,
      "email": email,
      "password": password,
    });

    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
      return const LoginPage();
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
                      "Create your account 🛒",
                      style: TextStyle(
                          color: subTextColor,
                          fontSize: 14,
                          fontWeight: FontWeight.w400),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "Sign Up",
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
                            CustomTextField(
                                onvalidad: (value) {
                                  if (value == null || value.isEmpty) {
                                    isval = false;
                                    return "Username is required";
                                  }

                                  isval = true;
                                  return null;
                                },
                                onsave: (newValue) {
                                  username = newValue;
                                },
                                path: usernameIcon,
                                name: "Username"),
                            const SizedBox(height: 14),
                            CustomTextField(
                                onvalidad: (value) {
                                  if (value == null || value.isEmpty) {
                                    isval = false;
                                    return "Email is required";
                                  }
                                  if (!value.contains('@')) {
                                    isval = false;
                                    return 'Please enter a valid email';
                                  }
                                  // Simplified logic
                                  isval = true;
                                  return null;
                                },
                                onsave: (newValue) {
                                  email = newValue;
                                },
                                path: emailIcon,
                                name: "Email"),
                            const SizedBox(height: 14),
                            CustomTextField(
                                onvalidad: (value) {
                                  if (value == null || value.isEmpty) {
                                    isval = false;
                                    return "Password is required";
                                  }
                                  if (value.length <= 7) {
                                    isval = false;
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
                            // Gradient Sign Up Button
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
                                  signUp(context);
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16)),
                                ),
                                child: Text(
                                  "Create Account",
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
                                  "Already have an account?",
                                  style: TextStyle(
                                      fontSize: 13, color: subTextColor),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(context,
                                        MaterialPageRoute(builder: ((context) {
                                      return const LoginPage();
                                    })));
                                  },
                                  child: Text(
                                    "Login",
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
