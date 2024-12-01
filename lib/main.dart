import 'package:flutter/material.dart';
import 'package:posts_app/screens/login_screen.dart';
import 'package:posts_app/util/logged_user_handler.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blueAccent),
        useMaterial3: true,
      ),
      home: FutureBuilder<bool>(
        future: LoggedUserHandler.isUserLoggedIn(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          } else if (snapshot.hasData && snapshot.data == true) {
            return const Placeholder();
          } else {
            return const LoginScreen();
          }
        },
      ),
    );
  }
}
