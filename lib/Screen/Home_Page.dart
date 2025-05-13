import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Hospital_Details_Screen.dart'; // Make sure to import the right file

class HomePage extends StatefulWidget {
  final String Userid;
  const HomePage({super.key, required this.Userid});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final user = FirebaseAuth.instance.currentUser;

  Future<String?> getuser() async {
    DocumentSnapshot doc = await FirebaseFirestore.instance
        .collection('user')
        .doc(widget.Userid)
        .get();

    print('User document: ${doc.data()}');

    if (doc.exists && doc.data() != null) {
      final data = doc.data() as Map<String, dynamic>;
      return data['name'];
    }
    return null;
  }


  Future<void> Logout(BuildContext context) async {
    await FirebaseAuth.instance.signOut();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Signed out successfully')),
    );

    Navigator.pushReplacementNamed(context, '/login');
  }

  List<String> district = [
    "Thiruvananthapuram",
    "Kollam",
    "Pathanamthitta",
    "Alappuzha",
    "Kottayam",
    "Idukki",
    "Ernakulam",
    "Thrissur",
    "Palakkad",
    "Malappuram",
    "Kozhikode",
    "Wayanad",
    "Kannur",
    "Kasaragod"
  ];

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final h = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "S E L E C T   Y O U R   D I S T R I C T",
          style: GoogleFonts.yesevaOne(fontSize: 16, fontWeight: FontWeight.w700),
        ),
      ),
      drawer: Drawer(
        width: min(MediaQuery.of(context).size.width, 350),
        elevation: 4,
        shadowColor: Colors.grey,
        child: FutureBuilder<String?>(
          future: getuser(),
          builder: (BuildContext context, AsyncSnapshot<String?> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }
            if (!snapshot.hasData) {
              return Center(child: Text('No user data found.'));
            }
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  SizedBox(
                    height: h * .10,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Align(
                      alignment: Alignment.center,
                      child: Text(
                        "W E L C O M E",
                        style: GoogleFonts.yesevaOne(fontSize: 27),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${snapshot.data}",
                      style: GoogleFonts.yesevaOne(fontSize: 20),
                    ),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "${user?.email}",
                        style: GoogleFonts.yesevaOne(fontSize: 15),
                      ),
                    ),
                  ),
                  TextButton(
                    onPressed: () => Logout(context),
                    child: Text("LOG OUT"),
                  ),
                ],
              ),
            );
          },
        ),
      ),
      body: Column(
        children: [
          Text(
            "D I S T R I C T S",
            style: GoogleFonts.yesevaOne(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: district.length,
              itemBuilder: (BuildContext context, int index) {
                return Card(
                  elevation: 4,
                  child: ListTile(
                    title: Text("${district[index]}"),
                    onTap: () {
                      // Use district[index] to pass the correct district to HospitalListPage
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) {
                            return HospitalListPage(district: district[index]);
                          },
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
