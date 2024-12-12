import 'package:book_tour_app/screens/auth/accessPage/accessPage.dart';
import 'package:book_tour_app/screens/auth/login/auth_login.dart';
import 'package:book_tour_app/screens/auth/signup/auth_signup.dart';
import 'package:book_tour_app/screens/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';

class RouterApp {
  static const String accessPageRoute = '/page';
  static const String loginRoute = '/login';
  static const String signupRoute = '/signup';
  static const String dashboardRoute = '/dashboard';

  static Map<String, WidgetBuilder> routes = {
    accessPageRoute: (context) => const AccessPage(),
    loginRoute: (context) => const AuthLogin(),
    signupRoute: (context) => const AuthSignup(),
    dashboardRoute: (context) => const DashboardPage(),
  };
}
