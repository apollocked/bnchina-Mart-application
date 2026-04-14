import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  // 2. Initialize GoogleSignIn instance
// Use 'newConfiguration' or 'configuration' depending on the exact build
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId:
        '228454131356-2jn4c3nkebj3q4vovcm133eom0cll2c2.apps.googleusercontent.com',
    scopes: ['email', 'profile'],
  );

  String? email;
  String? username;
  String? password;
  bool isval = false;

  // 3. Google Sign In Logic
  Future<void> _handleGoogleSignIn() async {
    try {
      // In 6.x, you don't need .initialize(), you can go straight to signIn()
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        print("Success: ${googleUser.email}");

        // Add to your local accounts list (from data.dart)
        accounts.add({
          "username": googleUser.displayName ?? "Google User",
          "email": googleUser.email,
          "password": "google_authenticated",
        });

        if (!mounted) return;
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const LoginPage()));
      }
    } catch (error) {
      print("Sign-in failed: $error");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Google Sign-In failed. Please try again.")),
      );
    }
  }

  void signUp(BuildContext context) {
    _form.currentState!.validate();
    _form.currentState!.save();

    if (!isval) return;

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
                    Text("Create your account 🛒",
                        style: TextStyle(
                            color: subTextColor,
                            fontSize: 14,
                            fontWeight: FontWeight.w400)),
                    const SizedBox(height: 4),
                    Text("Sign Up",
                        style: TextStyle(
                            color: textColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    Form(
                        key: _form,
                        child: Column(
                          children: [
                            // ... (Your existing CustomTextFields remain the same)
                            CustomTextField(
                                onvalidad: (value) {
                                  if (value == null || value.isEmpty) {
                                    isval = false;
                                    return "Username is required";
                                  }
                                  isval = true;
                                  return null;
                                },
                                onsave: (newValue) => username = newValue,
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
                                  isval = true;
                                  return null;
                                },
                                onsave: (newValue) => email = newValue,
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
                                onsave: (newValue) => password = newValue,
                                obscureText: true,
                                path: passwordIcon,
                                name: "Password"),
                            const SizedBox(height: 30),

                            // 1. Regular Sign Up Button
                            _buildActionButton(
                                text: "Create Account",
                                onPressed: () => signUp(context)),

                            const SizedBox(height: 10),

                            // 2. Google Sign Up Button (UPDATED)
                            _buildActionButton(
                              text: "Sign Up with Google",
                              icon: FontAwesomeIcons.google,
                              onPressed:
                                  _handleGoogleSignIn, // Call the Google logic here
                            ),

                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Already have an account?",
                                    style: TextStyle(
                                        fontSize: 13, color: subTextColor)),
                                TextButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const LoginPage()));
                                  },
                                  child: Text("Login",
                                      style: TextStyle(
                                          color: primaryColor,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold)),
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

  // Refactored button widget to keep UI clean
  Widget _buildActionButton(
      {required String text, IconData? icon, required VoidCallback onPressed}) {
    return Container(
      width: double.infinity,
      height: 54,
      decoration: BoxDecoration(
        gradient: primaryGradient,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
              color: primaryColor.withOpacity(0.35),
              blurRadius: 14,
              offset: const Offset(0, 6)),
        ],
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(text,
                style: TextStyle(
                    color: blackColor,
                    fontSize: 18,
                    fontWeight: FontWeight.bold)),
            if (icon != null) ...[
              const SizedBox(width: 15),
              FaIcon(icon, size: 24, color: whiteColor),
            ]
          ],
        ),
      ),
    );
  }
}
