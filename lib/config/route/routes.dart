import 'package:flutter/material.dart';
import 'package:machine_test_practice/features/auth/presentation/pages/sign_in_page.dart';
import 'package:machine_test_practice/features/home/presentation/pages/home_page.dart';

class Routes {
  Routes._();

  static const String homePage = '/home_page';
  static const String signInPage = '/sign_in_page';

  static final dynamic route = <String, WidgetBuilder>{
    homePage: (BuildContext context) => const HomePage(),
    signInPage: (BuildContext context) => const SignInPage(fromSplash: true),
  };
}
