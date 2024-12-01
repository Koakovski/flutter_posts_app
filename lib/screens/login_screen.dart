import 'package:flutter/material.dart';
import 'package:posts_app/components/login_button.dart';
import 'package:posts_app/components/login_input.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
                      ),
                      const SizedBox(height: 16),
                      LoginInput(
                        title: "Password",
                        controller: _passwordController,
                        obscureText: true,
                      ),
                      const SizedBox(height: 16),
                      LoginButton(
                        onPressed: () {
                          if (_formKey.currentState == null) return;
                          bool isValidated = _formKey.currentState!.validate();
                          if (isValidated == false) return;

                          // String username = _usernameController.text.trim();
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
