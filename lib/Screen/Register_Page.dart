import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Home_Page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> signUpUser() async {
    String username = name.text.trim();
    String userEmail = email.text.trim();
    String userPassword = password.text.trim();

    if (username.isEmpty || userEmail.isEmpty || userPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    try {
      // Firebase Authentication
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: userEmail, password: userPassword);

      String uid = userCredential.user!.uid;

      // Save to Firestore
      await FirebaseFirestore.instance.collection('user').doc(uid).set({
        'name': username,
        'email': userEmail,
      });

      // Navigate to HomePage
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(Userid: uid),
        ),
      );
    } catch (e) {
      print("Error during sign up: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Signup failed: ${e.toString()}')),
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
                SizedBox(height: 50),
                Text(
                  "W  E  L  C  O  M  E",
                  style: GoogleFonts.yesevaOne(
                      fontSize: 20, fontWeight: FontWeight.w700),
                ),
                SizedBox(height: 10),
                Container(
                  height: h * .15,
                  width: w * .30,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/image/project final.png"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildTextField(
                    controller: name,
                    hint: "User Name",
                    label: "Name",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildTextField(
                    controller: email,
                    hint: "Email",
                    label: "Email",
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: buildTextField(
                    controller: password,
                    hint: "Password",
                    label: "Password",
                    obscure: true,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () async {
                      await signUpUser(); // ✅ This handles sign-up and navigation
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
                            fontSize: 19,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "I Have an Account",
                        style: GoogleFonts.yesevaOne(fontSize: 15),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          Navigator.pop(context); // back to login
                        },
                        child: Text(
                          "Sign Now",
                          style: GoogleFonts.yesevaOne(
                              fontSize: 15, color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField({
    required TextEditingController controller,
    required String hint,
    required String label,
    bool obscure = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(20),
      ),
      child: TextFormField(
        controller: controller,
        obscureText: obscure,
        decoration: InputDecoration(
          hintText: hint,
          label: Text(label),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
      ),
    );
  }
}
