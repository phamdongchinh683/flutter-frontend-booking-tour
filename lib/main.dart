import 'package:book_tour_app/routers/router_app.dart';
import 'package:book_tour_app/storage/secure_storage.dart';
import 'package:cloudinary_flutter/cloudinary_context.dart';
import 'package:cloudinary_url_gen/cloudinary.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Required for async calls in main
  CloudinaryContext.cloudinary =
      Cloudinary.fromCloudName(cloudName: 'dybpeirtu');
  CloudinaryContext.cloudinary.config.urlConfig.secure = true;

  // Check token availability before running the app
  final token = await SecureStorage().retrieveToken();

  runApp(MyApp(token: token));
}

class MyApp extends StatelessWidget {
  final String? token;

  const MyApp({Key? key, required this.token}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tour Booking App',
      theme: ThemeData(
        fontFamily: 'Ubuntu',
      ),
      initialRoute: token != null && token!.isNotEmpty
          ? RouterApp.onBoardingScreenRoute
          : RouterApp.loginRoute,
      routes: RouterApp.routes,
    );
  }
}
