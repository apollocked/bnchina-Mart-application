import 'dart:io';
import 'package:flutter/material.dart';
import 'package:minimart/pages/account/account_sub_pages/profile_image_picker_page.dart';
import 'package:minimart/pages/account/components/edit_profile_bottom_sheet.dart';
import 'package:minimart/services/user_service.dart';
import 'package:minimart/utils/assets.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/widgets/item_lists/custom_list_tile.dart';

class EditAccountPage extends StatefulWidget {
  const EditAccountPage({super.key});

  @override
  State<EditAccountPage> createState() => _EditAccountPageState();
}

class _EditAccountPageState extends State<EditAccountPage> {
  void _showEditBottomSheet({
    required String title,
    required String label,
    required String initialValue,
    required String iconPath,
    required Function(String) onSave,
    String? Function(String?)? validator,
    bool isPassword = false,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => EditProfileBottomSheet(
        title: title,
        label: label,
        initialValue: initialValue,
        iconPath: iconPath,
        onSave: onSave,
        validator: validator,
        isPassword: isPassword,
      ),
    ).then((updated) {
      if (updated == true && mounted) {
        setState(() {});
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = UserService().currentUser;
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
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildProfileHeader(context),
          const SizedBox(height: 20),
          CustomTile(
            text: "Username: ${user["username"]}",
            icon: Icon(Icons.person_outline, color: primaryColor),
            ontap: () => _showEditBottomSheet(
              title: "Update Username",
              label: "New Username",
              initialValue: user["username"],
              iconPath: usernameIcon,
              onSave: (val) => UserService().updateProfile(val, user["email"]),
            ),
          ),
          CustomTile(
            text: "Email: ${user["email"]}",
            icon: Icon(Icons.email_outlined, color: primaryColor),
            ontap: () => _showEditBottomSheet(
              title: "Update Email",
              label: "New Email",
              initialValue: user["email"],
              iconPath: emailIcon,
              onSave: (val) =>
                  UserService().updateProfile(user["username"], val),
              validator: (v) {
                if (v == null || !v.contains("@")) {
                  return "Invalid email address";
                }
                return null;
              },
            ),
          ),
          CustomTile(
            text: "Change Password",
            icon: Icon(Icons.lock_outline, color: primaryColor),
            ontap: () => _showEditBottomSheet(
              title: "Change Password",
              label: "New Password",
              initialValue: "",
              iconPath: passwordIcon,
              isPassword: true,
              onSave: (val) => UserService().updatePassword(val),
              validator: (v) {
                if (v == null || v.length < 8) {
                  return "Password must be at least 8 characters";
                }
                return null;
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(BuildContext context) {
    final user = UserService().currentUser;
    final path = user["profileImagePath"];
    final isCustom = user["isCustomImage"] ?? false;

    ImageProvider? image;
    if (path == null || path.isEmpty) {
      image = null;
    } else if (isCustom) {
      image = FileImage(File(path));
    } else {
      image = AssetImage(path);
    }

    return Center(
      child: Column(
        children: [
          Stack(
            children: [
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: primaryGradient,
                ),
                child: CircleAvatar(
                  radius: 60,
                  backgroundImage: image,
                  backgroundColor: surfaceColor,
                  child: image == null
                      ? Icon(Icons.person, size: 70, color: primaryColor)
                      : null,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: GestureDetector(
                  onTap: () async {
                    final updated = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfileImagePickerPage(),
                      ),
                    );
                    if (updated == true) {
                      setState(() {});
                    }
                  },
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.camera_alt, color: blackColor, size: 20),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "Profile Picture",
            style: TextStyle(
              color: textColor,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
