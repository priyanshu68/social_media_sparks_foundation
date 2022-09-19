import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:sparks_social_media/screens/splash_screen.dart';
import 'package:provider/provider.dart';
import '../provider/signin_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => SignInProvider()),
        ),
      ],
      child: const MaterialApp(
        home: SplashScreen(),
      ),
    );
  }
}
