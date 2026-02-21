import 'package:flutter/material.dart';
import 'package:minimart/services/user_service.dart';
import 'package:minimart/utils/assets.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/widgits/Custom_Widget/custom_textfeild.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  final _formKey = GlobalKey<FormState>();
  String _username = "";
  String _email = "";

  @override
  void initState() {
    super.initState();
    final user = UserService().currentUser;
    _username = user["username"] ?? "";
    _email = user["email"] ?? "";
  }

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      UserService().updateProfile(
        _username.trim(),
        _email.trim(),
      );
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Profile updated successfully!"),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context, true);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text(
          "Edit Account",
          style: TextStyle(fontFamily: "Poppins", fontWeight: FontWeight.bold),
        ),
        backgroundColor: surfaceColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),
                Text(
                  "Username",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                CustomField(
                  name: _username,
                  path: usernameIcon,
                  onsave: (value) => _username = value ?? "",
                  onvalidad: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter a username";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  "Email",
                  style: TextStyle(
                    color: textColor,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 8),
                CustomField(
                  name: _email,
                  path: emailIcon,
                  onsave: (value) => _email = value ?? "",
                  onvalidad: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter an email";
                    }
                    if (!value.contains("@")) {
                      return "Please enter a valid email";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 48),
                GestureDetector(
                  onTap: _saveChanges,
                  child: Container(
                    height: 55,
                    decoration: BoxDecoration(
                      gradient: primaryGradient,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Save Changes",
                        style: TextStyle(
                          color: blackColor,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
