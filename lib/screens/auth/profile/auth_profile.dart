import 'package:book_tour_app/models/auth_profile_model.dart';
import 'package:book_tour_app/services/auth_service.dart';
import 'package:flutter/material.dart';

class AuthProfileScreen extends StatefulWidget {
  const AuthProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  _UserProfileScreenState createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<AuthProfileScreen> {
  late Future<UserProfile> _userProfileFuture;

  @override
  void initState() {
    super.initState();
    _userProfileFuture = AuthService.getUserProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
        backgroundColor: Color(0xFFFF9900), // Main theme color for AppBar
      ),
      body: FutureBuilder<UserProfile>(
        future: _userProfileFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData) {
            return const Center(child: Text('No data found'));
          }

          final userProfile = snapshot.data!;
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Name Section
                Text(
                  'Name: ${userProfile.fullName.firstName} ${userProfile.fullName.lastName}',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFFF9900), // Color for text
                  ),
                ),
                const SizedBox(height: 8),
                
                // Age and City Section
                Text(
                  'Age: ${userProfile.age}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  'City: ${userProfile.city}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 16),

                // Contact Section
                Text(
                  'Email: ${userProfile.contact.email}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                Text(
                  'Phone: ${userProfile.contact.phone}',
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
                const SizedBox(height: 16),

                // Reviews Section
                if (userProfile.reviews.isNotEmpty)
                  ...userProfile.reviews
                      .map((review) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Text(
                              'Review: $review',
                              style: TextStyle(fontSize: 16, color: Colors.black),
                            ),
                          )),
              ],
            ),
          );
        },
      ),
    );
  }
}
