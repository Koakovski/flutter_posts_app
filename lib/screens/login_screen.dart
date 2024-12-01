import 'package:flutter/material.dart';
import 'package:posts_app/classes/user.dart';
import 'package:posts_app/components/show_toast.dart';
import 'package:posts_app/util/input_validators/not_empty_text_form_input_validator.dart';
import 'package:posts_app/util/result.dart';
import 'package:posts_app/components/login_button.dart';
import 'package:posts_app/components/login_input.dart';
import 'package:posts_app/service/user_service.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  final UserService _userService = UserService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Center(
        child: Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 24,
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      LoginInput(
                        title: "Username",
                        controller: _usernameController,
                        validators: [notEmptyTextInputValidator],
                      ),
                      const SizedBox(height: 16),
                      LoginInput(
                        title: "Password",
                        controller: _passwordController,
                        obscureText: true,
                        validators: [notEmptyTextInputValidator],
                      ),
                      const SizedBox(height: 16),
                      LoginButton(
                        onPressed: () async {
                          if (_formKey.currentState == null) return;
                          bool isValidated = _formKey.currentState!.validate();
                          if (isValidated == false) return;

                          String username = _usernameController.text.trim();
                          Result<User?> result =
                              await _userService.findOneByUsername(username);

                          if (result.isSuccess) {
                            print(result.data!.username);
                          } else {
                            showToast(
                              context,
                              result.errorMessage!,
                              severity: ToastSeverity.error,
                            );
                          }
                          // String password = _passwordController.text.trim();
                        },
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}
