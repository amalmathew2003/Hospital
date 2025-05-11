class Hospital {
  final String name;
  final String district;
  final String location;
  final String type;
  final String image; // New field for image URL

  Hospital({
    required this.name,
    required this.district,
    required this.location,
    required this.type,
    required this.image, // Include in constructor
  });

  // Factory constructor to create a Hospital object from Firestore document data
  factory Hospital.fromFirestore(Map<String, dynamic> firestoreDoc) {
    return Hospital(
      name: firestoreDoc['name'] ?? '',
      district: firestoreDoc['district'] ?? '',
      location: firestoreDoc['location'] ?? '',
      type: firestoreDoc['type'] ?? '',
      image: firestoreDoc['i'] ?? '', // Fetch image field
    );
  }

  // Method to convert the object into a Map
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'district': district,
      'location': location,
      'type': type,
      'i': image, // Include image in map
    };
  }
}
