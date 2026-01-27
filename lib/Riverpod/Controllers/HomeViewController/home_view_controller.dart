import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

class HomeState {
  final bool isPremium;
  final String userName;
  final double sleepProgress;
  final double heartRateProgress;
  final double exerciseProgress;
  final int calories;

  HomeState({
    this.isPremium = true,
    this.userName = "Jhon Doe",
    this.sleepProgress = 0.84,
    this.heartRateProgress = 0.52,
    this.exerciseProgress = 0.27,
    this.calories = 2250,
  });

  HomeState copyWith({
    bool? isPremium,
    String? userName,
    double? sleepProgress,
    double? heartRateProgress,
    double? exerciseProgress,
    int? calories,
  }) {
    return HomeState(
      isPremium: isPremium ?? this.isPremium,
      userName: userName ?? this.userName,
      sleepProgress: sleepProgress ?? this.sleepProgress,
      heartRateProgress: heartRateProgress ?? this.heartRateProgress,
      exerciseProgress: exerciseProgress ?? this.exerciseProgress,
      calories: calories ?? this.calories,
    );
  }
}

class HomeViewController extends StateNotifier<HomeState> {
  HomeViewController() : super(HomeState());
}
