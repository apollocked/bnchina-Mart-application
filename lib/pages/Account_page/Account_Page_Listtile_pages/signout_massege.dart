import 'package:flutter/material.dart';
import 'package:minimart/pages/Authotication/register_page.dart';
import 'package:minimart/utils/data.dart';

class SignoutMassege extends StatefulWidget {
  const SignoutMassege({super.key});

  @override
  State<SignoutMassege> createState() => _SignoutMassegeState();
}

class _SignoutMassegeState extends State<SignoutMassege> {
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
            currentUser = const {};
            Navigator.pop(context); // Close dialog
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => SignUpPage()),
            );
          },
          child: const Text("Sign Out", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
