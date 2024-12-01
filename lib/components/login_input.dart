import 'package:flutter/material.dart';

class LoginInput extends StatelessWidget {
  late final String _title;
  late final TextEditingController? _controller;
  late final bool _obscureText;

  LoginInput({
    super.key,
    required String title,
    TextEditingController? controller,
    bool? obscureText,
  }) {
    _title = title;
    _controller = controller;
    _obscureText = obscureText ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      obscureText: _obscureText,
      decoration: InputDecoration(
        labelText: _title,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
