import 'package:fitgympro/Riverpod/Controllers/HomeViewController/home_view_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'SplashController/splash_view_controller.dart';
import 'OnboardViewController/onboard_view_controller.dart';

class AllControllers {
  // Splash (Intro) Controller
  static final splashViewController =
      StateNotifierProvider<SplashViewController, SplashState>((ref) {
        return SplashViewController();
      });

  // Onboarding (Login & Questions) Controller
  static final onboardViewController =
      StateNotifierProvider<OnboardViewController, OnboardViewModel>((ref) {
        return OnboardViewController(ref);
      });

  static final homeViewController =
      StateNotifierProvider<HomeViewController, HomeState>(
        (ref) => HomeViewController(),
      );
}
