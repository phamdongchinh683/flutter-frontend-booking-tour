import 'package:book_tour_app/screens/auth/forgotPassword/auth_forgot_pasword.dart';
import 'package:book_tour_app/screens/auth/login/auth_login.dart';
import 'package:book_tour_app/screens/auth/mybooked/my_booked.dart';
import 'package:book_tour_app/screens/auth/profile/auth_profile.dart';
import 'package:book_tour_app/screens/auth/signup/auth_signup.dart';
import 'package:book_tour_app/screens/auth/updatePassword/auth_update_password.dart';
import 'package:book_tour_app/screens/dashboard/dashboard_page.dart';
import 'package:book_tour_app/screens/onboardingScreen/onboarding_screen.dart';
import 'package:book_tour_app/screens/tour/booktoour/book_tour.dart';
import 'package:book_tour_app/screens/tour/tour_app.dart';
import 'package:flutter/material.dart';

class RouterApp {
  static const String onBoardingScreenRoute = '/page';
  static const String loginRoute = '/login';
  static const String forgotPasswordRoute = '/forgot-password';
  static const String updateNewpasswordRoute = '/update-new-password';
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
    forgotPasswordRoute: (context) => const AuthForgotPassword(),
    updateNewpasswordRoute: (context) => const AuthUpdatePassword(),
    dashboardRoute: (context) => const DashboardPage(),
    myProfileRoute: (context) => const AuthProfileScreen(),
    myBookedRoute: (context) => MyBooked(),
    tourDetailRoute: (context) {
      final String tourId =
          ModalRoute.of(context)?.settings.arguments as String;
      return TourApp(id: tourId);
    },
    bookTourRoute: (context) {
      final String tourId =
          ModalRoute.of(context)?.settings.arguments as String;
      return BookTourScreen(tourId: tourId);
    },
  };
}
