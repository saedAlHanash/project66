import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/injection/injection_container.dart';
import '../features/home/ui/pages/home_page.dart';
import '../features/home/ui/pages/splash_screen_page.dart';
import '../features/scan/data/scan.dart';
import '../features/scan/ui/pages/search_page.dart';

final goRouter = GoRouter(
  navigatorKey: sl<GlobalKey<NavigatorState>>(),
  routes: [
    //region splash
    ///Splash
    GoRoute(
      path: RouteName.splash,
      name: RouteName.splash,
      builder: (_, state) {
        return const SplashScreenPage();
      },
    ),

    //endregion

    //region home

    ///
    GoRoute(
      path: RouteName.home,
      name: RouteName.home,
      builder: (_, state) {
        return const HomePage();
      },
    ),

    ///
    GoRoute(
      path: RouteName.search,
      name: RouteName.search,
      builder: (_, state) {
        return SearchPage(
          list: state.extra as List<ScanModel>,
          name: state.uri.queryParameters['name'] ?? '',
        );
      },
    ),

    //endregion

    // GoRoute(
    //   path: RouteName.,
    //   name: RouteName.,
    //   builder: (_, state) {
    //
    //   },
    // ),
  ],
);

class RouteName {
  static const splash = '/';
  static const search = '/search';
  static const home = '/home';
  static const forgetPassword = '/forgetPassword';
  static const resetPasswordPage = '/resetPasswordPage';
  static const login = '/login';
  static const signup = '/signup';
  static const confirmCode = '/confirmCode';
  static const otpPassword = '/otpPassword';
  static const donePage = '/donePage';
  static const searchShipment = '/searchShipment';
  static const updateProfile = '/updateProfile';
  static const createShipment = '/createShipment';
  static const notifications = '/notifications';
  static const map = '/map';
  static const portfolio = '/portfolio';
  static const optionalPortfolio = '/optionalPortfolio';
  static const shortList = '/shortList';
  static const offers = '/offers';
  static const offer = '/offer';
  static const bank = '/bank';
  static const pdfView = '/pdfView';
  static const applyOffer = '/applyOffer';
  static const fav = '/fav';
}
