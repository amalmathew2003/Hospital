import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Home_Page.dart';
import 'Register_Page.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> sign_in() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email.text.trim(),
        password: password.text.trim(),
      );

      // Navigate to HomePage if login is successful
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage(Userid: email.text.trim())),
      );
    } on FirebaseAuthException catch (e) {
      String message = "Login failed";
      if (e.code == 'user-not-found') {
        message = "No user found for that email.";
      } else if (e.code == 'wrong-password') {
        message = "Wrong password provided.";
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(message)),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("An error occurred. Please try again.")),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SingleChildScrollView(
        child: SafeArea(
            child: Center(
          child: Column(
            children: [
              SizedBox(
                height: 50,
              ),
              Text(
                "W  E  L  C  O  M  E",
                style: GoogleFonts.yesevaOne(
                    fontSize: 20, fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: h * .15,
                  width: w * .30,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/image/project final.png"))),

                  // child: Image(image: AssetImage("assets/image/project final.png"),fit: BoxFit.contain,),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    controller: email,
                    decoration: InputDecoration(
                        hintText: "Email",
                        label: Text("Email"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20)),
                  child: TextFormField(
                    controller: password,
                    decoration: InputDecoration(
                        hintText: "Password",
                        label: Text("Password"),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20))),
                  ),
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      await sign_in();
                      Navigator.push(context,
                          MaterialPageRoute(builder: (BuildContext context) {
                        return HomePage(Userid: 'name',);
                      }));
                    },
                    child: Container(
                      height: h * .070,
                      width: w * 1.0,
                      decoration: BoxDecoration(
                        color: Colors.grey[700],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Center(
                          child: Text(
                        "L O G I N",
                        style: GoogleFonts.yesevaOne(
                            fontWeight: FontWeight.w700,
                            color: Colors.white,
                            fontSize: 19),
                      )),
                    ),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Create a Account",
                      style: GoogleFonts.yesevaOne(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(
                              builder: (BuildContext context) {
                            return RegisterPage();
                          }));
                        },
                        child: Text(
                          "Register Now",
                          style: GoogleFonts.yesevaOne(
                              fontSize: 15, color: Colors.blueAccent),
                        )),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                ],
              )
            ],
          ),
        )),
      ),
    );
  }
}
