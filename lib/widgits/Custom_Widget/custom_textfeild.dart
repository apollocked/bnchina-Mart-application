import 'package:minimart/utils/colors.dart';
import 'package:flutter/material.dart';

class CustomField extends StatefulWidget {
  const CustomField({
    super.key,
    required this.onvalidad,
    required this.onsave,
    required this.path,
    required this.name,
    this.obscureText = false,
  });

  final String? Function(String? value) onvalidad;
  final void Function(String? value) onsave;
  final String path;
  final String name;
  final bool obscureText;

  @override
  State<CustomField> createState() => _CustomFieldState();
}

class _CustomFieldState extends State<CustomField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      obscureText: _obscureText,
      keyboardType: widget.name.toLowerCase().contains('email')
          ? TextInputType.emailAddress
          : TextInputType.text,
      style: TextStyle(color: textColor, fontSize: 15),
      decoration: InputDecoration(
        filled: true,
        fillColor: surfaceColor,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 18, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primaryColor.withOpacity(0.3)),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide:
              BorderSide(color: primaryColor.withOpacity(0.25), width: 1.2),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: primaryColor, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide(color: errorColor, width: 1.2),
        ),
        hintText: widget.name,
        hintStyle: TextStyle(color: subTextColor, fontSize: 14),
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12),
          child: Image.asset(
            widget.path,
            color: primaryColor,
            width: 20,
            height: 20,
          ),
        ),
        suffixIcon: widget.obscureText
            ? IconButton(
                icon: Icon(
                  _obscureText ? Icons.visibility_off : Icons.visibility,
                  color: primaryColor.withOpacity(0.7),
                  size: 20,
                ),
                onPressed: () {
                  setState(() {
                    _obscureText = !_obscureText;
                  });
                },
              )
            : null,
      ),
      onSaved: widget.onsave,
      validator: widget.onvalidad,
    );
  }
}
