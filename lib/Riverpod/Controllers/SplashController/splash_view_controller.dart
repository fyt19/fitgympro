import 'dart:async';
import 'package:fitgympro/Models/splash_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class SplashState {
  final int currentIndex;
  SplashState({this.currentIndex = 0});

  SplashState copyWith({int? currentIndex}) =>
      SplashState(currentIndex: currentIndex ?? this.currentIndex);
}

class SplashViewController extends StateNotifier<SplashState> {
  SplashViewController() : super(SplashState());

  final List<SplashContent> contents = [
    SplashContent(
      title: "Smart ",
      titleColored: "Workouts",
      description:
          "Artificial intelligence automatically creates workouts that best suit your goals and level.",
      image: 'assets/images/intro1.jpg',
    ),
    SplashContent(
      title: "Perfect Your ",
      titleColored: "Form",
      description:
          "Artificial intelligence analyzes your movements and tracks your progress.",
      image: 'assets/images/intro2.jpg',
    ),
    SplashContent(
      title: "Create a ",
      titleColored: "Sustainable",
      description:
          "Dynamic plans tailored to your personal goals, schedule, and fitness level.",
      image: 'assets/images/intro3.jpg',
    ),
    SplashContent(
      title: "Set Your Goals and ",
      titleColored: "Let's Get Started",
      description:
          "We have a few questions to create the program that's best for you.",
      image: 'assets/images/intro4.jpg',
    ),
  ];

  Timer? _timer;
  void setIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void updateIndex(int index) {
    state = state.copyWith(currentIndex: index);
  }
}
