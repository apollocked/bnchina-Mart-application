import 'package:flutter/material.dart';
import 'package:minimart/services/user_service.dart';
import 'package:minimart/utils/colors.dart';

class EditProfileBottomSheet extends StatefulWidget {
  final String title;
  final String label;
  final String initialValue;
  final String iconPath;
  final Function(String) onSave;
  final String? Function(String?)? validator;
  final bool isPassword;

  const EditProfileBottomSheet({
    super.key,
    required this.title,
    required this.label,
    required this.initialValue,
    required this.iconPath,
    required this.onSave,
    this.validator,
    this.isPassword = false,
  });

  @override
  State<EditProfileBottomSheet> createState() => _EditProfileBottomSheetState();
}

class _EditProfileBottomSheetState extends State<EditProfileBottomSheet> {
  late TextEditingController controller;
  late TextEditingController? confirmController;
  late TextEditingController? oldPasswordController;
  final formKey = GlobalKey<FormState>();

  bool obscureOld = true;
  bool obscureNew = true;
  bool obscureConfirm = true;

  @override
  void initState() {
    super.initState();
    controller = TextEditingController(
        text: widget.isPassword ? "" : widget.initialValue);
    confirmController = widget.isPassword ? TextEditingController() : null;
    oldPasswordController = widget.isPassword ? TextEditingController() : null;
  }

  @override
  void dispose() {
    controller.dispose();
    confirmController?.dispose();
    oldPasswordController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
        left: 20,
        right: 20,
        top: 20,
      ),
      decoration: BoxDecoration(
        color: surfaceColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: Form(
        key: formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              widget.title,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: primaryColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: "Poppins",
              ),
            ),
            const SizedBox(height: 20),
            if (widget.isPassword) ...[
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
                      widget.iconPath,
                      color: primaryColor,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureOld ? Icons.visibility_off : Icons.visibility,
                      color: primaryColor.withOpacity(0.7),
                      size: 20,
                    ),
                    onPressed: () => setState(() => obscureOld = !obscureOld),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        BorderSide(color: primaryColor.withOpacity(0.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: primaryColor, width: 2),
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
              obscureText: widget.isPassword ? obscureNew : false,
              style: TextStyle(color: textColor),
              decoration: InputDecoration(
                labelText: widget.label,
                labelStyle: TextStyle(color: subTextColor),
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Image.asset(
                    widget.iconPath,
                    color: primaryColor,
                    width: 20,
                    height: 20,
                  ),
                ),
                suffixIcon: widget.isPassword
                    ? IconButton(
                        icon: Icon(
                          obscureNew ? Icons.visibility_off : Icons.visibility,
                          color: primaryColor.withOpacity(0.7),
                          size: 20,
                        ),
                        onPressed: () =>
                            setState(() => obscureNew = !obscureNew),
                      )
                    : null,
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: primaryColor.withOpacity(0.2)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(14),
                  borderSide: BorderSide(color: primaryColor, width: 2),
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
              validator: widget.validator ??
                  (v) {
                    if (v == null || v.isEmpty) {
                      return "${widget.label} is required";
                    }
                    return null;
                  },
            ),
            if (widget.isPassword) ...[
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
                      widget.iconPath,
                      color: primaryColor,
                      width: 20,
                      height: 20,
                    ),
                  ),
                  suffixIcon: IconButton(
                    icon: Icon(
                      obscureConfirm ? Icons.visibility_off : Icons.visibility,
                      color: primaryColor.withOpacity(0.7),
                      size: 20,
                    ),
                    onPressed: () =>
                        setState(() => obscureConfirm = !obscureConfirm),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide:
                        BorderSide(color: primaryColor.withOpacity(0.2)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(14),
                    borderSide: BorderSide(color: primaryColor, width: 2),
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
                  widget.onSave(controller.text);
                  Navigator.pop(context, true);
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
    );
  }
}
