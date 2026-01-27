import 'package:flutter/material.dart';
import '../../View/SplashView/splash_view.dart';
import '../../View/OnboardView/onboard_view.dart';
import '../../View/HomeView/home_view.dart';
import '../../View/NotificationsView/notifications_view.dart';

class AppRoutes {
  // Rota İsimleri (Doküman Sayfa 12 ile uyumlu) [cite: 284, 285, 286]
  static const String splash = "/splash";
  static const String onboard = "/onboarding";
  static const String home = "/home";
  static const String notifications = "/notifications";

  // Rota Eşleşmeleri [cite: 289, 290, 291]
  static Map<String, Widget Function(BuildContext)> routes = {
    splash: (_) => const SplashView(),
    onboard: (_) => const OnboardView(),
    home: (_) => const HomeView(),
    notifications: (_) => const NotificationsView(),
  };
}
