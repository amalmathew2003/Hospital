import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'Booking_page.dart';

class DoctorListPage extends StatelessWidget {
  final String hospitalId;
  final String hospitalName;
  final String hospitalimage;
  final String hospitallocatin; // Add hospitalName field

  const DoctorListPage(
      {super.key,
      required this.hospitalId,
      required this.hospitalName,
      required this.hospitalimage,
      required this.hospitallocatin}); // Add hospitalName to constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            pinned: true,
            expandedHeight: 260,
            flexibleSpace: FlexibleSpaceBar(
              background: Image(
                image: NetworkImage(hospitalimage),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('hospitals')
                  .doc(hospitalId)
                  .collection('doctors')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }
                final doctors = snapshot.data!.docs;
                if (doctors.isEmpty) {
                  return const Center(child: Text('No doctors found.'));
                }
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        hospitalName,
                        style: GoogleFonts.yesevaOne(fontSize: 20),
                      ),
                    ),
                    Text(
                      hospitallocatin,
                      style: GoogleFonts.yesevaOne(fontSize: 16),
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: doctors.length,
                      itemBuilder: (context, index) {
                        final doctor = doctors[index];
                        final doctorId = doctor.id;
                        final doctorName = doctor['name'];
                        final availableTime = doctor['availableTime'];
                        final specialty = doctor['specialty'];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 15,
                            child: Container(
                              height: 100,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ListTile(
                                    leading: Icon(Icons.person, size: 35),
                                    title: Text(
                                      doctorName,
                                      style: GoogleFonts.yesevaOne(
                                        fontSize: 19,
                                      ),
                                    ),
                                    subtitle: Text(
                                      availableTime,
                                      style: GoogleFonts.yesevaOne(),
                                    ),
                                    trailing: Text(
                                      specialty,
                                      style:
                                          GoogleFonts.yesevaOne(fontSize: 17),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => DoctorBookingPage(
                                            hospitalname: hospitalName,
                                            doctorId: doctorId,
                                            doctorName: doctorName,
                                            availableTime: availableTime,
                                            specialty: specialty,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}

