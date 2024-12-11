import 'package:book_tour_app/routers/router_app.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tour Booking App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RouterApp.accessPageRoute,
      routes: RouterApp.routes,
    );
  }
}
