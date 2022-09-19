import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sparks_social_media/screens/homepage.dart';
import 'package:sparks_social_media/screens/login_page.dart';

import '../provider/signin_provider.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    final sp = context.read<SignInProvider>();
    super.initState();
    // create a timer of 2 seconds
    Timer(const Duration(seconds: 2), () {
      sp.isSignedIn == false
          ? Navigator.push(
              context, MaterialPageRoute(builder: (_) => LoginPage()))
          : Navigator.push(
              context, MaterialPageRoute(builder: (_) => HomePage()));
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Color.fromARGB(255, 227, 227, 227),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/image/logo_small.png",
                height: 130,
                width: 130,
              )
            ],
          ),
        ));
  }
}
