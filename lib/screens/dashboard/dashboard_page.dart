import 'package:book_tour_app/screens/auth/mybooked/my_booked.dart';
import 'package:book_tour_app/screens/home/home_screen.dart';
import 'package:book_tour_app/storage/secure_storage.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

final List<Widget> pages = [
  HomeScreen(),
  MyBooked(),
];

class _DashboardPageState extends State<DashboardPage> {
  var currentPageIndex = 0;

  Future<void> _logout() async {
    await SecureStorage().deleteToken();
    Navigator.pushReplacementNamed(context, '/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[currentPageIndex],
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (int index) {
          if (index == 2) {
            _logout();
          } else {
            setState(() {
              currentPageIndex = index;
            });
          }
        },
        indicatorColor: Colors.amber,
        selectedIndex: currentPageIndex,
        destinations: const <Widget>[
          NavigationDestination(
            selectedIcon: Icon(Icons.home_filled),
            icon: Icon(Icons.home_outlined),
            label: 'Home',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.bookmark),
            icon: Icon(Icons.bookmark_border),
            label: 'My Booked',
          ),
          NavigationDestination(
            selectedIcon: Icon(Icons.logout),
            icon: Icon(Icons.logout),
            label: 'Logout',
          ),
        ],
      ),
    );
  }
}
