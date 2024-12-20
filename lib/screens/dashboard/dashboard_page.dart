import 'package:book_tour_app/screens/home/home_screen.dart';
import 'package:flutter/material.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

final List<Widget> pages = [
  HomeScreen(),
];

class _DashboardPageState extends State<DashboardPage> {
  var currentPageIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: pages[currentPageIndex],
        bottomNavigationBar: NavigationBar(
          onDestinationSelected: (int index) {
            setState(() {
              currentPageIndex = index;
            });
          },
          indicatorColor: Colors.amber,
          selectedIndex: currentPageIndex,
          destinations: const <Widget>[
            NavigationDestination(
              selectedIcon: Icon(Icons.home_filled),
              icon: Icon(Icons.home_outlined),
              label: '',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.bookmark),
              icon: Icon(Icons.bookmark),
              label: '',
            ),
            NavigationDestination(
              selectedIcon: Icon(Icons.notifications_sharp),
              icon: Icon(Icons.notifications_sharp),
              label: '',
            ),
          ],
        ));
  }
}
