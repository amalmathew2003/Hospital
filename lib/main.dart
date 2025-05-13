import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitals/Screen/Home_Page.dart';

import 'Firebase/firebase_options.dart';
import 'Screen/Auth_page.dart';
import 'Screen/Login_Screen.dart';
import 'Screen/Spalch_Screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(app());
}

class app extends StatelessWidget {
  const app({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SpalchScreen(),
      initialRoute: '/splash',
      routes: {
        '/splash':(context)=>SpalchScreen(),
        '/login':(context)=>LoginScreen(),
       '/home':(context)=>HomePage(Userid: "Userid")
      }
    );
  }
}
