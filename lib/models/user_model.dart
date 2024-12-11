class User {
  final String firstName;
  final String lastName;
  final String username;
  final String email;
  final String password;
  final String phone;
  final int age;
  final String role;
  final String city;

  User({
    required this.firstName,
    required this.lastName,
    required this.username,
    required this.email,
    required this.password,
    required this.phone,
    required this.age,
    required this.role,
    required this.city,
  });

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'username': username,
      'email': email,
      'password': password,
      'phone': phone,
      'age': age,
      'role': role,
      'city': city,
    };
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      firstName: json['firstName'],
      lastName: json['lastName'],
      username: json['username'],
      email: json['email'],
      password: json['password'],
      phone: json['phone'],
      age: json['age'],
      role: json['role'],
      city: json['city'],
    );
  }
}
