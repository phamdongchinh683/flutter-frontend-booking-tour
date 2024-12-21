class UserProfile {
  final String id;
  final FullName fullName;
  final String age;
  final String city;
  final Contact contact;
  final List<dynamic> reviews;

  UserProfile({
    required this.id,
    required this.fullName,
    required this.age,
    required this.city,
    required this.contact,
    required this.reviews,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      id: json['_id'],
      fullName: FullName.fromJson(json['fullName']),
      age: json['age'],
      city: json['city'],
      contact: Contact.fromJson(json['contact']),
      reviews: json['reviews'] ?? [],
    );
  }
}

class FullName {
  final String firstName;
  final String lastName;

  FullName({
    required this.firstName,
    required this.lastName,
  });

  factory FullName.fromJson(Map<String, dynamic> json) {
    return FullName(
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}

class Contact {
  final String email;
  final String phone;

  Contact({
    required this.email,
    required this.phone,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      email: json['email'],
      phone: json['phone'],
    );
  }
}
