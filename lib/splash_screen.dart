import 'package:flutter/material.dart';
import 'package:posts_app/screens/home_screen.dart';
import 'package:posts_app/screens/login_screen.dart';
import 'package:posts_app/util/logged_user_handler.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  int? userId;

  @override
  void initState() {
    super.initState();
    checkLoginStatus();
  }

  Future<void> checkLoginStatus() async {
    int? userId = await LoggedUserHandler.userId();
    setState(() {
      userId = userId;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return LoginScreen(onLogin: (id) async {
        await LoggedUserHandler.loggin(id);
        setState(() {
          userId = id;
        });
      });
    } else {
      return HomeScreen(
        userId: userId!,
        onLoggout: () async {
          await LoggedUserHandler.loggout();
          setState(() {
            userId = null;
          });
        },
      );
    }
  }
}
