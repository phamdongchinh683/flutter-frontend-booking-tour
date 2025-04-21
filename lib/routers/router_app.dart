import 'package:book_tour_app/screens/auth/login/auth_login.dart';
import 'package:book_tour_app/screens/auth/mybooked/my_booked.dart';
import 'package:book_tour_app/screens/auth/profile/auth_profile.dart';
import 'package:book_tour_app/screens/auth/signup/auth_signup.dart';
import 'package:book_tour_app/screens/dashboard/dashboard_page.dart';
import 'package:book_tour_app/screens/onboardingScreen/onboarding_screen.dart';
import 'package:book_tour_app/screens/tour/booktoour/book_tour.dart';
import 'package:book_tour_app/screens/tour/tour_app.dart';
import 'package:flutter/material.dart';

class RouterApp {
  static const String onBoardingScreenRoute = '/';
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String dashboardRoute = '/dashboard';
  static const String tourDetailRoute = "/detail_tour";
  static const String bookTourRoute = "/book_tour";
  static const String myBookedRoute = "/my_booked";
  static const String myProfileRoute = "/profile";

  static Map<String, WidgetBuilder> routes = {
    onBoardingScreenRoute: (context) => const OnboardingScreen(),
    loginRoute: (context) => const AuthLogin(),
    signupRoute: (context) => const AuthSignup(),
    dashboardRoute: (context) => const DashboardPage(),
    myProfileRoute: (context) => const AuthProfileScreen(),
    myBookedRoute: (context) => MyBooked(),
    tourDetailRoute: (context) {
      final String tourId =
          ModalRoute.of(context)?.settings.arguments as String;
      return TourApp(id: tourId);
    },
    bookTourRoute: (context) {
      final args =
          ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>;
      final String tourId = args['tourId'] as String;
      final int totalPrice = args['totalPrice'] as int;
      final int totalPeople = args['totalPeople'] as int;
      return BookTourScreen(
          tourId: tourId, totalPrice: totalPrice, totalPeople: totalPeople);
    },
  };
}
