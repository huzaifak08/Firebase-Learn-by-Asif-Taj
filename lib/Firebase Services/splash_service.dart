import 'dart:async';

import 'package:firebase_flutter/UI/auth/login_screen.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void isLogin(BuildContext context) {
    // Splash Screen Duration Code:
    Timer(
      Duration(seconds: 3),
      () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => LoginScrren(),
          ),
        );
      },
    );
  }
}
