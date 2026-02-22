import 'package:flutter/material.dart';
import 'package:minimart/pages/authentication/login_page.dart';
import 'package:minimart/services/user_service.dart';

class SignoutMessage extends StatefulWidget {
  const SignoutMessage({super.key});

  @override
  State<SignoutMessage> createState() => _SignoutMessageState();
}

class _SignoutMessageState extends State<SignoutMessage> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Sign Out"),
      content: const Text("Are you sure you want to sign out?"),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () {
            UserService().logout();
            Navigator.pop(context); // Close dialog
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginPage()),
              (route) => false,
            );
          },
          child: const Text("Sign Out", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
