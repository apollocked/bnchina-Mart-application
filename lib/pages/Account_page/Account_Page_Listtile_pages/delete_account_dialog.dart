import 'package:flutter/material.dart';
import 'package:minimart/pages/Authotication/register_page.dart';
import 'package:minimart/services/user_service.dart';

class DeleteAccountDialog extends StatefulWidget {
  const DeleteAccountDialog({super.key});

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  void _deleteAccount() {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    final enteredPassword = _passwordController.text.trim();
    final actualPassword = UserService().currentUser["password"];

    if (enteredPassword.isEmpty) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Password cannot be empty.';
      });
      return;
    }

    if (enteredPassword != actualPassword) {
      setState(() {
        _isLoading = false;
        _errorMessage = 'Incorrect password.';
      });
      return;
    }

    // Success
    UserService().deleteAccount();
    Navigator.pop(context); // Close dialog
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => SignUpPage()),
    );
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Delete Account", style: TextStyle(color: Colors.red)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            "This action is permanent and cannot be undone. Please enter your password to confirm.",
            style: TextStyle(fontSize: 14),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _passwordController,
            obscureText: true,
            decoration: InputDecoration(
              hintText: 'Current Password',
              errorText: _errorMessage.isEmpty ? null : _errorMessage,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: _isLoading ? null : () => Navigator.pop(context),
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: _isLoading ? null : _deleteAccount,
          child: _isLoading
              ? const SizedBox(
                  height: 16,
                  width: 16,
                  child: CircularProgressIndicator(strokeWidth: 2))
              : const Text("Delete", style: TextStyle(color: Colors.red)),
        ),
      ],
    );
  }
}
