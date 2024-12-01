import 'package:posts_app/types/input_validatior.dart';

InputValidator<String> notEmptyTextInputValidator = (String? value) {
  if (value == null || value.trim().isEmpty) {
    return 'This field should not be empty';
  }

  return null;
};
