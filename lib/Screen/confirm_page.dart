import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';

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

  // Function to generate PDF
  Future<void> _generatePdf() async {
    final pdf = pw.Document();

    pdf.addPage(pw.Page(
      build: (pw.Context context) {
        return pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text('Booking Confirmation',
                style:
                    pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
            pw.SizedBox(height: 10),
            pw.Text('Patient Name: $patientName',
                style: pw.TextStyle(fontSize: 18)),
            pw.Text('Hospital Name: $hospitalName',
                style: pw.TextStyle(fontSize: 18)),
            pw.Text('Doctor Name: $doctorName',
                style: pw.TextStyle(fontSize: 18)),
            pw.Text('Slot: $slot', style: pw.TextStyle(fontSize: 18)),
            pw.Text('Booking Number: $bookingNumber',
                style: pw.TextStyle(fontSize: 18)),
          ],
        );
      },
    ));

    // Save the PDF file and show download options
    await Printing.sharePdf(
        bytes: await pdf.save(), filename: 'Booking_Confirmation.pdf');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Booking Confirmation')),
      body: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Card(
          elevation: 19,
          child: Container(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.5,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.grey.shade100, Colors.blue.shade800],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Patient Name: $patientName",
                      style: GoogleFonts.yesevaOne(fontSize: 26),
                    ),
                  ),
                ),
                Divider(height: 30, thickness: 3, color: Colors.black),
                Center(
                  child: Text(
                    hospitalName,
                    style: GoogleFonts.yesevaOne(
                        fontSize: MediaQuery.of(context).size.width * 0.04),
                  ),
                ),
                SizedBox(height: 20),
                Align(
                  alignment: Alignment.topLeft,
                  child: Center(
                    child: Text(
                      " D O C T O R :$doctorName",
                      style: GoogleFonts.yesevaOne(
                          fontSize: MediaQuery.of(context).size.width * 0.04),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.width * 0.06,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Center(
                      child: Text(
                    slot,
                    style: GoogleFonts.yesevaOne(
                        fontSize: MediaQuery.of(context).size.width * 0.08,
                        color: Colors.red),
                  )),
                ),
                Text(
                  "NO:${bookingNumber}",
                  style: GoogleFonts.yesevaOne(fontSize: 20),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _generatePdf,
                  child: Text('Download Booking Details'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
