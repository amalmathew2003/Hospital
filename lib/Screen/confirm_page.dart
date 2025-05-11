import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BookingConfirmationPage extends StatelessWidget {
  final String hospitalName;
  final String doctorName;
  final String patientName;
  final String slot;
  final String bookingNumber;

  const BookingConfirmationPage({
    super.key,
    required this.hospitalName,
    required this.doctorName,
    required this.patientName,
    required this.slot,
    required this.bookingNumber,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Confirmation')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Container(width: double.infinity,
          height: MediaQuery.of(context).size.height*.7,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.grey.shade100, Colors.grey.shade700
            ] , begin: Alignment.topLeft,
              end: Alignment.bottomRight,),
            borderRadius: BorderRadius.circular(20)
          ),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text("${patientName}",style: GoogleFonts.yesevaOne(fontSize: 27),),
              ),
              Divider(
                height: 30,thickness: 3,color: Colors.black,
              ),
              Text("${hospitalName}",style:GoogleFonts.yesevaOne(fontSize: 20),),
              SizedBox(height: 10,),
              Align(alignment: Alignment.topLeft,
                  child: Text("   D O C T O R :${doctorName}",style:GoogleFonts.yesevaOne(fontSize: 18) ,))

            ],
          ),
        )
            // crossAxisAlignment: CrossAxisAlignment.start,
            // children: [
            //   Text('Hospital: $hospitalName', style: TextStyle(fontSize: 18)),
            //   SizedBox(height: 10),
            //   Text('Doctor: $doctorName', style: TextStyle(fontSize: 18)),
            //   SizedBox(height: 10),
            //   Text('Patient: $patientName', style: TextStyle(fontSize: 18)),
            //   SizedBox(height: 10),
            //   Text('Slot: $slot', style: TextStyle(fontSize: 18)),
            //   SizedBox(height: 10),
            //   Text('Booking Number: $bookingNumber', style: TextStyle(fontSize: 18)),
            // ],
            ),

    );
  }
}
