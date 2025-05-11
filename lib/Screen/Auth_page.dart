import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hospitals/Screen/Home_Page.dart';
import 'package:hospitals/Screen/Login_Screen.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, snapshot) {
        if(snapshot.connectionState==ConnectionState.waiting){
          return Center( child: CircularProgressIndicator(),);

        }else if(snapshot.hasData){
          return HomePage(Userid: 'name');
        }else{
          return LoginScreen();
        }
      },
    );
  }
}
