import 'package:book_tour_app/routers/router_app.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter/material.dart';

void main() {
  CloudinaryContext.cloudinary =
      Cloudinary.fromCloudName(cloudName: 'dybpeirtu');
  CloudinaryContext.cloudinary.config.urlConfig.secure = true;
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
        fontFamily: 'Ubuntu',
      ),
      initialRoute: RouterApp.onBoardingScreenRoute,
      routes: RouterApp.routes,
    );
  }
}
