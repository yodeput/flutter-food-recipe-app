import 'package:flutter/material.dart';
import 'package:foods_yodeput/pages/application/index.dart';
import 'package:foods_yodeput/pages/detail/index.dart';
import 'package:foods_yodeput/pages/welcome/index.dart';
import 'package:foods_yodeput/pages/splash/index.dart';
import 'package:get/get.dart';
import 'routes.dart';

class AppPages {
  static const INITIAL = AppRoutes.INITIAL;
  static final RouteObserver<Route> observer = RouteObservers();
  static List<String> history = [];

  static final List<GetPage> routes = [
    // SPLASH
    GetPage(
      name: AppRoutes.INITIAL,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.WELCOME,
      page: () => WelcomePage(),
      binding: WelcomeBinding(),
    ),
    GetPage(
      name: AppRoutes.APP,
      page: () => ApplicationPage(),
      binding: ApplicationBinding(),
    ),
    GetPage(
      name: AppRoutes.DETAIL,
      page: () => DetailPage(),
      binding: DetailBinding(),
    ),
  ];
}
