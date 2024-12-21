class Guide {
  final String id;
  final FullName fullName;

  Guide({required this.id, required this.fullName});

  factory Guide.fromJson(Map<String, dynamic> json) {
    return Guide(
      id: json['_id'],
      fullName: FullName.fromJson(json['fullName']),
    );
  }
}

class FullName {
  final String firstName;
  final String lastName;

  FullName({required this.firstName, required this.lastName});

  factory FullName.fromJson(Map<String, dynamic> json) {
    return FullName(
      firstName: json['firstName'],
      lastName: json['lastName'],
    );
  }
}
