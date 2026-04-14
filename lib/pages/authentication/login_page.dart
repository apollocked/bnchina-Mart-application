import 'package:minimart/pages/authentication/register_page.dart';
import 'package:minimart/pages/layout/layout_page.dart';
import 'package:minimart/utils/assets.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/utils/data.dart';
import 'package:minimart/services/user_service.dart';
import 'package:minimart/widgets/custom_widgets/custom_banner.dart';
import 'package:minimart/widgets/custom_widgets/custom_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart'; // Add this
import 'package:font_awesome_flutter/font_awesome_flutter.dart'; // Add this

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isval = false;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  String? email;
  String? password;

  // Initialize GoogleSignIn (v6.2.7 style)
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: ['email'],
  );

  // New Method: Handle Google Login
  Future<void> _handleGoogleLogin() async {
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser != null) {
        // 1. Check if the Google email exists in your data.dart accounts
        var existingUser = accounts.firstWhere(
          (acc) => acc['email'] == googleUser.email,
          orElse: () => {},
        );

        if (existingUser.isNotEmpty) {
          // 2. Account found! Log them in via UserService
          UserService().login(
            existingUser['email'],
            existingUser['password'],
            existingUser['username'],
          );

          if (!mounted) return;
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) {
            return const LayoutPage();
          }));
        } else {
          // 3. Account not found! Sign out of Google and show error
          await _googleSignIn.signOut();
          if (!mounted) return;
          _showErrorSnackBar(
              "No account found for this Google email. Please Sign Up first.");
        }
      }
    } catch (error) {
      _showErrorSnackBar("Google Sign-In failed: $error");
    }
  }

  // Helper for showing errors
  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      backgroundColor: errorColor,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      content: Text(
        message,
        textAlign: TextAlign.center,
        style: TextStyle(color: whiteColor, fontWeight: FontWeight.w600),
      ),
    ));
  }

  void login(BuildContext context) {
    if (!_form.currentState!.validate()) return;

    _form.currentState!.save();
    bool isLogin = false;
    for (var element in accounts) {
      if (element['email'] == email && element['password'] == password) {
        UserService().login(email!, password!, element['username']);
        isLogin = true;
        break;
      }
    }
    if (!isLogin) {
      _showErrorSnackBar("Account not found. Please try again.");
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
                    Text("Welcome back 👋",
                        style: TextStyle(color: subTextColor, fontSize: 14)),
                    const SizedBox(height: 4),
                    Text("Sign In",
                        style: TextStyle(
                            color: textColor,
                            fontSize: 28,
                            fontWeight: FontWeight.bold)),
                    const SizedBox(height: 24),
                    Form(
                        key: _form,
                        child: Column(
                          children: [
                            CustomTextField(
                                onvalidad: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      !value.contains('@')) {
                                    return "Valid email is required";
                                  }
                                  return null;
                                },
                                onsave: (newValue) => email = newValue,
                                path: emailIcon,
                                name: "Email"),
                            const SizedBox(height: 14),
                            CustomTextField(
                                onvalidad: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.length <= 7) {
                                    return "Password must be at least 8 characters";
                                  }
                                  return null;
                                },
                                onsave: (newValue) => password = newValue,
                                obscureText: true,
                                path: passwordIcon,
                                name: "Password"),
                            const SizedBox(height: 30),
                            // Gradient Login Button
                            _buildLoginButton(),
                            const SizedBox(height: 20),

                            // --- ADDED GOOGLE LOGIN BUTTON ---
                            _buildGoogleButton(),

                            const SizedBox(height: 20),
                            _buildSignUpRedirect(),
                          ],
                        ))
                  ],
                ),
              ),
            ],
          ),
        ));
  }

  Widget _buildLoginButton() {
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
        onPressed: () => login(context),
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        ),
        child: Text("Login",
            style: TextStyle(
                color: blackColor, fontSize: 18, fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildGoogleButton() {
    return OutlinedButton(
      onPressed: _handleGoogleLogin,
      style: OutlinedButton.styleFrom(
        fixedSize: const Size(double.maxFinite, 54),
        side: BorderSide(color: primaryColor),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FaIcon(FontAwesomeIcons.google, color: primaryColor),
          const SizedBox(width: 12),
          Text("Sign In with Google",
              style: TextStyle(color: textColor, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildSignUpRedirect() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text("Don't have an account?",
            style: TextStyle(fontSize: 13, color: subTextColor)),
        TextButton(
          onPressed: () {
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const SignUpPage()));
          },
          child: Text("Sign Up",
              style: TextStyle(
                  color: primaryColor,
                  fontSize: 14,
                  fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }
}
