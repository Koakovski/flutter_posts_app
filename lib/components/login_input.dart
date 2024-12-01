import 'package:flutter/material.dart';
import 'package:posts_app/types/input_validatior.dart';

class LoginInput extends StatelessWidget {
  late final String _title;
  late final TextEditingController? _controller;
  late final bool _obscureText;
  late final List<InputValidator<String>> _validators;

  LoginInput({
    super.key,
    required String title,
    TextEditingController? controller,
    bool? obscureText,
    List<InputValidator<String>>? validators,
  }) {
    _title = title;
    _controller = controller;
    _obscureText = obscureText ?? false;
    _validators = validators ?? [];
  }

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: _controller,
      obscureText: _obscureText,
      validator: (value) {
        return _validators
            .map((validate) => validate(value))
            .firstWhere((error) => error != null, orElse: () => null);
      },
      decoration: InputDecoration(
        labelText: _title,
        contentPadding: const EdgeInsets.all(5),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    );
  }
}
