import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'confirm_page.dart';

class DoctorBookingPage extends StatefulWidget {
  final String hospitalname;
  final String doctorId;
  final String doctorName;
  final String availableTime;
  final String specialty;

  const DoctorBookingPage({
    super.key,
    required this.hospitalname,
    required this.doctorId,
    required this.doctorName,
    required this.availableTime,
    required this.specialty,
  });

  @override
  State<DoctorBookingPage> createState() => _DoctorBookingPageState();
}

class _DoctorBookingPageState extends State<DoctorBookingPage> {
  int maxSlots = 0;
  int bookedCount = 0;
  bool isLoading = true;
  final TextEditingController nameController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadDoctorData();
  }

  Future<void> loadDoctorData() async {
    setState(() => isLoading = true);

    try {
      final doctorDoc = await FirebaseFirestore.instance
          .collection('hospitals')
          .doc(widget.hospitalname)
          .collection('doctors')
          .doc(widget.doctorId)
          .get();

      final data = doctorDoc.data();
      if (data == null) {
        print('Doctor document not found.');
        setState(() => isLoading = false);
        return;
      }

      // Debugging: Print doctor data
      print("Doctor Data: $data");

      maxSlots = data['maxSlots'] ?? 0;
      print('maxSlots: $maxSlots');

      final bookingsSnapshot = await FirebaseFirestore.instance
          .collection('hospitals')
          .doc(widget.hospitalname)
          .collection('doctors')
          .doc(widget.doctorId)
          .collection('bookings')
          .get();

      bookedCount = bookingsSnapshot.docs.length;
      print('Booked Count: $bookedCount'); // Debugging: Print bookedCount

      setState(() => isLoading = false);
    } catch (e) {
      print('Error loading doctor data: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> bookSlot() async {
    final name = nameController.text.trim();
    if (name.isEmpty) return; // Ensure the name is not empty.

    final availableSlots = maxSlots - bookedCount;
    if (availableSlots <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('No available slots.')),
      );
      return;
    }

    final bookingRef = FirebaseFirestore.instance
        .collection('hospitals')
        .doc(widget.hospitalname)
        .collection('doctors')
        .doc(widget.doctorId)
        .collection('bookings');

    final bookingNumber = DateTime.now().millisecondsSinceEpoch.toString();

    final slotNumber = bookedCount + 1;

    await bookingRef.add({
      'patientName': name,
      'slot': 'Slot $slotNumber',
      'bookingNumber': bookingNumber,
      'timestamp': Timestamp.now(),
    }).then((value) {
      print('Booking added successfully!');
    }).catchError((e) {
      print('Error adding booking: $e');
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Booking confirmed for $name.')),
    );

    nameController.clear();
    await loadDoctorData();

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BookingConfirmationPage(
          hospitalName: widget.hospitalname,
          doctorName: widget.doctorName,
          patientName: name,
          slot: 'Slot $slotNumber',
          bookingNumber: bookingNumber,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final availableSlots = maxSlots - bookedCount;

    return Scaffold(
      appBar: AppBar(
          title: Text(
        'B O O K   Y O U R   D O C T O R',
        style: GoogleFonts.yesevaOne(),
      )),
      body: SingleChildScrollView(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("N A M E:  ${widget.doctorName}",
                            style: GoogleFonts.yesevaOne(
                              fontSize: 19,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("S P E C I A L T Y:  ${widget.specialty}",
                            style: GoogleFonts.yesevaOne(
                              fontSize: 19,
                            )),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: Text("Doctor Time:  ${widget.availableTime}",
                            style: GoogleFonts.yesevaOne(
                                fontSize: 19, color: Colors.grey[800])),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SafeArea(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "Total Slots: $maxSlots",
                                style: GoogleFonts.yesevaOne(fontSize: 19),
                              ),
                            ),
                            Text("Booked: $bookedCount",
                                style: GoogleFonts.yesevaOne(fontSize: 19)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: TextField(
                        controller: nameController,
                        decoration: InputDecoration(
                            label: Text(
                              " P A T I E N T   N A M E",
                              style: GoogleFonts.yesevaOne(),
                            ),
                            hintText: ("E N T E R   P A T I E N T   N A M E"),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .9,
                      child: ElevatedButton(
                        onPressed: availableSlots > 0 ? bookSlot : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              Colors.grey[800], // Button background color
                          foregroundColor: Colors.white, // Text/icon color
                          padding: const EdgeInsets.symmetric(
                              horizontal: 24, vertical: 12),
                          textStyle: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                        child: Text(
                          "C O N F I R M    B O O K I N G",
                          style: GoogleFonts.yesevaOne(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text("A V A I L A B L E:  $availableSlots",
                        style: GoogleFonts.yesevaOne(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: availableSlots > 0
                                ? Colors.green
                                : Colors.red)),
                  ],
                )

                // Column(
                //   crossAxisAlignment: CrossAxisAlignment.start,
                //   children: [
                //
                //     const SizedBox(height: 8),
                //
                //
                //
                //     const SizedBox(height: 20),
                //
                //     const SizedBox(height: 20),
                //

                // ),
                ),
      ),
    );
  }
}
