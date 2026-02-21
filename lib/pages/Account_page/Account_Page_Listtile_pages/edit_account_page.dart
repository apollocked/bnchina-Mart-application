import 'package:flutter/material.dart';
import 'package:minimart/services/user_service.dart';
import 'package:minimart/utils/assets.dart';
import 'package:minimart/utils/colors.dart';
import 'package:minimart/widgits/Item_Lests/custom_list_tile.dart';

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
    final TextEditingController controller =
        TextEditingController(text: isPassword ? "" : initialValue);
    final TextEditingController? confirmController =
        isPassword ? TextEditingController() : null;
    final TextEditingController? oldPasswordController =
        isPassword ? TextEditingController() : null;
    final formKey = GlobalKey<FormState>();

    bool obscureOld = true;
    bool obscureNew = true;
    bool obscureConfirm = true;

    showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => StatefulBuilder(
              builder: (context, setModalState) => Container(
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom + 20,
                  left: 20,
                  right: 20,
                  top: 20,
                ),
                decoration: BoxDecoration(
                  color: surfaceColor,
                  borderRadius:
                      const BorderRadius.vertical(top: Radius.circular(24)),
                ),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        title,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: primaryColor,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          fontFamily: "Poppins",
                        ),
                      ),
                      const SizedBox(height: 20),
                      if (isPassword) ...[
                        TextFormField(
                          controller: oldPasswordController,
                          obscureText: obscureOld,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            labelText: "Old Password",
                            labelStyle: TextStyle(color: subTextColor),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                iconPath,
                                color: primaryColor,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureOld
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: primaryColor.withOpacity(0.7),
                                size: 20,
                              ),
                              onPressed: () =>
                                  setModalState(() => obscureOld = !obscureOld),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                  color: primaryColor.withOpacity(0.2)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide:
                                  BorderSide(color: primaryColor, width: 2),
                            ),
                          ),
                          validator: (v) {
                            if (v == null || v.isEmpty) {
                              return "Old password is required";
                            }
                            if (v != UserService().currentUser["password"]) {
                              return "Incorrect old password";
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 15),
                      ],
                      TextFormField(
                        controller: controller,
                        obscureText: isPassword ? obscureNew : false,
                        style: TextStyle(color: textColor),
                        decoration: InputDecoration(
                          labelText: label,
                          labelStyle: TextStyle(color: subTextColor),
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Image.asset(
                              iconPath,
                              color: primaryColor,
                              width: 20,
                              height: 20,
                            ),
                          ),
                          suffixIcon: isPassword
                              ? IconButton(
                                  icon: Icon(
                                    obscureNew
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: primaryColor.withOpacity(0.7),
                                    size: 20,
                                  ),
                                  onPressed: () => setModalState(
                                      () => obscureNew = !obscureNew),
                                )
                              : null,
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(
                                color: primaryColor.withOpacity(0.2)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide:
                                BorderSide(color: primaryColor, width: 2),
                          ),
                          errorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: errorColor),
                          ),
                          focusedErrorBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(14),
                            borderSide: BorderSide(color: errorColor, width: 2),
                          ),
                        ),
                        validator: validator ??
                            (v) {
                              if (v == null || v.isEmpty) {
                                return "$label is required";
                              }
                              return null;
                            },
                      ),
                      if (isPassword) ...[
                        const SizedBox(height: 15),
                        TextFormField(
                          controller: confirmController,
                          obscureText: obscureConfirm,
                          style: TextStyle(color: textColor),
                          decoration: InputDecoration(
                            labelText: "Confirm New Password",
                            labelStyle: TextStyle(color: subTextColor),
                            prefixIcon: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Image.asset(
                                iconPath,
                                color: primaryColor,
                                width: 20,
                                height: 20,
                              ),
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                obscureConfirm
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: primaryColor.withOpacity(0.7),
                                size: 20,
                              ),
                              onPressed: () => setModalState(
                                  () => obscureConfirm = !obscureConfirm),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(
                                  color: primaryColor.withOpacity(0.2)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide:
                                  BorderSide(color: primaryColor, width: 2),
                            ),
                            errorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide: BorderSide(color: errorColor),
                            ),
                            focusedErrorBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(14),
                              borderSide:
                                  BorderSide(color: errorColor, width: 2),
                            ),
                          ),
                          validator: (v) {
                            if (v != controller.text) {
                              return "Passwords do not match";
                            }
                            return null;
                          },
                        ),
                      ],
                      const SizedBox(height: 30),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: primaryColor,
                          foregroundColor: blackColor,
                          padding: const EdgeInsets.symmetric(vertical: 18),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          elevation: 4,
                        ),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            onSave(controller.text);
                            Navigator.pop(context);
                            setState(() {});
                          }
                        },
                        child: const Text(
                          "Save Changes",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ));
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
}
