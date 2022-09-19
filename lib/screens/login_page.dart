// ignore_for_file: unnecessary_const

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sparks_social_media/screens/homepage.dart';

import '../provider/signin_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final GlobalKey _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 236, 234, 234),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: SafeArea(
        child: Column(
          children: [
            //image or animation
            Padding(
              padding: const EdgeInsets.only(top: 50),
              child: Image.asset("assets/image/logo_small.png"),
            ),
            // ignore: prefer_const_constructors
            Text(
              "Welcome to Sparks Foundation",
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 100,
            ),
            //login through google
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: ElevatedButton(
                onPressed: () {
                  handleFacebookSignIn();
                },
                // ignore: sort_child_properties_last
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Image.asset(
                        "assets/image/facebook_icon.png",
                        height: 35,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 15.0),
                      child: Text(
                        "Login With FaceBook",
                        style: const TextStyle(
                            color: Color.fromARGB(255, 255, 255, 255),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    primary: const Color.fromARGB(255, 17, 17, 183),
                    minimumSize: const Size(60, 60)),
              ),
            ),
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 60),
              child: ElevatedButton(
                onPressed: () {
                  handleGoogleSignIn();
                },
                // ignore: sort_child_properties_last
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,

                  // ignore: prefer_const_literals_to_create_immutables
                  children: [
                    Image.asset(
                      "assets/image/google_icon.png",
                      height: 30,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(right: 30.0),
                      child: Text(
                        "Login With Google",
                        style: TextStyle(
                            color: Color.fromARGB(255, 85, 84, 84),
                            fontSize: 18,
                            fontWeight: FontWeight.w500),
                      ),
                    )
                  ],
                ),
                style: ElevatedButton.styleFrom(
                    primary: Colors.white, minimumSize: const Size(60, 60)),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future handleGoogleSignIn() async {
    final sp = context.read<SignInProvider>();
    await sp.signInWithGoogle().then((value) {
      if (sp.hasError == true) {
        print('error');
      } else {
        sp.checkUserExists().then((value) async {
          if (value == true) {
            await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                .saveDataToSharedPreferences()
                .then((value) => sp.setSignIn().then((value) {
                      handleAfterSignIn();
                    })));
          } else {
            sp.saveDataToFirestore().then((value) => sp
                .saveDataToSharedPreferences()
                .then((value) => sp.setSignIn().then((value) {
                      handleAfterSignIn();
                    })));
          }
        });
      }
    });
  }

  Future handleFacebookSignIn() async {
    final sp = context.read<SignInProvider>();
    await sp.signInWithFacebook().then((value) {
      if (sp.hasError == true) {
        print('error');
      } else {
        sp.checkUserExists().then((value) async {
          if (value == true) {
            await sp.getUserDataFromFirestore(sp.uid).then((value) => sp
                .saveDataToSharedPreferences()
                .then((value) => sp.setSignIn().then((value) {
                      handleAfterSignIn();
                    })));
          } else {
            sp.saveDataToFirestore().then((value) => sp
                .saveDataToSharedPreferences()
                .then((value) => sp.setSignIn().then((value) {
                      handleAfterSignIn();
                    })));
          }
        });
      }
    });
  }

  handleAfterSignIn() {
    Future.delayed(const Duration(milliseconds: 1000)).then((value) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
    });
  }
}
