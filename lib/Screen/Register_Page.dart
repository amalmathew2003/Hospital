import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Home_Page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController name=TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  Future sign_up() async {
    String Username=name.text.trim();
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: email.text.trim(), password: password.text.trim());
    FirebaseFirestore.instance.collection('user').doc('Userid').set({'name':Username});
  }
  // Future<void> Saveuser(String Userid) async {
  //   String Username=name.text.trim();
  //   if(Username.isNotEmpty){
  //     await FirebaseFirestore.instance.collection('user').doc("Userid").set({
  //       'name':Username,
  //     });
  //   }
  // }

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
                    controller: name,
                    decoration: InputDecoration(
                        hintText: "User Name",
                        label: Text("Name"),
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

                     await sign_up();

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
                        "R E G I S T E R",
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
                      "I Have a Account",
                      style: GoogleFonts.yesevaOne(fontSize: 15),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          "Sign Now",
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
