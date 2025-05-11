import 'package:cloud_firestore/cloud_firestore.dart';

class BookingModel {
  final String bookingId;
  final String patientName;
  final String slot;
  final String bookingNumber;
  final Timestamp timestamp;

  BookingModel({
    required this.bookingId,
    required this.patientName,
    required this.slot,
    required this.bookingNumber,
    required this.timestamp,
  });

  factory BookingModel.fromFirestore(
      Map<String, dynamic> data, String bookingId) {
    return BookingModel(
      bookingId: bookingId,
      patientName: data['patientName'],
      slot: data['slot'],
      bookingNumber: data['bookingNumber'],
      timestamp: data['timestamp'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'patientName': patientName,
      'slot': slot,
      'bookingNumber': bookingNumber,
      'timestamp': timestamp,
    };
  }
}
