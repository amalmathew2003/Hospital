import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Doctor_Screen.dart';

class HospitalListPage extends StatelessWidget {
  final String district;

  const HospitalListPage({required this.district});

  @override
  Widget build(BuildContext context) {
    final hospitalsRef = FirebaseFirestore.instance
        .collection('hospitals')
        .where('d', isEqualTo: district.trim());

    print("Looking for hospitals in: '${district.trim()}'");

    return Scaffold(
      appBar: AppBar(
          title: Text(
        "Hospitals in $district",
        style: GoogleFonts.yesevaOne(fontWeight: FontWeight.bold),
      )),
      body: StreamBuilder<QuerySnapshot>(
        stream: hospitalsRef.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text("No hospitals found in $district"));
          }

          final hospitals = snapshot.data!.docs;
          return ListView.separated(
            scrollDirection: Axis.vertical,
            itemCount: hospitals.length,
            itemBuilder: (context, index) {
              final data = hospitals[index].data() as Map<String, dynamic>;
              final w = MediaQuery.of(context).size.width;
              final h = MediaQuery.of(context).size.height;
              return Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        // Navigate to the Doctor List Page when hospital is tapped
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => DoctorListPage(
                                hospitalId: hospitals[index].id,
                                hospitalName: data['name'],
                              hospitalimage: data['i'],
                            hospitallocatin:data['location']),
                          ),
                        );
                      },
                      child: Container(
                        width: w * .9,
                        height: h * .3,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.grey,
                            image: DecorationImage(
                                image: NetworkImage(data['i'] ?? ''),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: Text(
                          data['name'],
                          style: GoogleFonts.yesevaOne(
                              fontSize: 22, fontWeight: FontWeight.w600),
                        ))
                  ],
                ),
              );
            },
            separatorBuilder: (BuildContext context, int index) {
              return SizedBox(
                height: 5,
              );
            },
          );
        },
      ),
    );
  }
}
