class DoctorModel {
  final String doctorId;
  final String name;
  final String availableTime;
  final int maxSlots;

  DoctorModel({
    required this.doctorId,
    required this.name,
    required this.availableTime,
    required this.maxSlots,
  });

  // Factory constructor to create a DoctorModel from Firestore data
  factory DoctorModel.fromFirestore(Map<String, dynamic> data, String doctorId) {
    return DoctorModel(
      doctorId: doctorId,
      name: data['name'],
      availableTime: data['availableTime'],
      maxSlots: data['maxSlots'],
    );
  }

  // Method to convert DoctorModel to a map for Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'availableTime': availableTime,
      'maxSlots': maxSlots,
    };
  }
}
